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

module mc_single_chan_hdm2ip_axi_resp_chans
  import ddr_mc_top_common_pkg::*;
(
  input logic ipclk,
  input logic ipresetn,  // active low
  input logic i_bchan_rspfifo_rdempty_ipclk,
  input logic i_rchan_rspfifo_rdempty_ipclk,
 
  input ddr_mc_top_common_pkg::t_bchan_rspfifo_data   i_rspfifo2ip_new_write_resp_ipclk,
  input ddr_mc_top_common_pkg::t_rchan_rspfifo_data   i_rspfifo2ip_new_read_resp_ipclk,
 
  output logic o_toMC_hdm2ip_axi_bready,  // active high - IP ready for write responses
  output logic o_toMC_hdm2ip_axi_rready,  // active high - IP ready for read  responses
 
  /* External MC_TOP <--> BBS - write response channel
   */
  output logic                                                       hdm2ip_aximm_bvalid,
  output logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WRC_ID_BW-1:0]   hdm2ip_aximm_bid,
  output logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WRC_USER_BW-1:0] hdm2ip_aximm_buser,
  output logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_RESP_WIDTH-1:0] hdm2ip_aximm_bresp,
   input logic                                                       ip2hdm_aximm_bready,  
 
  /* External MC_TOP <--> BBS - read response channel
   */
  output logic                                                       hdm2ip_aximm_rvalid,
  output logic                                                       hdm2ip_aximm_rlast,
  output logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_ID_BW-1:0]   hdm2ip_aximm_rid,
  output logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_DATA_BW-1:0] hdm2ip_aximm_rdata,
  output logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_USER_BW-1:0] hdm2ip_aximm_ruser,
  output logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_RESP_WIDTH-1:0] hdm2ip_aximm_rresp,
   input logic                                                       ip2hdm_aximm_rready
);

// ================================================================================================
/* handle the axi response channels ready signals
 */
assign o_toMC_hdm2ip_axi_bready = ip2hdm_aximm_bready;
assign o_toMC_hdm2ip_axi_rready = ip2hdm_aximm_rready;

// ================================================================================================
/* handle the axi response channels signals -> writes
 */
always_ff @( posedge ipclk )
begin
    hdm2ip_aximm_bvalid <= (~ipresetn | i_bchan_rspfifo_rdempty_ipclk) ? 1'b0 : i_rspfifo2ip_new_write_resp_ipclk.write_resp_valid;
	
    hdm2ip_aximm_bid    <= i_rspfifo2ip_new_write_resp_ipclk.write_id[ddr_mc_top_common_pkg::MCTOP_MC_AXI_WRC_ID_BW-1:0];
    hdm2ip_aximm_buser  <= i_rspfifo2ip_new_write_resp_ipclk.write_user;
    hdm2ip_aximm_bresp  <= i_rspfifo2ip_new_write_resp_ipclk.write_axi_resp;
end

// ================================================================================================
/* handle the axi response channels signals -> reads
 */
always_ff @( posedge ipclk )
begin
    hdm2ip_aximm_rvalid <= (~ipresetn | i_rchan_rspfifo_rdempty_ipclk) ? 1'b0 : i_rspfifo2ip_new_read_resp_ipclk.read_resp_valid;
    hdm2ip_aximm_rlast  <= (~ipresetn | i_rchan_rspfifo_rdempty_ipclk) ? 1'b0 : i_rspfifo2ip_new_read_resp_ipclk.read_resp_valid;
    hdm2ip_aximm_ruser  <= (~ipresetn | i_rchan_rspfifo_rdempty_ipclk) ? 1'b0 : i_rspfifo2ip_new_read_resp_ipclk.read_poison;	
	
	
    hdm2ip_aximm_rid    <= i_rspfifo2ip_new_read_resp_ipclk.read_id[ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_ID_BW-1:0];
    hdm2ip_aximm_rdata  <= i_rspfifo2ip_new_read_resp_ipclk.read_data;
    hdm2ip_aximm_rresp  <= i_rspfifo2ip_new_read_resp_ipclk.read_axi_resp;
end

// ================================================================================================
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5JbSNzNrAthwfEaU6Z+0iu6M8t0er+Glf4vIokLgqbVFF8+TdEl6ccCRkSsYz2cGXifb/bDqtyZOFVB7KUBAW4KwPbbsrixR6SVSfD4GW7c1DojhcfMBhgFqmg6wrXTbfHKJJ4dZwk0eIAgTyutEh+4GUkUB7tg9CN6f+4CaWq2mqOyqGclVglW0rHPbQZZPpW93/SUB3PwOLY0NUMZaKwxWhoFPUCMv16emLmL/+Sc6XjXeA0PnM390aDtamzq6TFOmUgeCIJcwFtmSDQE3/8m73/V2jJPSntsmkh2v2d3WLApNSkwAwxqt1bg/sOEjWZ9dtK2oDMyLeVImoXfzjiAO/R37XeZkWEPyvIeQhwhR9pHaHtsIv+LNc8eT8GSnDCw7OCDWf+3b1LyuCkeH5jZVG1eSEbyxRKcBwi1+T9L5OrWPwLnoGHv0+1pjDwI/vF9y3LclKhSIBcspuJtF7JZR4glno7Ci5/DkNpXjh16SzT+8UiRLvPVhjC895sQYf5KRgfntprq5/bD0zF4A73qWpqUz91ADMH+omtsCEIvOl+zaA/7nvc7JCmUKEQLCWwUdcX9grHFf+JIyUTKOz2pTiMYiwXY2tgW1OUWxsJdT2Z2V1lTFMyT9DuY4vYAA5HupIupBaw5iiOI29CAHlcLoC2BC1tjSntY3Rzf187W+BvoqB0Fy0Uj3wzUBmrk1FHXM94VuSjk/SkR8LCAL8MEeXA9sqgZVOjuHHVQ8aaaTR32XXCplX0MWs0tdXsIbf/q8XG9xnZ9sIOU50rUGk/J"
`endif