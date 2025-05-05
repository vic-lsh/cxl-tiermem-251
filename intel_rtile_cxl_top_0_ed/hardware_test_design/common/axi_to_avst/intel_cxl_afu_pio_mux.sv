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
module intel_cxl_afu_pio_mux (
	
    input				    clk,
    input				    rstn,
    input   logic  [0:0]    afu_pio_select,         //afu_pio_select==1  ?  select  afu  else  pio
    input   logic  [0:0]    pio_tx_st_eop,                                                     
    input   logic  [127:0]  pio_tx_st_header,                                                  
    input   logic  [255:0]  pio_tx_st_payload,                                                 
    input   logic  [0:0]    pio_tx_st_sop,                                                     
    input   logic  [0:0]    pio_tx_st_hvalid,                                                  
    input   logic  [0:0]    pio_tx_st_dvalid,                                                  
    input   logic  [0:0]    afu_tx_st_eop,                                                     
    input   logic  [127:0]  afu_tx_st_header,                                                  
    input   logic  [512:0]  afu_tx_st_payload,                                                 
    input   logic  [0:0]    afu_tx_st_sop,                                                     
    input   logic  [0:0]    afu_tx_st_hvalid,                                                  
    input   logic  [0:0]    afu_tx_st_dvalid,                                                  
    output  logic  [0:0]    avst_tx_st0_eop_o,                                                 
    output  logic  [127:0]  avst_tx_st0_header_o,                                              
    output  logic  [255:0]  avst_tx_st0_payload_o,                                             
    output  logic  [0:0]    avst_tx_st0_sop_o,                                                 
    output  logic  [0:0]    avst_tx_st0_hvalid_o,                                              
    output  logic  [0:0]    avst_tx_st0_dvalid_o,                                              
    output  logic  [0:0]    avst_tx_st0_ready_i,                                               
    output  logic  [0:0]    avst_tx_st1_eop_o,                                                 
    output  logic  [127:0]  avst_tx_st1_header_o,                                              
    output  logic  [255:0]  avst_tx_st1_payload_o,                                             
    output  logic  [0:0]    avst_tx_st1_sop_o,                                                 
    output  logic  [0:0]    avst_tx_st1_hvalid_o,                                              
    output  logic  [0:0]    avst_tx_st1_dvalid_o                                               
);


always_ff@(posedge clk) begin

	if(afu_pio_select) begin
		avst_tx_st0_eop_o   	<= 1'b0;
		avst_tx_st0_header_o	<= afu_tx_st_header;
		avst_tx_st0_payload_o	<= afu_tx_st_payload[255:0];
		avst_tx_st0_sop_o   	<= afu_tx_st_sop;
		avst_tx_st0_hvalid_o	<= afu_tx_st_hvalid;
		avst_tx_st0_dvalid_o	<= afu_tx_st_dvalid; 
		avst_tx_st1_eop_o   	<= afu_tx_st_eop; 
		avst_tx_st1_header_o	<= 128'h0; 
		avst_tx_st1_payload_o	<= afu_tx_st_payload[511:256]; 
		avst_tx_st1_sop_o   	<= 1'h0; 
		avst_tx_st1_hvalid_o	<= 1'h0; 
		avst_tx_st1_dvalid_o	<= afu_tx_st_dvalid; 
	end
	else begin
		avst_tx_st0_eop_o   	<= pio_tx_st_eop;
		avst_tx_st0_header_o	<= pio_tx_st_header;
		avst_tx_st0_payload_o	<= pio_tx_st_payload;
		avst_tx_st0_sop_o   	<= pio_tx_st_sop;
		avst_tx_st0_hvalid_o	<= pio_tx_st_hvalid;
		avst_tx_st0_dvalid_o	<= pio_tx_st_dvalid; 
		avst_tx_st1_eop_o   	<= 1'h0; 
		avst_tx_st1_header_o	<= 128'h0; 
		avst_tx_st1_payload_o	<= 256'h0; 
		avst_tx_st1_sop_o   	<= 1'h0; 
		avst_tx_st1_hvalid_o	<= 1'h0; 
		avst_tx_st1_dvalid_o	<= 1'h0; 
	end
end //always


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "xOiMljyL+uEG4POJPfCL4p5v8YxX3yRYbM/Lvsk+r2yHjggdh2qskEj/0KRQ3+PEhBaUYq1/BqG8Yv2Si7VVH0jVEPw5rrxpaRXSzzVL6+z1QOpVXV0BqMuMzgRIAm9iJBd56K7WBlHO+OiDPfSEju3siYKQ0p6m4nCaQ1Mu1bEKBRXapesxsjTaDwLjA2d6l7rjbnzSdjUNvgk8V++w225chQSu0hR3a9RzKBKy7+Gwkt7r36UEoKmIXY9piUJXYL5CQdtVf8sHpkCpK+ArwSzx5CBlS42hW1qBTs+emC0d4CuWQ9pKg2YSz/FV696fSqy/VmGH5JJB0HFbHkCIyhcF3Ouzkenb6VlBSR6VmGE/o8mhT7DTiiN9P3iSEQW63DF46XyEHwW6vcho3Kito8YL+WB9W9/j2o7YTUk1yrf8iJ4YGrxKohQDKrM5LeAsL84msPwEXPqQqMX4L5xpSNm7XXsWFsFxiPYP0g4zgtOLCwuorX0x3g7kgK0CJPLV58suLveQgq70nyoPkigjpeAThckNS7ycyphePq29L90a15rJyWF2CbKlrbwAusz/PPNYoGcrrbDbjk9KvXM9YVoJLaQAZfnUVBG92sC6cKuoIfSLIfTxw21tPw0SJ0y9WnDxQ+LP7g8jXtjYJ13x5A4I7Rexd7JLRzrC6/h75RPaX3pWvcqkBcgf4Np1F68G6ENJdIM/F/z7qmi9Y1bDQTeaYnM/s9qcARRebCShBipYmaFGFIAxwiTeL4dsfHdi6hSCX+nmWSOmZZnr+yAmyosMT2IizXh0THkxG7Bp3egBojT29NqGveMzB15gBf0qp3Bqh6kLxcuQGTMJcePBiasPl7uDR/04VQ9IJ5MwJms1wJS39vLwqBEhAe+a+HRPTgHz6OpO4sguy/BCwLCm0j9dqhIMxZ4FCiDdnN8ASkzuOYhksuFoh9oDhibWtMKDN3GuZE7tvqgCIu2U8wBT/Fyz1855a20N7FoYW5iFB/bw5QMni5v6jsdB7UYmJ+W4"
`endif