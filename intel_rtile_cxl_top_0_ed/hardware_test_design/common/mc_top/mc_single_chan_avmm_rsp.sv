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


// Copyright 2024 Intel Corporation.
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
///////////////////////////////////////////////////////////////////////

module mc_single_chan_avmm_rsp
  import ddr_mc_top_common_pkg::*;
(
  input logic emifclk,                         // EMIF User Clock
  input logic emifresetn,                      // EMIF reset
  input logic emif_avmm_1_axi_0,
  input logic ram_init_done_del1_emifclk, 

  /* read id fifo and write id from EMIF AVMM FSM
  */
  input logic                                                     from_avmm_fsm_valid_write_id_emifclk,
  input logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0] from_avmm_fsm_write_id_emifclk,
  input logic                                                     from_avmm_fsm_valid_read_id_emifclk,
  input logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0] from_avmm_fsm_read_id_emifclk,
 
  /* AVMM signals from EMIF
  */
  input logic [ddr_mc_top_common_pkg::MCTOP_EMIF_AMM_DATA_WIDTH-1:0] from_emif_avmm_readdata_emifclk,
 
  input logic from_emif_avmm_readdatavalid_emifclk,

  /* write responses
  */
  output logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0] avmm_wr_rsp_id_emifclk,
 
  output logic avmm_wr_rsp_valid_emifclk,
 
  /* read responses
  */
  output logic [ddr_mc_top_common_pkg::MCTOP_EMIF_AMM_DATA_WIDTH-1:0] avmm_rd_rsp_data_emifclk,
  output logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0]    avmm_rd_rsp_id_emifclk,

  output logic avmm_rd_rsp_id_fifo_almost_full_emifclk,
  output logic avmm_rd_rsp_valid_emifclk
);

// ================================================================================================
/* handle write responses in one cycle
*/
logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0] avmm_wr_rsp_id_comb;

logic avmm_wr_rsp_valid_comb;

assign avmm_wr_rsp_id_comb = ~emif_avmm_1_axi_0
                             ? '0
                             : from_avmm_fsm_valid_write_id_emifclk
                               ? from_avmm_fsm_write_id_emifclk
                               : avmm_wr_rsp_id_emifclk;

assign avmm_wr_rsp_valid_comb = ~emif_avmm_1_axi_0
                                ? 1'b0
                                : from_avmm_fsm_valid_write_id_emifclk;

always_ff @( posedge emifclk )
begin
  avmm_wr_rsp_valid_emifclk <= ~emifresetn ? 1'b0 : avmm_wr_rsp_valid_comb;
     avmm_wr_rsp_id_emifclk <= ~emifresetn ?  '0  : avmm_wr_rsp_id_comb;
end
 
// ================================================================================================ 
/* Handle the read IDs - 
   for AVMM, all transactions go out in-order of arrival
   for AXI, transactions can go out-of-order from arrival
*/
logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0] rd_id_fifo_q;
logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0] rd_id_fifo_din;

logic [7:0]  rd_id_fifo_usedw;

logic rd_if_fifo_wen;
logic rd_id_fifo_empty;
logic rd_id_fifo_rd_enable;
logic rd_id_fifo_full;

assign rd_if_fifo_wen = emif_avmm_1_axi_0 & from_avmm_fsm_valid_read_id_emifclk;

assign rd_id_fifo_din = from_avmm_fsm_read_id_emifclk;

assign rd_id_fifo_rd_enable = emif_avmm_1_axi_0 & from_emif_avmm_readdatavalid_emifclk;

fifo_12b_256w_show_ahead     HdmReadIDAttrFifo
(
     .clock(   emifclk              ),
     .aclr(   ~emifresetn           ),
     .wrreq(   rd_if_fifo_wen       ),
     .data(    rd_id_fifo_din       ),
     .rdreq(   rd_id_fifo_rd_enable ),
     .q(       rd_id_fifo_q         ),
     .full(    rd_id_fifo_full      ),
     .usedw(   rd_id_fifo_usedw     ),
     .empty(   rd_id_fifo_empty     )
);

// ================================================================================================ 
logic rd_id_fifo_almost_full;

assign rd_id_fifo_almost_full = ( rd_id_fifo_usedw >= 'd248 );

always_ff @( posedge emifclk )
begin
   avmm_rd_rsp_id_fifo_almost_full_emifclk <= ~emifresetn ? 1'b0 : rd_id_fifo_almost_full;
end

// ================================================================================================ 
assign avmm_rd_rsp_valid_emifclk = from_emif_avmm_readdatavalid_emifclk;

assign avmm_rd_rsp_id_emifclk = rd_id_fifo_q;

assign avmm_rd_rsp_data_emifclk = from_emif_avmm_readdata_emifclk;

// ================================================================================================  
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5Kwhg39Ih7atT2Wbg+7FtjSeWJh9gPyRWdofOY482tBctb76vcnaaXFKVUiD8RsHwkQ2yCDjCD2nffMPtu5BH1u1WVpBSpwyx4PfruFXqHpjgQF0YcZI0KDFhWO7Pzk9V+nkws3jUMwMmEOR0waD+8XzYq7OwCtSZlb8v/e9rOJJ8jMnor0d5x8IPqdxu2M5BNWpiPXGsZqLLlCP8ZvoHGw8C57TqYGOh+GJPnOZzFpH9AVc78MsWR/7zey9XYHhQYaOuZelXAG7AOVKgHB3sFvyZTi6FjuaJ7uHQig3IokEbpl607Lcf7H9o8ReStofRV3Qk1AFa5Lt7CvEYiYy725Prbx5E5cKwYWtCzh36YmtD2cNWBpZFaM9oIOL0Wy5bagOTL7p4gmqULiStCNX/KnEQnMHnYnlnjsKK53avjfsCKZ7cz0rVGOgAxJpnr7zhz7BA8QgE0L0d9eFzHz9ISdFxKTtqqSBxlrFdxNCIV1PEamF9I4EH26p/aC9054WsDMqdPUOQlzwMUQbswkDPIbZHC3YFSrFP1SI8FWaniGgj+wAIj6lHOsgLEVV+QyiJPZriq4xueAeQa+djnDT8kmcl35kQMLtwatfHETvoVU4qcqxlkqQ2MdnjIOwE5cFoeXjdIAiIEpreCGo4BjmDPCSLQo0RBsCJAhTAtSfp1WTD8VYB3cCmixjO/A5u0iRsH+AHKJrgY3jc5+x9ih77DV/XbmO/yOrDq9I853w+HWqeO3NhdJLdYS+WxHpwO4ezqDaBTwtzm4zUXBkQtfVUE3"
`endif