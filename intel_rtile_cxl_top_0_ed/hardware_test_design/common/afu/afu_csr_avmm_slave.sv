// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// Copyright 2023 Intel Corporation.
//
// THIS SOFTWARE MAY CONTAIN PREPRODUCTION CODE AND IS PROVIDED BY THE
// COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
// WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
// OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//




module afu_csr_avmm_slave(
 
// AVMM Slave Interface
   input               clk,
   input               reset_n,
   input  logic [31:0] writedata,
   input  logic        read,
   input  logic        write,
   input  logic [3:0]  byteenable,
   output logic [31:0] readdata,
   output logic        readdatavalid,
   input  logic [31:0] address,
   output logic        waitrequest
);


 logic [31:0] csr_test_reg;
 logic [31:0] mask ;

 assign mask[7:0]   = byteenable[0]? 8'hFF:8'h0; 
 assign mask[15:8]  = byteenable[1]? 8'hFF:8'h0; 
 assign mask[23:16] = byteenable[2]? 8'hFF:8'h0; 
 assign mask[31:24] = byteenable[3]? 8'hFF:8'h0; 
 
//Write logic
always @(posedge clk) begin
    if (!reset_n) begin
        csr_test_reg  <= 32'h0;
        
    end
    else begin
        if (write && (address == 32'h0)) begin 
           csr_test_reg <= writedata & mask;
        end
        else begin
           csr_test_reg <= csr_test_reg;
        end        
    end    
end 

//Read logic
always @(posedge clk) begin
    if (!reset_n) begin
        readdata  <= 32'h0;
    end
    else begin
        if (read && (address == 32'h0)) begin 
           readdata <= csr_test_reg & mask;
        end
        else begin
           readdata  <= 32'h0;
        end        
    end    
end 



//Control Logic
enum int unsigned { IDLE = 0,WRITE = 2, READ = 4 } state, next_state;

always_comb begin : next_state_logic
   next_state = IDLE;
      case(state)
      IDLE    : begin 
                   if( write ) begin
                       next_state = WRITE;
                   end
                   else begin
                     if (read) begin  
                       next_state = READ;
                     end
                     else begin
                       next_state = IDLE;
                     end
                   end 
                end
      WRITE     : begin
                   next_state = IDLE;
                end
      READ      : begin
                   next_state = IDLE;
                end
      default : next_state = IDLE;
   endcase
end


always_comb begin
   case(state)
   IDLE    : begin
               waitrequest  = 1'b1;
               readdatavalid= 1'b0;
             end
   WRITE     : begin 
               waitrequest  = 1'b0;
               readdatavalid= 1'b0;
             end
   READ     : begin 
               waitrequest  = 1'b0;
               readdatavalid= 1'b1;
             end
   default : begin 
               waitrequest  = 1'b1;
               readdatavalid= 1'b0;
             end
   endcase
end

always_ff@(posedge clk) begin
   if(~reset_n)
      state <= IDLE;
   else
      state <= next_state;
end

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "xOiMljyL+uEG4POJPfCL4p5v8YxX3yRYbM/Lvsk+r2yHjggdh2qskEj/0KRQ3+PEhBaUYq1/BqG8Yv2Si7VVH0jVEPw5rrxpaRXSzzVL6+z1QOpVXV0BqMuMzgRIAm9iJBd56K7WBlHO+OiDPfSEju3siYKQ0p6m4nCaQ1Mu1bEKBRXapesxsjTaDwLjA2d6l7rjbnzSdjUNvgk8V++w225chQSu0hR3a9RzKBKy7+HB0FigAldGuZueQOqhHmZf5dwnr2t5+eog1hsQTX8+XdjzGMP0LsVEJ7gUqoCMGAuPiG4KDZogjjECOqYt0qH1K/lZWXq9+JfNDS89oCBFcWhGp9CC+kCjq7AeuEI8oHRDlvAxH15bDg+IKDBNfeEw7pQKSd7FyOHOfhPLWRz+qip0Xxci43zXZ0sWGCkOZFf7Wr0RwW0hEXTEQScieR+9sHS4bu4Qo5b+JEJbhciaX+GP6IU9icGmqeRL/MLDK6b8hYQzzAQKMCUEG/5gWyZyLefwAc95SAReMii5rC9NC2hf7czELz0Vg44eaoOsWIWAU2f1ZL0uCF08Bki+MlADvHkytEnN58pmTPkeYQUxba7MAIWmxo8eqS+yYuSJPSYbBy6LdEeOneuq0jb2lTlefZbvxrObgTK6QniHK90pOWWMn8d/9qiemRVfZRId9eeKVZPkW2KzCxJFXdVgpJ31mKo5Z/9x6gA+yBaF2U3iWdYjDzTV3CKA9S9uhUwCrrSLK9wzuwNL6c9v+yRQsx3QlMhgb4LzCaSNGWBe81ZulhS7Grk1DFZVzapYemYErmQfZLN008ft3hgdK/nZfh55C8NW56zoWdjRM1TLdPQIWXyWG6HsWsyqJCLMdfjt8ktzkNYxYVKOUXNfR/Slk4MWehbxw8O37sclh4OhmSUnLsxhuVypnesXhz3pY2APn8UHg0vLL5+ZK+mEnp7dHuSqf6tO4BB/lxYixFTtRo8Zpv5UeRzBYJaZuDHj8n918Hi6wzX9/tJnStYaJpbyGA3v"
`endif