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

module ex_default_csr_avmm_slave(
 
// AVMM Slave Interface
   input               clk,
   input               reset_n,
   input  logic [63:0] writedata,
   input  logic        read,
   input  logic        write,
   input  logic [7:0]  byteenable,
   output logic [63:0] readdata,
   output logic        readdatavalid,
   input  logic [31:0] address,
   input  logic        poison,
   output logic        waitrequest
);


 logic [31:0] csr_test_reg;
 logic [63:0] mask ;
 logic config_access; 

 assign mask[7:0]   = byteenable[0]? 8'hFF:8'h0; 
 assign mask[15:8]  = byteenable[1]? 8'hFF:8'h0; 
 assign mask[23:16] = byteenable[2]? 8'hFF:8'h0; 
 assign mask[31:24] = byteenable[3]? 8'hFF:8'h0; 
 assign mask[39:32] = byteenable[4]? 8'hFF:8'h0; 
 assign mask[47:40] = byteenable[5]? 8'hFF:8'h0; 
 assign mask[55:48] = byteenable[6]? 8'hFF:8'h0; 
 assign mask[63:56] = byteenable[7]? 8'hFF:8'h0; 
 assign config_access = address[21];  


//Terminating extented capability header
 localparam EX_CAP_HEADER  = 32'h00000000;


//Write logic
always @(posedge clk) begin
    if (!reset_n) begin
        csr_test_reg <= 32'h0;
    end
    else begin
        if (write && (address == 22'h0000) && ~poison) begin 
           csr_test_reg <= (writedata[31:0] & mask[31:0]) | (csr_test_reg & ~mask[31:0]);
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
        if (read && (address[21:0] == 22'h0)) begin 
           readdata <= csr_test_reg & mask[31:0];
        end
        else if(read && (address[20:0] == 21'h00E00) && config_access) begin //In ED PF1 capability chain with HEADER E00 terminate here with data zero 
           readdata <= {EX_CAP_HEADER} & mask;
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
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5KQ4oVmp4bj5u4o4hL7xxyTawmYFrDz/eVZohhTS1P52w2cKBxxeuCITw/b2Nts53W6Ar7zReGsVmPLgOhYU3YG91i7lMaPaPKfiLsT+EHP3g4VQ16od+fEp5Rquwiz6nS7a9UsQS/z2EKrsHe+EL3LX9ZgvQFGnjHRm+H6FYVWS3pVN9GDqg1S+obDEGubTEXoVxic7f26CGVYUro2odzHCI9MEnlm8WRSncY6OMa/H6IDD6dakH8+ojkFlhHyakbt8Ugoubg0DXzC6Dq/v3M3EiUq6utI8i+woTwC5uiHb5eKvkxuVdKhMrsu3llpSiGBJswkzgZh5uNx0urLWGyqnWarIa/QYxvo94tM3hL/0bT9WbWUgL2F84nu0Y8HYm76RT5C0bQmK9gp1t8WHY+q9JJiHCFftQgFYB7qCoMKhnK2Nd9cgIDxhBmE7TLBDv9DBmEK0Qdb0XQ6n5gWabc/sx7lcKtYxxSnq1TCLx9ORw6YXETq2RWXaLJw2f7npn1cXHN8OhldECsNCOjec9Apup3ODcILS2z0EwoIGvVEAyl/CLiJfw2EV7SDlc5RlZ22Nki8o02gNw70H9YXxLHHTgeoeT4/78hpdPsWCyiykrcrFZB0GssR66rJwVNsy6gWGPzX+tuaIONeOWOkSpsLT613pIWn03L+CscmmNnq/BsR8uVnJkElWHadCGVRE2IyFzIIfKU1EfogOejm0J7Hf3Mm282DARuD21HP20nqPnGymIhyGydOisSe4eRjdCspWjM8PaAZ6TTv6Y2POnt9"
`endif