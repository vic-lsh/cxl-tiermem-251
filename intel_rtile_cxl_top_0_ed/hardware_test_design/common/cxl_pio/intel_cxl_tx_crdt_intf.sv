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


//------------------------------------------------------------
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
//------------------------------------------------------------

module intel_cxl_tx_crdt_intf
    (
     input logic          clk,
     input logic          rst_n,

     //tx hcrdt
     input   logic [2:0]       tx_st_hcrdt_update_i,
     input   logic [5:0]       tx_st_hcrdt_update_cnt_i,
     input   logic [2:0]       tx_st_hcrdt_init_i,
     output  logic [2:0]       tx_st_hcrdt_init_ack_o,

     //tx dcrdt
     input   logic [2:0]       tx_st_dcrdt_update_i,
     input   logic [11:0]      tx_st_dcrdt_update_cnt_i,
     input   logic [2:0]       tx_st_dcrdt_init_i,
     output  logic [2:0]       tx_st_dcrdt_init_ack_o,

     //
     input   logic             pio_tx_st_ready_i,
     output  logic             bam_tx_signal_ready_o,
     input   logic [9:0]       tx_hdr_i,   // to get the length. It will tell how many DW of data in this TLP. Connect to bam_txc_header_o[9:0] at sch level
     input   logic [7:0]       tx_hdr_type_i,
     input   logic 	       tx_hdr_valid_i,  // signal to tell the header is valid. Connect to bam_txc_valid_o
     input   logic 	       dc_tx_hdr_valid_i,  // signal to tell the header is valid. Connect to bam_txc_valid_o
	
     //credits available on tx side
     output logic [15:0]       tx_p_data_counter,
     output logic [15:0]       tx_np_data_counter,
     output logic [15:0]       tx_cpl_data_counter,
     output logic [12:0]       tx_p_header_counter,
     output logic [12:0]       tx_np_header_counter,
     output logic [12:0]       tx_cpl_header_counter

);


     logic [ 9:0]            tx_hdr_reg;
     logic                   tx_hdr_valid_reg;
     logic                   dc_tx_hdr_valid_reg;
     logic 		     state_rx_crdt_init;

     logic                   tx_p_data_infinite;
     logic                   tx_np_data_infinite;
     logic                   tx_cpl_data_infinite;
     logic                   tx_p_header_infinite;
     logic                   tx_np_header_infinite;
     logic                   tx_cpl_header_infinite;

     //tx hcrdt
     logic [2:0]             tx_st_hcrdt_update_reg;
     logic [5:0]             tx_st_hcrdt_update_cnt_reg;
     logic [2:0]             tx_st_hcrdt_init_reg;
     logic [2:0]             tx_st_hcrdt_init_ack_reply_reg;

     //tx dcrdt
     logic [2:0]             tx_st_dcrdt_update_reg;
     logic [11:0]            tx_st_dcrdt_update_cnt_reg;
     logic [2:0]             tx_st_dcrdt_init_reg;
     logic [2:0]             tx_st_dcrdt_init_ack_reply_reg;

     localparam [2:0]                      CRDT_IDLE         = 3'b010;
     localparam [2:0]                      TX_CRDT_INIT_CAP   = 3'b000;
     logic  [2:0] crdt_state;
     logic  [2:0] crdt_nxt_state;

     logic                   srst_reg;

    assign srst_reg        = ~rst_n;

    logic               p_tlp;
    logic               np_tlp;
    logic               cpl_tlp;
    logic               p_tlp_reg;
    logic               np_tlp_reg;
    logic               cpl_tlp_reg;

    assign p_tlp   = tx_hdr_valid_i & ((tx_hdr_type_i == 8'h60) | (tx_hdr_type_i == 8'h40 ));
    assign np_tlp  = tx_hdr_valid_i & ((tx_hdr_type_i == 8'h20) | (tx_hdr_type_i == 8'h00 ));
    assign cpl_tlp = tx_hdr_valid_i & ((tx_hdr_type_i == 8'h4A) | (tx_hdr_type_i == 8'h0A ));

    assign state_rx_crdt_init = 1'b0;

always_ff @(posedge clk)
  begin
    //srst_reg        <= ~rst_n;
    if (srst_reg) begin
      crdt_state                   <= CRDT_IDLE;
      tx_st_hcrdt_update_reg       <= 0 ;
      tx_st_hcrdt_update_cnt_reg   <= 0 ;
      tx_st_hcrdt_init_reg         <= 0 ;

      tx_st_dcrdt_update_reg       <= 0 ;
      tx_st_dcrdt_update_cnt_reg   <= 0 ;
      tx_st_dcrdt_init_reg         <= 0 ;
    end
    else begin
      crdt_state                   <= crdt_nxt_state;

      // capture all input ports	

      //tx header
      tx_st_hcrdt_update_reg            <= tx_st_hcrdt_update_i;
      tx_st_hcrdt_update_cnt_reg        <= tx_st_hcrdt_update_cnt_i;
      tx_st_hcrdt_init_reg              <= tx_st_hcrdt_init_i;

      //tx data
      tx_st_dcrdt_update_reg            <= tx_st_dcrdt_update_i;
      tx_st_dcrdt_update_cnt_reg        <= tx_st_dcrdt_update_cnt_i;
      tx_st_dcrdt_init_reg              <= tx_st_dcrdt_init_i;

     end
  end


  always_comb begin
    case(crdt_state)
      CRDT_IDLE: /// Idle Mode
         if((|tx_st_hcrdt_init_reg)||(|tx_st_dcrdt_init_reg))
           crdt_nxt_state = TX_CRDT_INIT_CAP;
         else
           crdt_nxt_state = CRDT_IDLE;

      TX_CRDT_INIT_CAP:   /// Return credit
         if(!((|tx_st_hcrdt_init_reg)||(|tx_st_dcrdt_init_reg)))
           crdt_nxt_state = CRDT_IDLE;
         else
           crdt_nxt_state = TX_CRDT_INIT_CAP;

       default:
         crdt_nxt_state = CRDT_IDLE;

    endcase
  end 


assign state_crdt_idle = (crdt_state == CRDT_IDLE);

always_ff @ (posedge clk or posedge srst_reg) begin  // TX dding to counter when updated
  if(srst_reg) begin
    tx_p_data_counter <= 0;
    tx_np_data_counter <= 0;
    tx_cpl_data_counter <= 0;
    tx_p_header_counter <= 0;
    tx_np_header_counter <= 0;
    tx_cpl_header_counter <= 0;
    tx_st_hcrdt_init_ack_reply_reg[2:0] <= 0;
    tx_st_dcrdt_init_ack_reply_reg[2:0] <= 0;
    tx_p_data_infinite <= 0;
    tx_np_data_infinite <= 0;
    tx_cpl_data_infinite <= 0;
    tx_p_header_infinite <= 0;
    tx_np_header_infinite <= 0;
    tx_cpl_header_infinite <= 0;
    p_tlp_reg <= 0;
    np_tlp_reg <= 0;
    cpl_tlp_reg <= 0;
    tx_hdr_reg <= 0;
    tx_hdr_valid_reg <= 0;
    dc_tx_hdr_valid_reg <= 0;
  end else begin

//-- completion credit

    // calculate cpl data credit
    if((tx_hdr_valid_reg && cpl_tlp_reg)&& (tx_st_dcrdt_update_i[2]) && (!state_rx_crdt_init)) begin  
      tx_cpl_data_counter <= tx_cpl_data_counter - tx_hdr_reg + tx_st_dcrdt_update_cnt_i[11:8] ;
    end
    else if ((tx_hdr_valid_reg && cpl_tlp_reg) && (!state_rx_crdt_init))
      tx_cpl_data_counter <= tx_cpl_data_counter - tx_hdr_reg ;
    else if(tx_st_dcrdt_update_i[2]) begin  
      tx_cpl_data_counter <= tx_cpl_data_counter + tx_st_dcrdt_update_cnt_i[11:8];
      if((tx_st_dcrdt_init_reg[2] == 1'b1)&&(tx_st_dcrdt_update_cnt_i[11:8] == 4'b0)) begin
        tx_cpl_data_infinite <= 1'b1;
      end
    end
    else begin
        tx_cpl_data_counter <= tx_cpl_data_counter;
    end

    // calculate cpl header credit
    if((tx_hdr_valid_reg && cpl_tlp_reg) && (dc_tx_hdr_valid_reg) && (tx_st_hcrdt_update_i[2]) && (!state_rx_crdt_init)) begin  
      tx_cpl_header_counter <= tx_cpl_header_counter - 13'h2 + tx_st_hcrdt_update_cnt_i[5:4] ;
    end
    else if((tx_hdr_valid_reg && cpl_tlp_reg) && (tx_st_hcrdt_update_i[2]) && (!state_rx_crdt_init)) begin  
      tx_cpl_header_counter <= tx_cpl_header_counter - 13'h1 + tx_st_hcrdt_update_cnt_i[5:4] ;
    end
    else if((dc_tx_hdr_valid_reg) && (tx_st_hcrdt_update_i[2]) && (!state_rx_crdt_init)) begin  
      tx_cpl_header_counter <= tx_cpl_header_counter - 13'h1 + tx_st_hcrdt_update_cnt_i[5:4] ;
    end
    else if ((tx_hdr_valid_reg && cpl_tlp_reg) && (!state_rx_crdt_init)) begin
      tx_cpl_header_counter <= tx_cpl_header_counter - 13'h1 ;
    end
    else if ((dc_tx_hdr_valid_reg) && (!state_rx_crdt_init)) begin
      tx_cpl_header_counter <= tx_cpl_header_counter - 13'h1 ;
    end
    else if(tx_st_hcrdt_update_i[2]) begin  
      tx_cpl_header_counter <= tx_cpl_header_counter + tx_st_hcrdt_update_cnt_i[5:4];
      if((tx_st_hcrdt_init_reg[2] == 1'b1)&&(tx_st_hcrdt_update_cnt_i[5:4] == 2'b0)) begin
        tx_p_header_infinite <= 1'b1;
      end
    end
    else begin
        tx_cpl_header_counter <= tx_cpl_header_counter;
    end


//--nonposted credit
    // calculate np data credit 
    if(tx_st_dcrdt_update_i[1]) begin  
      tx_np_data_counter <= tx_np_data_counter + tx_st_dcrdt_update_cnt_i[7:4];
      if((tx_st_dcrdt_init_reg[1] == 1'b1)&&(tx_st_dcrdt_update_cnt_i[7:4] == 4'b0)) begin
        tx_np_data_infinite <= 1'b1;
      end
    end

    // calculate np header credit
    if((tx_hdr_valid_reg && np_tlp_reg)&& (tx_st_hcrdt_update_i[1]) && (!state_rx_crdt_init)) begin  
      tx_np_header_counter <= tx_np_header_counter - 13'h1 + tx_st_hcrdt_update_cnt_i[3:2] ;
    end
    else if ((tx_hdr_valid_reg && np_tlp_reg) && (!state_rx_crdt_init)) begin
      tx_np_header_counter <= tx_np_header_counter - 13'h1 ;
    end
    else if(tx_st_hcrdt_update_i[1]) begin  
      tx_np_header_counter <= tx_np_header_counter + tx_st_hcrdt_update_cnt_i[3:2];
      if((tx_st_hcrdt_init_reg[1] == 1'b1)&&(tx_st_hcrdt_update_cnt_i[3:2] == 2'b0)) begin
        tx_np_header_infinite <= 1'b1;
      end
    end
    else begin
        tx_np_header_counter <= tx_np_header_counter;
    end



//--posted credit
    // calculate p data credit 
    if((tx_hdr_valid_reg && p_tlp_reg)&& (tx_st_dcrdt_update_i[0]) && (!state_rx_crdt_init)) begin  
      tx_p_data_counter <= tx_p_data_counter - tx_hdr_reg + tx_st_dcrdt_update_cnt_i[3:0] ;
    end
    else if ((tx_hdr_valid_reg && p_tlp_reg) && (!state_rx_crdt_init))
      tx_p_data_counter <= tx_p_data_counter - tx_hdr_reg ;
    else if(tx_st_dcrdt_update_i[0]) begin  
      tx_p_data_counter <= tx_p_data_counter + tx_st_dcrdt_update_cnt_i[3:0];
      if((tx_st_dcrdt_init_reg[0] == 1'b1)&&(tx_st_dcrdt_update_cnt_i[3:0] == 4'b0)) begin
        tx_p_data_infinite <= 1'b1;
      end
    end
    else begin
        tx_p_data_counter <= tx_p_data_counter;
    end
    
    // calculate p header credit
    if((tx_hdr_valid_reg && p_tlp_reg)&& (tx_st_hcrdt_update_i[0]) && (!state_rx_crdt_init)) begin  
      tx_p_header_counter <= tx_p_header_counter - 13'h1 + tx_st_hcrdt_update_cnt_i[1:0] ;
    end
    else if ((tx_hdr_valid_reg && p_tlp_reg) && (!state_rx_crdt_init)) begin
      tx_p_header_counter <= tx_p_header_counter - 13'h1 ;
    end
    else if(tx_st_hcrdt_update_i[0]) begin  
      tx_p_header_counter <= tx_p_header_counter + tx_st_hcrdt_update_cnt_i[1:0];
      if((tx_st_hcrdt_init_reg[0] == 1'b1)&&(tx_st_hcrdt_update_cnt_i[1:0] == 2'b0)) begin
        tx_p_header_infinite <= 1'b1;
      end
    end
    else begin
        tx_p_header_counter <= tx_p_header_counter;
    end

//--

  tx_hdr_reg <= (|tx_hdr_i[1:0]) ? ((tx_hdr_i >> 2) + 1'b1) : (tx_hdr_i >> 2);
  tx_hdr_valid_reg <= tx_hdr_valid_i;
  dc_tx_hdr_valid_reg <= dc_tx_hdr_valid_i;
  p_tlp_reg <= p_tlp;
  np_tlp_reg <= np_tlp;
  cpl_tlp_reg <= cpl_tlp;
  end

end

always_ff @ (posedge clk) begin
  if(srst_reg) begin

  end
  else begin
    if(((tx_p_header_counter < 4'h3) && (!tx_p_header_infinite)) || ((tx_p_data_counter < 4'h3) && (!tx_p_data_infinite)) || ((tx_np_header_counter < 4'h3) && (!tx_np_header_infinite)) || ((tx_np_data_counter < 4'h3) && (!tx_np_data_infinite)) || ((tx_cpl_header_counter < 4'h3) && (!tx_cpl_header_infinite)) || ((tx_cpl_data_counter < 4'h3) && (!tx_cpl_data_infinite))) // start to back pressure BAM
    bam_tx_signal_ready_o <= 1'b0;
    else 
    bam_tx_signal_ready_o <= pio_tx_st_ready_i;
  end
end


intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_p_data (
   .clk(clk), 
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_dcrdt_init_reg),
   .tx_st_init_reg(tx_st_dcrdt_init_reg[0]),
   .tx_st_init_ack_o(tx_st_dcrdt_init_ack_o[0])
   );
intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_np_data (
   .clk(clk),
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_dcrdt_init_reg),
   .tx_st_init_reg(tx_st_dcrdt_init_reg[1]),
   .tx_st_init_ack_o(tx_st_dcrdt_init_ack_o[1])
   );
intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_cpl_data (
   .clk(clk),
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_dcrdt_init_reg),
   .tx_st_init_reg(tx_st_dcrdt_init_reg[2]),
   .tx_st_init_ack_o(tx_st_dcrdt_init_ack_o[2])
   );
intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_p_header (
   .clk(clk),
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_hcrdt_init_reg),
   .tx_st_init_reg(tx_st_hcrdt_init_reg[0]),
   .tx_st_init_ack_o(tx_st_hcrdt_init_ack_o[0])
   );
intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_np_header (
   .clk(clk),
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_hcrdt_init_reg),
   .tx_st_init_reg(tx_st_hcrdt_init_reg[1]),
   .tx_st_init_ack_o(tx_st_hcrdt_init_ack_o[1])
   );
intel_pcie_bam_v2_crdt_tx_ack tx_st_ack_cpl_header (
   .clk(clk),
   .rst_n(rst_n),
   .state_tx_crdt_init_capture(|tx_st_hcrdt_init_reg),
   .tx_st_init_reg(tx_st_hcrdt_init_reg[2]),
   .tx_st_init_ack_o(tx_st_hcrdt_init_ack_o[2])
   );


endmodule

module intel_pcie_bam_v2_crdt_tx_ack  //reply init ack only
   (
     input logic          clk,
     input logic          rst_n,

     input logic	state_tx_crdt_init_capture,
     input logic 	tx_st_init_reg,
     output logic       tx_st_init_ack_o
   );

  logic                   tx_st_init_ack_reply_reg;
  logic                   srst_reg;

    assign srst_reg        = ~rst_n;
  always_ff @ (posedge clk) begin
//    srst_reg        <= ~rst_n;
    if (srst_reg) begin
      tx_st_init_ack_reply_reg <= 0;
      tx_st_init_ack_o <= 0;
    end
    else begin 
      if(state_tx_crdt_init_capture) begin 
        if(tx_st_init_reg) begin  //posted data   
           if(tx_st_init_ack_reply_reg == 0) begin 
             tx_st_init_ack_o <= 1;
             tx_st_init_ack_reply_reg <= 1;
           end  
           else begin  
             tx_st_init_ack_o <= 0;
           end 
        end 
        else begin 
          tx_st_init_ack_reply_reg <=0;
	    end 
      end  //posted data end 
      else begin
        tx_st_init_ack_o <= 0;
      end
    end 
  end 

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5JQYT0v7salB/R25MSjI0wtZgigW1Ph8XQLDD0odTbCL5BufhK6EmaWPxSDOs9jdSaHVfg7LiK5G6Y8IGAsKCcHj1v2ANeJ5fWkHIZvdxj+UREqW6+QbX1ElF7Llddo8H+rfKqG0IKwUXFwBUdNa7OD7RyoDloXVMJd/Af6YC9EwpeW47qoOtYqO1LyrPHTT+zapurVjiJ6LmDCq+GoFk3fFEcXhI6bpGK/JpArnYcv0Y3tTAFCLRvFS0YmUpDrri3MKk7+Hgnz9A4WwfUWm6lcHPI2zExyeG8wMbISzEQDbv5mLT3hPYqpcREj7mm70kw7rKdOAUhJbqb46Gx3sdtXEpWo08smEy8plJ3oqaEuzoohTPJ2WUvxys45LMf01GW5+Nmh1t7XEjLyE/HFyatA1+miVztjulGlbzL27xNX91nRPu4GTLvuMSee0fuNYms2PIV4y/OGVl53J4CyskhsRat25mdErUbN/uoYudEe9quJxaDtj8/jkbEhNps7qoVT2IrC4obV87KV7svBzRjCg/o0mbDdFxGaiqaacBWj3sP42kKRAxcz78BPj1Zc/JoqmQAHLCP9X7wchz6TCtpK9KP6gQiHzO5M/yX5aW6Dh5E7NfTLVN3n/Es3eY0dTnqhw2u7jsKv9uZWkjjLIdYKyiooo53HtBvRPDc2HgI1D9U4k6hptSsdIN2dtio/uImN8tc9+FuEdXLOceUaPPPY1ScsnkyqSCXG32QMmTMrfYWa9T4d/+dhThv5fyzrerpw3sW/TVvahcfMMis3Gea3"
`endif