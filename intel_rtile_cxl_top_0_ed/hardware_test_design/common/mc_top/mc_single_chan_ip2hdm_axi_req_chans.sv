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

module mc_single_chan_ip2hdm_axi_req_chans
  import ddr_mc_top_common_pkg::*;
#(
  parameter REQFIFO_DEPTH_WIDTH = 6,
  /* For adding cxlmem_ready flag from user defined MC/inline accelerator
   * Parameter for the number of pipeline stages in bbs for drainage out of dataflow controller
   * so that once a user deasserts cxlmem_ready, they still have room to collect the drainage
   * and headroom
   *
   * Width = 10 (used when  7 reqs from IP when ready de-asserts)
   * Width = 33 (used when 30 reqs from IP when ready de-asserts)
   */
  localparam BBS_DFC_DRAINAGE_WIDTH = 8, //33,
  /* For adding cxlmem_ready flag from user defined MC/inline accelerator
   * Need a numerical exact width number from the addressing bit width in REQFIFO_DEPTH_WIDTH
   */
  localparam CXLMEM_READY_CUTOFF = ((2**REQFIFO_DEPTH_WIDTH) - BBS_DFC_DRAINAGE_WIDTH)
 )
(
  input logic ipclk,
  input logic ipresetn,  // active low

  input logic i_mem_cntrl_ready_post_ram_init_ipclk,  // active high -> ~reqfifo_full_eclk & ram_init_done_eclk & mc_baseaddr_cl_vld;
  input logic i_cdc_reqfifo_full_ipclk,
  input logic i_cdc_reqfifo_empty_ipclk,
 
  input logic [REQFIFO_DEPTH_WIDTH-1:0] i_cdc_reqfifo_fill_level_ipclk,
 
  output ddr_mc_top_common_pkg::t_reqfifo_data    o_ip2reqfifo_new_req_ipclk,

  /* External MC_TOP <--> BBS - write address channels
   */
   input logic                                                         ip2hdm_aximm_awvalid,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_ID_BW-1:0]     ip2hdm_aximm_awid,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_ADDR_BW-1:0]   ip2hdm_aximm_awaddr,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_BLEN_BW-1:0]   ip2hdm_aximm_awlen,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_REGION_BW-1:0] ip2hdm_aximm_awregion,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_USER_BW-1:0]   ip2hdm_aximm_awuser,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_SIZE_WIDTH-1:0]   ip2hdm_aximm_awsize,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_BURST_WIDTH-1:0]  ip2hdm_aximm_awburst,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_PROT_WIDTH-1:0]   ip2hdm_aximm_awprot,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_QOS_WIDTH-1:0]    ip2hdm_aximm_awqos,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_CACHE_WIDTH-1:0]  ip2hdm_aximm_awcache,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_LOCK_WIDTH-1:0]   ip2hdm_aximm_awlock,
  output logic                                                         hdm2ip_aximm_awready,   
  /* External MC_TOP <--> BBS - write data channel
   */
   input logic                                                       ip2hdm_aximm_wvalid,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_DATA_BW-1:0] ip2hdm_aximm_wdata,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_STRB_BW-1:0] ip2hdm_aximm_wstrb,
   input logic                                                       ip2hdm_aximm_wlast,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_USER_BW-1:0] ip2hdm_aximm_wuser,
  output logic                                                       hdm2ip_aximm_wready,
  /* External MC_TOP <--> BBS - read address channel
   */
   input logic                                                         ip2hdm_aximm_arvalid,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_ID_BW-1:0]     ip2hdm_aximm_arid,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_ADDR_BW-1:0]   ip2hdm_aximm_araddr,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_BLEN_BW-1:0]   ip2hdm_aximm_arlen,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_REGION_BW-1:0] ip2hdm_aximm_arregion,
   input logic [ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_USER_BW-1:0]   ip2hdm_aximm_aruser,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_SIZE_WIDTH-1:0]   ip2hdm_aximm_arsize,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_BURST_WIDTH-1:0]  ip2hdm_aximm_arburst,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_PROT_WIDTH-1:0]   ip2hdm_aximm_arprot,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_QOS_WIDTH-1:0]    ip2hdm_aximm_arqos,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_CACHE_WIDTH-1:0]  ip2hdm_aximm_arcache,
   input logic [ddr_mc_top_common_pkg::MCTOP_AFU_AXI_LOCK_WIDTH-1:0]   ip2hdm_aximm_arlock,
  output logic                                                         hdm2ip_aximm_arready
);

// ================================================================================================
/* Formally the mc_cxlmem_ready_control module
*/
logic cxlmem_ready_delay1_ipclk;
logic cxlmem_ready_ipclk;
logic cxlmem_ready_comb;

always_comb
begin
    cxlmem_ready_comb = cxlmem_ready_ipclk;
  
    if( (~i_mem_cntrl_ready_post_ram_init_ipclk)
	  | i_cdc_reqfifo_full_ipclk
	  | ( i_cdc_reqfifo_fill_level_ipclk == CXLMEM_READY_CUTOFF )
      )
    begin
               cxlmem_ready_comb = 1'b0;
    end
    else if( i_mem_cntrl_ready_post_ram_init_ipclk
	       & i_cdc_reqfifo_empty_ipclk
	       )
    begin
              cxlmem_ready_comb = 1'b1;
    end
    else if( ( i_cdc_reqfifo_fill_level_ipclk < CXLMEM_READY_CUTOFF )
	       & ( i_cdc_reqfifo_fill_level_ipclk > '0 )
	       )
    begin
              cxlmem_ready_comb = 1'b1;
    end
end

always_ff @( posedge ipclk )
begin
    cxlmem_ready_ipclk <= ~ipresetn ? 1'b0 : cxlmem_ready_comb;
	
	cxlmem_ready_delay1_ipclk <= ~ipresetn ? 1'b0 : cxlmem_ready_ipclk;
end

// ================================================================================================
/* handle the axi request channels ready signals - always ready unless there's no room in the request fifo
 */
assign hdm2ip_aximm_arready = cxlmem_ready_delay1_ipclk; //cxlmem_ready_ipclk;
assign hdm2ip_aximm_awready = cxlmem_ready_delay1_ipclk; //cxlmem_ready_ipclk;
assign hdm2ip_aximm_wready  = cxlmem_ready_delay1_ipclk; //cxlmem_ready_ipclk;

// ================================================================================================
/* Forward the AXI4 request channels to the cdc_reqFifo with with *NO* staging
 */
always_comb
begin
    o_ip2reqfifo_new_req_ipclk = '0;

    if( cxlmem_ready_delay1_ipclk  // the memory controller is ready for new requests
      & ip2hdm_aximm_awvalid       // write request in (awwready tied to cxlmem_ready
      )
	begin
      o_ip2reqfifo_new_req_ipclk.write         = 1'b1;
      o_ip2reqfifo_new_req_ipclk.partial_write = ~( ip2hdm_aximm_wstrb == '1 );
      o_ip2reqfifo_new_req_ipclk.read          = 1'b0;
      o_ip2reqfifo_new_req_ipclk.wr_id         = {1'b1, ip2hdm_aximm_awid};  // 12 bits. wr_id_in[8]=1 to uniquify rmw_wr_id_mclk for use as ARID for read during
      o_ip2reqfifo_new_req_ipclk.rd_id         =  '0;
      o_ip2reqfifo_new_req_ipclk.req_mdata     =  '0;
      o_ip2reqfifo_new_req_ipclk.write_ras_sbe = 1'b0;
      o_ip2reqfifo_new_req_ipclk.write_ras_dbe = 1'b0;
      o_ip2reqfifo_new_req_ipclk.write_poison  = ip2hdm_aximm_wuser;
      o_ip2reqfifo_new_req_ipclk.byteenable    = ip2hdm_aximm_wstrb;
      o_ip2reqfifo_new_req_ipclk.writedata     = ip2hdm_aximm_wdata;

      `ifdef INTEL_ONLY_CXLIPDEV  // This mode is not intended for customer use and may result in unexpected behaviour if set.
         o_ip2reqfifo_new_req_ipclk.address = ip2hdm_aximm_awaddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_FULL_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_FULL_ADDR_LSB)];  // address aliasing needed for multi-slice & emif
      `else
        `ifdef ENABLE_1_SLICE
           o_ip2reqfifo_new_req_ipclk.address = ip2hdm_aximm_awaddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)];
        `elsif ENABLE_4_SLICE
           o_ip2reqfifo_new_req_ipclk.address = {2'b00, ip2hdm_aximm_awaddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)]};
        `else
           o_ip2reqfifo_new_req_ipclk.address = {1'b0, ip2hdm_aximm_awaddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)]};
        `endif
      `endif
	end
	else if( cxlmem_ready_delay1_ipclk  // the memory controller is ready for new requests
	       & ip2hdm_aximm_arvalid       // read request in (arwready tied to cxlmem_ready
           )
	begin          
      o_ip2reqfifo_new_req_ipclk.write         = 1'b0;
      o_ip2reqfifo_new_req_ipclk.partial_write =  '0;
      o_ip2reqfifo_new_req_ipclk.read          = 1'b1;
      o_ip2reqfifo_new_req_ipclk.wr_id         =  '0;
      o_ip2reqfifo_new_req_ipclk.rd_id         = {1'b0, ip2hdm_aximm_arid};
      o_ip2reqfifo_new_req_ipclk.req_mdata     =  '0;
      o_ip2reqfifo_new_req_ipclk.write_ras_sbe = 1'b0;
      o_ip2reqfifo_new_req_ipclk.write_ras_dbe = 1'b0;
      o_ip2reqfifo_new_req_ipclk.write_poison  = 1'b0;
      o_ip2reqfifo_new_req_ipclk.byteenable    =  '0;
      o_ip2reqfifo_new_req_ipclk.writedata     =  '0;       
          
      `ifdef INTEL_ONLY_CXLIPDEV  // This mode is not intended for customer use and may result in unexpected behaviour if set.
         o_ip2reqfifo_new_req_ipclk.address = ip2hdm_aximm_araddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_FULL_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_FULL_ADDR_LSB)];  // address aliasing needed for multi-slice & emif
      `else
        `ifdef ENABLE_1_SLICE
           o_ip2reqfifo_new_req_ipclk.address = ip2hdm_aximm_araddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)];
        `elsif ENABLE_4_SLICE
           o_ip2reqfifo_new_req_ipclk.address = {2'b00, ip2hdm_aximm_araddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)]};
        `else
           o_ip2reqfifo_new_req_ipclk.address = {1'b0, ip2hdm_aximm_araddr[(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_MSB):(ddr_mc_top_common_pkg::MCTOP_CXLIP_CHAN_ADDR_LSB)]};
        `endif
      `endif
	end  
end

// ================================================================================================
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5JggJHmmF40LwEfynKQz84XhSMxPkR7T6AMnlVipKacv5uvc9WX0wuJHYRtTAIQp82cRx6aDM95g97E2uK3J1M5LGKKagBWnmzD5OWZE9aUorK11+z6H+96bydN9JtrLg85NMv6kM+fJfOt8DEpdyXkmVJucYzP2emsih1+ynMjXaLDu6J3qs1glAzrhLeyIP4fTmuB00/5qp4uvNJEolnDBzUfUA4EIKCY6BBVhSB+qiPopZVwhcVwI0RiMIzbBGhfxN4t/InDflNEJCFVy8rNbWWqWRaw11f5uBgJ4uxGYUnB/2F5Q5j98fJ42GgjWz10iBLvMX4hSYTqqH8wBokLa/8AxBTFIT6Ns1Ha9KGk61neyqWqQCmbJQPDRpnbf7YBPDQcSI7G1F1JEUKQY0/9C8gXH0J84zYrJnV2OWgXwpcNZDQ5F7Mwi1g7F1n84ygQjmnWG2NwT/zS/h1BzLkxcQUPBf6fAlyx3A0NmZvTkdGJqqRNwCF0wE3ITavWGKcCEH70WOrMnqpePuJxWxb+vx5Lf2Z72vKL9KqmUpCQqOAtkOzejYkXCqH+AQmzsHyWsUWiHnBhB+i50gx5b6i3jxeX4pFL81EV1azOl7PbJEZmMXl0vSxJYtWdT752IYsccjKyyEu39XUxZbKEKpxd5NFCg/jFYFEwW9n+b4m/QOUV6ACE9IQGkRIBMS/Nfapm8+hfyHTS1Bz8/t4mpSk6GFyc2asGWQbuiizQRxsCFZ8D4IwEZGBkaLXcdsM43VtkGk6dg2qGXMtJFfS8z4c0"
`endif