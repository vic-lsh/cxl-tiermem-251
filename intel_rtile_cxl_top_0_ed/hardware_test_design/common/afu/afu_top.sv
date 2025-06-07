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
//`include "cxl_ed_defines.svh.iv"

`include "cxl_typ3ddr_ed_defines.svh.iv"

import cxlip_top_pkg::*;
import ddr_mc_top_common_pkg::*;

module afu_top(
    input logic clk,
    input logic rst_n,

  `ifdef OOORSP_MC_AXI2AVMM 
`ifdef ENABLE_1_SLICE   

    output  logic  [4:0]     mc2ip_0_sr_status,               //HDM controller status
//Channel-0
     /* write address channel
      */
  input logic          ip2hdm_aximm0_awvalid    ,       
  input logic  [7:0]  ip2hdm_aximm0_awid       ,       
  input logic  [51:0]  ip2hdm_aximm0_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm0_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm0_awregion   ,       
  input logic          ip2hdm_aximm0_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm0_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm0_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm0_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm0_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm0_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm0_awlock     ,      
  output  logic          hdm2ip_aximm0_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm0_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm0_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm0_wstrb      ,           
  input logic          ip2hdm_aximm0_wlast      ,           
  input logic          ip2hdm_aximm0_wuser      ,           
  output logic           hdm2ip_aximm0_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm0_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm0_bid        ,
  output  logic          hdm2ip_aximm0_buser      ,
  output  logic [1:0]    hdm2ip_aximm0_bresp      ,
  input logic          ip2hdm_aximm0_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm0_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm0_arid       ,         
  input logic  [51:0]  ip2hdm_aximm0_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm0_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm0_arregion   ,         
  input logic          ip2hdm_aximm0_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm0_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm0_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm0_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm0_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm0_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm0_arlock     ,         
  output logic          hdm2ip_aximm0_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm0_rvalid     , 
  output  logic          hdm2ip_aximm0_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm0_rid        ,
  output  logic  [511:0] hdm2ip_aximm0_rdata      ,
  output  logic          hdm2ip_aximm0_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm0_rresp      ,
  input   logic          ip2hdm_aximm0_rready    ,     
	


`elsif ENABLE_4_SLICE   // MC_CHANNEL=4

  output  logic  [4:0]     mc2ip_0_sr_status,               //HDM controller status
  output  logic  [4:0]     mc2ip_1_sr_status,               //HDM controller status
  output  logic  [4:0]     mc2ip_2_sr_status,               //HDM controller status
  output  logic  [4:0]     mc2ip_3_sr_status,               //HDM controller status
//Channel-0
     /* write address channel
      */
  input logic          ip2hdm_aximm0_awvalid    ,       
  input logic  [7:0]   ip2hdm_aximm0_awid       ,       
  input logic  [51:0]  ip2hdm_aximm0_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm0_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm0_awregion   ,       
  input logic          ip2hdm_aximm0_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm0_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm0_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm0_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm0_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm0_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm0_awlock     ,      
  output  logic          hdm2ip_aximm0_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm0_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm0_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm0_wstrb      ,           
  input logic          ip2hdm_aximm0_wlast      ,           
  input logic          ip2hdm_aximm0_wuser      ,           
  output logic           hdm2ip_aximm0_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm0_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm0_bid        ,
  output  logic          hdm2ip_aximm0_buser      ,
  output  logic [1:0]    hdm2ip_aximm0_bresp      ,
  input logic          ip2hdm_aximm0_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm0_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm0_arid       ,         
  input logic  [51:0]  ip2hdm_aximm0_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm0_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm0_arregion   ,         
  input logic          ip2hdm_aximm0_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm0_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm0_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm0_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm0_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm0_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm0_arlock     ,         
  output logic          hdm2ip_aximm0_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm0_rvalid     , 
  output  logic          hdm2ip_aximm0_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm0_rid        ,
  output  logic  [511:0] hdm2ip_aximm0_rdata      ,
  output  logic          hdm2ip_aximm0_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm0_rresp      ,
  input   logic          ip2hdm_aximm0_rready    ,     
	

//Channel-1
     /* write address channel
      */
  input logic          ip2hdm_aximm1_awvalid    ,       
  input logic  [7:0]  ip2hdm_aximm1_awid       ,       
  input logic  [51:0]  ip2hdm_aximm1_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm1_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm1_awregion   ,       
  input logic          ip2hdm_aximm1_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm1_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm1_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm1_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm1_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm1_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm1_awlock     ,      
  output  logic          hdm2ip_aximm1_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm1_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm1_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm1_wstrb      ,           
  input logic          ip2hdm_aximm1_wlast      ,           
  input logic          ip2hdm_aximm1_wuser      ,           
  output logic           hdm2ip_aximm1_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm1_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm1_bid        ,
  output  logic          hdm2ip_aximm1_buser      ,
  output  logic [1:0]    hdm2ip_aximm1_bresp      ,
  input logic          ip2hdm_aximm1_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm1_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm1_arid       ,         
  input logic  [51:0]  ip2hdm_aximm1_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm1_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm1_arregion   ,         
  input logic          ip2hdm_aximm1_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm1_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm1_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm1_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm1_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm1_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm1_arlock     ,         
  output logic          hdm2ip_aximm1_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm1_rvalid     , 
  output  logic          hdm2ip_aximm1_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm1_rid        ,
  output  logic  [511:0] hdm2ip_aximm1_rdata      ,
  output  logic          hdm2ip_aximm1_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm1_rresp      ,
  input   logic          ip2hdm_aximm1_rready    ,  
    

//Channel-2
     /* write address channel
      */
  input logic          ip2hdm_aximm2_awvalid    ,       
  input logic  [7:0]  ip2hdm_aximm2_awid       ,       
  input logic  [51:0]  ip2hdm_aximm2_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm2_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm2_awregion   ,       
  input logic          ip2hdm_aximm2_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm2_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm2_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm2_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm2_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm2_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm2_awlock     ,      
  output  logic          hdm2ip_aximm2_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm2_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm2_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm2_wstrb      ,           
  input logic          ip2hdm_aximm2_wlast      ,           
  input logic          ip2hdm_aximm2_wuser      ,           
  output logic           hdm2ip_aximm2_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm2_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm2_bid        ,
  output  logic          hdm2ip_aximm2_buser      ,
  output  logic [1:0]    hdm2ip_aximm2_bresp      ,
  input logic          ip2hdm_aximm2_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm2_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm2_arid       ,         
  input logic  [51:0]  ip2hdm_aximm2_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm2_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm2_arregion   ,         
  input logic          ip2hdm_aximm2_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm2_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm2_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm2_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm2_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm2_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm2_arlock     ,         
  output logic          hdm2ip_aximm2_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm2_rvalid     , 
  output  logic          hdm2ip_aximm2_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm2_rid        ,
  output  logic  [511:0] hdm2ip_aximm2_rdata      ,
  output  logic          hdm2ip_aximm2_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm2_rresp      ,
  input   logic          ip2hdm_aximm2_rready     ,

//Channel-3
     /* write address channel
      */
  input logic          ip2hdm_aximm3_awvalid    ,       
  input logic  [7:0]  ip2hdm_aximm3_awid       ,       
  input logic  [51:0]  ip2hdm_aximm3_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm3_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm3_awregion   ,       
  input logic          ip2hdm_aximm3_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm3_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm3_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm3_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm3_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm3_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm3_awlock     ,      
  output  logic          hdm2ip_aximm3_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm3_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm3_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm3_wstrb      ,           
  input logic          ip2hdm_aximm3_wlast      ,           
  input logic          ip2hdm_aximm3_wuser      ,           
  output logic           hdm2ip_aximm3_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm3_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm3_bid        ,
  output  logic          hdm2ip_aximm3_buser      ,
  output  logic [1:0]    hdm2ip_aximm3_bresp      ,
  input logic          ip2hdm_aximm3_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm3_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm3_arid       ,         
  input logic  [51:0]  ip2hdm_aximm3_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm3_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm3_arregion   ,         
  input logic          ip2hdm_aximm3_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm3_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm3_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm3_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm3_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm3_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm3_arlock     ,         
  output logic          hdm2ip_aximm3_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm3_rvalid     , 
  output  logic          hdm2ip_aximm3_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm3_rid        ,
  output  logic  [511:0] hdm2ip_aximm3_rdata      ,
  output  logic          hdm2ip_aximm3_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm3_rresp      ,
  input   logic          ip2hdm_aximm3_rready   ,  
  

   `else

  output  logic  [4:0]     mc2ip_0_sr_status,               //HDM controller status
  output  logic  [4:0]     mc2ip_1_sr_status,               //HDM controller status
//Channel-0
     /* write address channel
      */
  input logic          ip2hdm_aximm0_awvalid    ,       
  input logic  [7:0]   ip2hdm_aximm0_awid       ,       
  input logic  [51:0]  ip2hdm_aximm0_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm0_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm0_awregion   ,       
  input logic          ip2hdm_aximm0_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm0_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm0_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm0_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm0_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm0_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm0_awlock     ,      
  output  logic          hdm2ip_aximm0_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm0_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm0_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm0_wstrb      ,           
  input logic          ip2hdm_aximm0_wlast      ,           
  input logic          ip2hdm_aximm0_wuser      ,           
  output logic           hdm2ip_aximm0_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm0_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm0_bid        ,
  output  logic          hdm2ip_aximm0_buser      ,
  output  logic [1:0]    hdm2ip_aximm0_bresp      ,
  input logic          ip2hdm_aximm0_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm0_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm0_arid       ,         
  input logic  [51:0]  ip2hdm_aximm0_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm0_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm0_arregion   ,         
  input logic          ip2hdm_aximm0_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm0_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm0_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm0_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm0_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm0_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm0_arlock     ,         
  output logic          hdm2ip_aximm0_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm0_rvalid     , 
  output  logic          hdm2ip_aximm0_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm0_rid        ,
  output  logic  [511:0] hdm2ip_aximm0_rdata      ,
  output  logic          hdm2ip_aximm0_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm0_rresp      ,
  input   logic          ip2hdm_aximm0_rready    ,     
	

//Channel-1
     /* write address channel
      */
  input logic          ip2hdm_aximm1_awvalid    ,       
  input logic  [7:0]  ip2hdm_aximm1_awid       ,       
  input logic  [51:0]  ip2hdm_aximm1_awaddr     ,       
  input logic  [9:0]   ip2hdm_aximm1_awlen      ,       
  input logic  [3:0]   ip2hdm_aximm1_awregion   ,       
  input logic          ip2hdm_aximm1_awuser     ,       
  input logic  [2:0]   ip2hdm_aximm1_awsize     ,      
  input logic  [1:0]   ip2hdm_aximm1_awburst    ,      
  input logic  [2:0]   ip2hdm_aximm1_awprot     ,      
  input logic  [3:0]   ip2hdm_aximm1_awqos      ,      
  input logic  [3:0]   ip2hdm_aximm1_awcache    ,      
  input logic  [1:0]   ip2hdm_aximm1_awlock     ,      
  output  logic          hdm2ip_aximm1_awready    ,
     /* write data channel
      */
  input logic          ip2hdm_aximm1_wvalid     ,          
  input logic  [511:0] ip2hdm_aximm1_wdata      ,           
  input logic  [63:0]  ip2hdm_aximm1_wstrb      ,           
  input logic          ip2hdm_aximm1_wlast      ,           
  input logic          ip2hdm_aximm1_wuser      ,           
  output logic           hdm2ip_aximm1_wready  	 ,
     /* write response channel
      */
  output  logic          hdm2ip_aximm1_bvalid     ,
  output  logic [7:0]    hdm2ip_aximm1_bid        ,
  output  logic          hdm2ip_aximm1_buser      ,
  output  logic [1:0]    hdm2ip_aximm1_bresp      ,
  input logic          ip2hdm_aximm1_bready     ,               
     /* read address channel
      */
  input logic          ip2hdm_aximm1_arvalid    ,         
  input logic  [7:0]  ip2hdm_aximm1_arid       ,         
  input logic  [51:0]  ip2hdm_aximm1_araddr     ,         
  input logic  [9:0]   ip2hdm_aximm1_arlen      ,         
  input logic  [3:0]   ip2hdm_aximm1_arregion   ,         
  input logic          ip2hdm_aximm1_aruser     ,         
  input logic  [2:0]   ip2hdm_aximm1_arsize     ,         
  input logic  [1:0]   ip2hdm_aximm1_arburst    ,         
  input logic  [2:0]   ip2hdm_aximm1_arprot     ,         
  input logic  [3:0]   ip2hdm_aximm1_arqos      ,         
  input logic  [3:0]   ip2hdm_aximm1_arcache    ,         
  input logic  [1:0]   ip2hdm_aximm1_arlock     ,         
  output logic          hdm2ip_aximm1_arready    , 
     /* read response channel
      */
  output  logic          hdm2ip_aximm1_rvalid     , 
  output  logic          hdm2ip_aximm1_rlast     , 
  output  logic  [7:0]   hdm2ip_aximm1_rid        ,
  output  logic  [511:0] hdm2ip_aximm1_rdata      ,
  output  logic          hdm2ip_aximm1_ruser      ,
  output  logic  [1:0]   hdm2ip_aximm1_rresp      ,
  input   logic          ip2hdm_aximm1_rready    ,  
    

`endif	

  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][4:0] mc_status,
  /* only supporting the axi4 for HDM memory traffic to/from IP
   */
  /* External MC_TOP <--> CXL-IP - write address channels
   */
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                        ip2hdm_aximm_awvalid,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_ID_BW-1:0]     ip2hdm_aximm_awid,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_ADDR_BW-1:0]   ip2hdm_aximm_awaddr,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_BLEN_BW-1:0]   ip2hdm_aximm_awlen,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_REGION_BW-1:0] ip2hdm_aximm_awregion,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WAC_USER_BW-1:0]   ip2hdm_aximm_awuser,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_SIZE_WIDTH-1:0]   ip2hdm_aximm_awsize,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_BURST_WIDTH-1:0]  ip2hdm_aximm_awburst,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_PROT_WIDTH-1:0]   ip2hdm_aximm_awprot,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_QOS_WIDTH-1:0]    ip2hdm_aximm_awqos,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_CACHE_WIDTH-1:0]  ip2hdm_aximm_awcache,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_LOCK_WIDTH-1:0]   ip2hdm_aximm_awlock,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                        hdm2ip_aximm_awready,   
  /* External MC_TOP <--> CXL-IP - write data channel
   */
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      ip2hdm_aximm_wvalid,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_DATA_BW-1:0] ip2hdm_aximm_wdata,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_STRB_BW-1:0] ip2hdm_aximm_wstrb,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      ip2hdm_aximm_wlast,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WDC_USER_BW-1:0] ip2hdm_aximm_wuser,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      hdm2ip_aximm_wready,		  
  /* External MC_TOP <--> CXL-IP - write response channel
   */
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      hdm2ip_aximm_bvalid,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WRC_ID_BW-1:0]   hdm2ip_aximm_bid,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_WRC_USER_BW-1:0] hdm2ip_aximm_buser,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_RESP_WIDTH-1:0] hdm2ip_aximm_bresp,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      ip2hdm_aximm_bready,  
  /* External MC_TOP <--> CXL-IP - read address channel
   */
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                        ip2hdm_aximm_arvalid,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_ID_BW-1:0]     ip2hdm_aximm_arid,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_ADDR_BW-1:0]   ip2hdm_aximm_araddr,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_BLEN_BW-1:0]   ip2hdm_aximm_arlen,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_REGION_BW-1:0] ip2hdm_aximm_arregion,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RAC_USER_BW-1:0]   ip2hdm_aximm_aruser,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_SIZE_WIDTH-1:0]   ip2hdm_aximm_arsize,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_BURST_WIDTH-1:0]  ip2hdm_aximm_arburst,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_PROT_WIDTH-1:0]   ip2hdm_aximm_arprot,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_QOS_WIDTH-1:0]    ip2hdm_aximm_arqos,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_CACHE_WIDTH-1:0]  ip2hdm_aximm_arcache,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_LOCK_WIDTH-1:0]   ip2hdm_aximm_arlock,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                        hdm2ip_aximm_arready,  
  /* External MC_TOP <--> CXL-IP - read response channel
   */
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      hdm2ip_aximm_rvalid,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      hdm2ip_aximm_rlast,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_ID_BW-1:0]   hdm2ip_aximm_rid,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_DATA_BW-1:0] hdm2ip_aximm_rdata,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_MC_AXI_RRC_USER_BW-1:0] hdm2ip_aximm_ruser,
  input logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0][ddr_mc_top_common_pkg::MCTOP_AFU_AXI_RESP_WIDTH-1:0] hdm2ip_aximm_rresp,
   output logic [ddr_mc_top_common_pkg::MCTOP_MC_CHANNEL-1:0]                                                      ip2hdm_aximm_rready

  `else
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ready_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_read_poison_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_readdatavalid_eclk,
    // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_corrected_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_detected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_fatal_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     mc2iafu_ecc_err_syn_e_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_ecc_err_valid_eclk,
    input  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             mc2iafu_cxlmem_ready,
    input  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    mc2iafu_readdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0],
    input  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         mc2iafu_rsp_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    
    
    output logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2mc_writedata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]      iafu2mc_byteenable_eclk         [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_read_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_poison_eclk,
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_sbe_eclk,    
    output logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2mc_write_ras_dbe_eclk,    
    //output logic [cxlip_top_pkg::MC_HA_DP_ADDR_WIDTH-1:0]    iafu2mc_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    iafu2mc_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0],
    output logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2mc_req_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],

                //CXL_IP to AFU to MC TOP Passthrough signals
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ready_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_read_poison_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_readdatavalid_eclk,
    // Error Correction Code (ECC)
    // Note *ecc_err_* are valid when mc2iafu_readdatavalid_eclk is active
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_corrected_eclk  [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_detected_eclk   [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_fatal_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::ALTECC_INST_NUMBER-1:0]     iafu2cxlip_ecc_err_syn_e_eclk      [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_ecc_err_valid_eclk,
    output  logic [cxlip_top_pkg::MC_CHANNEL-1:0]             iafu2cxlip_cxlmem_ready,
    output  logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]    iafu2cxlip_readdata_eclk           [cxlip_top_pkg::MC_CHANNEL-1:0],
    output  logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]         iafu2cxlip_rsp_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    
    input logic [cxlip_top_pkg::MC_HA_DP_DATA_WIDTH-1:0]      cxlip2iafu_writedata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_HA_DP_BE_WIDTH-1:0]        cxlip2iafu_byteenable_eclk         [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_read_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_poison_eclk,
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_ras_sbe_eclk,    
    input logic [cxlip_top_pkg::MC_CHANNEL-1:0]               cxlip2iafu_write_ras_dbe_eclk,    
    input logic  [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]      cxlip2iafu_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0],
    input logic [cxlip_top_pkg::MC_MDATA_WIDTH-1:0]           cxlip2iafu_req_mdata_eclk          [cxlip_top_pkg::MC_CHANNEL-1:0]
 `endif    
    
);


//  logic [(cxlip_top_pkg::CXLIP_FULL_ADDR_MSB):(cxlip_top_pkg::CXLIP_FULL_ADDR_LSB)]    cxlip2iafu_chan_address_eclk            [cxlip_top_pkg::MC_CHANNEL-1:0];  //added from 22ww18a
//
//  always_comb begin
//    for (int i=0; i<cxlip_top_pkg::MC_CHANNEL; i++) begin
//      cxlip2iafu_chan_address_eclk[i] = { '0, cxlip2iafu_address_eclk[i][(cxlip_top_pkg::CXLIP_CHAN_ADDR_MSB):(cxlip_top_pkg::CXLIP_CHAN_ADDR_LSB)] };
//    end
//  end



//Passthrough User can implement the AFU logic here 
  `ifdef OOORSP_MC_AXI2AVMM 
//Passthrough User can implement the AFU logic here 

`ifdef ENABLE_1_SLICE   

 assign   mc2ip_0_sr_status      =  mc_status[0]                   ;
//Channel-0
 assign ip2hdm_aximm_awid    [0] = ip2hdm_aximm0_awid ;
 assign ip2hdm_aximm_awaddr  [0] = ip2hdm_aximm0_awaddr ;
 assign ip2hdm_aximm_awlen   [0] = ip2hdm_aximm0_awlen ;
 assign ip2hdm_aximm_awregion[0] = ip2hdm_aximm0_awregion ;
 assign ip2hdm_aximm_awuser  [0] = ip2hdm_aximm0_awuser ;
 assign ip2hdm_aximm_awsize  [0] = ip2hdm_aximm0_awsize  ;
 assign ip2hdm_aximm_awburst [0] = ip2hdm_aximm0_awburst ;
 assign ip2hdm_aximm_awprot  [0] = ip2hdm_aximm0_awprot  ;
 assign ip2hdm_aximm_awqos   [0] = ip2hdm_aximm0_awqos   ;
 assign ip2hdm_aximm_awcache [0] = ip2hdm_aximm0_awcache ;
 assign ip2hdm_aximm_awlock  [0] = ip2hdm_aximm0_awlock  ;
 assign ip2hdm_aximm_awvalid [0] = ip2hdm_aximm0_awvalid;
 assign ip2hdm_aximm_wdata   [0] = ip2hdm_aximm0_wdata ;
 assign ip2hdm_aximm_wstrb   [0] = ip2hdm_aximm0_wstrb ;
 assign ip2hdm_aximm_wlast   [0] = ip2hdm_aximm0_wlast ;
 assign ip2hdm_aximm_wuser   [0] = ip2hdm_aximm0_wuser ;
 assign ip2hdm_aximm_wvalid  [0] = ip2hdm_aximm0_wvalid;
 assign ip2hdm_aximm_bready  [0] = ip2hdm_aximm0_bready ;
 assign ip2hdm_aximm_arid    [0] = ip2hdm_aximm0_arid ;
 assign ip2hdm_aximm_araddr  [0] = ip2hdm_aximm0_araddr ;
 assign ip2hdm_aximm_arlen   [0] = ip2hdm_aximm0_arlen ;
 assign ip2hdm_aximm_arregion[0] = ip2hdm_aximm0_arregion ;
 assign ip2hdm_aximm_aruser  [0] = ip2hdm_aximm0_aruser ;
 assign ip2hdm_aximm_arsize  [0] = ip2hdm_aximm0_arsize ;
 assign ip2hdm_aximm_arburst [0] = ip2hdm_aximm0_arburst ;
 assign ip2hdm_aximm_arprot  [0] = ip2hdm_aximm0_arprot  ;
 assign ip2hdm_aximm_arqos   [0] = ip2hdm_aximm0_arqos  ;
 assign ip2hdm_aximm_arcache [0] = ip2hdm_aximm0_arcache ;
 assign ip2hdm_aximm_arlock  [0] = ip2hdm_aximm0_arlock ;
 assign ip2hdm_aximm_arvalid [0] = ip2hdm_aximm0_arvalid;
 assign ip2hdm_aximm_rready  [0] = ip2hdm_aximm0_rready ;
 
 assign hdm2ip_aximm0_awready    =  hdm2ip_aximm_awready[0] ;
 assign hdm2ip_aximm0_wready     =  hdm2ip_aximm_wready [0] ;
 assign hdm2ip_aximm0_bvalid     =  hdm2ip_aximm_bvalid [0] ;
 assign hdm2ip_aximm0_bid        =  hdm2ip_aximm_bid    [0] ;
 assign hdm2ip_aximm0_buser      =  hdm2ip_aximm_buser  [0] ;
 assign hdm2ip_aximm0_bresp      =  hdm2ip_aximm_bresp  [0] ;
 assign hdm2ip_aximm0_arready    =  hdm2ip_aximm_arready[0] ;
 assign hdm2ip_aximm0_rvalid     =  hdm2ip_aximm_rvalid [0] ;
 assign hdm2ip_aximm0_rlast      =  hdm2ip_aximm_rlast  [0] ;
 assign hdm2ip_aximm0_rid        =  hdm2ip_aximm_rid    [0] ;
 assign hdm2ip_aximm0_rdata      =  hdm2ip_aximm_rdata  [0] ;
 assign hdm2ip_aximm0_ruser      =  hdm2ip_aximm_ruser  [0] ;
 assign hdm2ip_aximm0_rresp      =  hdm2ip_aximm_rresp  [0] ;


`elsif ENABLE_4_SLICE   

 assign   mc2ip_0_sr_status      =  mc_status[0]                   ;
 assign   mc2ip_1_sr_status      =  mc_status[1]                   ;
 assign   mc2ip_2_sr_status      =  mc_status[2]                   ;
 assign   mc2ip_3_sr_status      =  mc_status[3]                   ;


//Channel-0
 assign ip2hdm_aximm_awid    [0] = ip2hdm_aximm0_awid ;
 assign ip2hdm_aximm_awaddr  [0] = ip2hdm_aximm0_awaddr ;
 assign ip2hdm_aximm_awlen   [0] = ip2hdm_aximm0_awlen ;
 assign ip2hdm_aximm_awregion[0] = ip2hdm_aximm0_awregion ;
 assign ip2hdm_aximm_awuser  [0] = ip2hdm_aximm0_awuser ;
 assign ip2hdm_aximm_awsize  [0] = ip2hdm_aximm0_awsize  ;
 assign ip2hdm_aximm_awburst [0] = ip2hdm_aximm0_awburst ;
 assign ip2hdm_aximm_awprot  [0] = ip2hdm_aximm0_awprot  ;
 assign ip2hdm_aximm_awqos   [0] = ip2hdm_aximm0_awqos   ;
 assign ip2hdm_aximm_awcache [0] = ip2hdm_aximm0_awcache ;
 assign ip2hdm_aximm_awlock  [0] = ip2hdm_aximm0_awlock  ;
 assign ip2hdm_aximm_awvalid [0] = ip2hdm_aximm0_awvalid;
 assign ip2hdm_aximm_wdata   [0] = ip2hdm_aximm0_wdata ;
 assign ip2hdm_aximm_wstrb   [0] = ip2hdm_aximm0_wstrb ;
 assign ip2hdm_aximm_wlast   [0] = ip2hdm_aximm0_wlast ;
 assign ip2hdm_aximm_wuser   [0] = ip2hdm_aximm0_wuser ;
 assign ip2hdm_aximm_wvalid  [0] = ip2hdm_aximm0_wvalid;
 assign ip2hdm_aximm_bready  [0] = ip2hdm_aximm0_bready ;
 assign ip2hdm_aximm_arid    [0] = ip2hdm_aximm0_arid ;
 assign ip2hdm_aximm_araddr  [0] = ip2hdm_aximm0_araddr ;
 assign ip2hdm_aximm_arlen   [0] = ip2hdm_aximm0_arlen ;
 assign ip2hdm_aximm_arregion[0] = ip2hdm_aximm0_arregion ;
 assign ip2hdm_aximm_aruser  [0] = ip2hdm_aximm0_aruser ;
 assign ip2hdm_aximm_arsize  [0] = ip2hdm_aximm0_arsize ;
 assign ip2hdm_aximm_arburst [0] = ip2hdm_aximm0_arburst ;
 assign ip2hdm_aximm_arprot  [0] = ip2hdm_aximm0_arprot  ;
 assign ip2hdm_aximm_arqos   [0] = ip2hdm_aximm0_arqos  ;
 assign ip2hdm_aximm_arcache [0] = ip2hdm_aximm0_arcache ;
 assign ip2hdm_aximm_arlock  [0] = ip2hdm_aximm0_arlock ;
 assign ip2hdm_aximm_arvalid [0] = ip2hdm_aximm0_arvalid;
 assign ip2hdm_aximm_rready  [0] = ip2hdm_aximm0_rready ;
 
 assign hdm2ip_aximm0_awready    =  hdm2ip_aximm_awready[0] ;
 assign hdm2ip_aximm0_wready     =  hdm2ip_aximm_wready [0] ;
 assign hdm2ip_aximm0_bvalid     =  hdm2ip_aximm_bvalid [0] ;
 assign hdm2ip_aximm0_bid        =  hdm2ip_aximm_bid    [0] ;
 assign hdm2ip_aximm0_buser      =  hdm2ip_aximm_buser  [0] ;
 assign hdm2ip_aximm0_bresp      =  hdm2ip_aximm_bresp  [0] ;
 assign hdm2ip_aximm0_arready    =  hdm2ip_aximm_arready[0] ;
 assign hdm2ip_aximm0_rvalid     =  hdm2ip_aximm_rvalid [0] ;
 assign hdm2ip_aximm0_rlast      =  hdm2ip_aximm_rlast  [0] ;
 assign hdm2ip_aximm0_rid        =  hdm2ip_aximm_rid    [0] ;
 assign hdm2ip_aximm0_rdata      =  hdm2ip_aximm_rdata  [0] ;
 assign hdm2ip_aximm0_ruser      =  hdm2ip_aximm_ruser  [0] ;
 assign hdm2ip_aximm0_rresp      =  hdm2ip_aximm_rresp  [0] ;

//Channel-1
 assign ip2hdm_aximm_awid    [1] = ip2hdm_aximm1_awid ;
 assign ip2hdm_aximm_awaddr  [1] = ip2hdm_aximm1_awaddr ;
 assign ip2hdm_aximm_awlen   [1] = ip2hdm_aximm1_awlen ;
 assign ip2hdm_aximm_awregion[1] = ip2hdm_aximm1_awregion ;
 assign ip2hdm_aximm_awuser  [1] = ip2hdm_aximm1_awuser ;
 assign ip2hdm_aximm_awsize  [1] = ip2hdm_aximm1_awsize  ;
 assign ip2hdm_aximm_awburst [1] = ip2hdm_aximm1_awburst ;
 assign ip2hdm_aximm_awprot  [1] = ip2hdm_aximm1_awprot  ;
 assign ip2hdm_aximm_awqos   [1] = ip2hdm_aximm1_awqos   ;
 assign ip2hdm_aximm_awcache [1] = ip2hdm_aximm1_awcache ;
 assign ip2hdm_aximm_awlock  [1] = ip2hdm_aximm1_awlock  ;
 assign ip2hdm_aximm_awvalid [1] = ip2hdm_aximm1_awvalid;
 assign ip2hdm_aximm_wdata   [1] = ip2hdm_aximm1_wdata ;
 assign ip2hdm_aximm_wstrb   [1] = ip2hdm_aximm1_wstrb ;
 assign ip2hdm_aximm_wlast   [1] = ip2hdm_aximm1_wlast ;
 assign ip2hdm_aximm_wuser   [1] = ip2hdm_aximm1_wuser ;
 assign ip2hdm_aximm_wvalid  [1] = ip2hdm_aximm1_wvalid;
 assign ip2hdm_aximm_bready  [1] = ip2hdm_aximm1_bready ;
 assign ip2hdm_aximm_arid    [1] = ip2hdm_aximm1_arid ;
 assign ip2hdm_aximm_araddr  [1] = ip2hdm_aximm1_araddr ;
 assign ip2hdm_aximm_arlen   [1] = ip2hdm_aximm1_arlen ;
 assign ip2hdm_aximm_arregion[1] = ip2hdm_aximm1_arregion ;
 assign ip2hdm_aximm_aruser  [1] = ip2hdm_aximm1_aruser ;
 assign ip2hdm_aximm_arsize  [1] = ip2hdm_aximm1_arsize ;
 assign ip2hdm_aximm_arburst [1] = ip2hdm_aximm1_arburst ;
 assign ip2hdm_aximm_arprot  [1] = ip2hdm_aximm1_arprot  ;
 assign ip2hdm_aximm_arqos   [1] = ip2hdm_aximm1_arqos  ;
 assign ip2hdm_aximm_arcache [1] = ip2hdm_aximm1_arcache ;
 assign ip2hdm_aximm_arlock  [1] = ip2hdm_aximm1_arlock ;
 assign ip2hdm_aximm_arvalid [1] = ip2hdm_aximm1_arvalid;
 assign ip2hdm_aximm_rready  [1] = ip2hdm_aximm1_rready ;
 
 assign hdm2ip_aximm1_awready    =  hdm2ip_aximm_awready[1] ;
 assign hdm2ip_aximm1_wready     =  hdm2ip_aximm_wready [1] ;
 assign hdm2ip_aximm1_bvalid     =  hdm2ip_aximm_bvalid [1] ;
 assign hdm2ip_aximm1_bid        =  hdm2ip_aximm_bid    [1] ;
 assign hdm2ip_aximm1_buser      =  hdm2ip_aximm_buser  [1] ;
 assign hdm2ip_aximm1_bresp      =  hdm2ip_aximm_bresp  [1] ;
 assign hdm2ip_aximm1_arready    =  hdm2ip_aximm_arready[1] ;
 assign hdm2ip_aximm1_rvalid     =  hdm2ip_aximm_rvalid [1] ;
 assign hdm2ip_aximm1_rlast      =  hdm2ip_aximm_rlast  [1] ;
 assign hdm2ip_aximm1_rid        =  hdm2ip_aximm_rid    [1] ;
 assign hdm2ip_aximm1_rdata      =  hdm2ip_aximm_rdata  [1] ;
 assign hdm2ip_aximm1_ruser      =  hdm2ip_aximm_ruser  [1] ;
 assign hdm2ip_aximm1_rresp      =  hdm2ip_aximm_rresp  [1] ;


//Channel-2
 assign ip2hdm_aximm_awid    [2] = ip2hdm_aximm2_awid ;
 assign ip2hdm_aximm_awaddr  [2] = ip2hdm_aximm2_awaddr ;
 assign ip2hdm_aximm_awlen   [2] = ip2hdm_aximm2_awlen ;
 assign ip2hdm_aximm_awregion[2] = ip2hdm_aximm2_awregion ;
 assign ip2hdm_aximm_awuser  [2] = ip2hdm_aximm2_awuser ;
 assign ip2hdm_aximm_awsize  [2] = ip2hdm_aximm2_awsize  ;
 assign ip2hdm_aximm_awburst [2] = ip2hdm_aximm2_awburst ;
 assign ip2hdm_aximm_awprot  [2] = ip2hdm_aximm2_awprot  ;
 assign ip2hdm_aximm_awqos   [2] = ip2hdm_aximm2_awqos   ;
 assign ip2hdm_aximm_awcache [2] = ip2hdm_aximm2_awcache ;
 assign ip2hdm_aximm_awlock  [2] = ip2hdm_aximm2_awlock  ;
 assign ip2hdm_aximm_awvalid [2] = ip2hdm_aximm2_awvalid;
 assign ip2hdm_aximm_wdata   [2] = ip2hdm_aximm2_wdata ;
 assign ip2hdm_aximm_wstrb   [2] = ip2hdm_aximm2_wstrb ;
 assign ip2hdm_aximm_wlast   [2] = ip2hdm_aximm2_wlast ;
 assign ip2hdm_aximm_wuser   [2] = ip2hdm_aximm2_wuser ;
 assign ip2hdm_aximm_wvalid  [2] = ip2hdm_aximm2_wvalid;
 assign ip2hdm_aximm_bready  [2] = ip2hdm_aximm2_bready ;
 assign ip2hdm_aximm_arid    [2] = ip2hdm_aximm2_arid ;
 assign ip2hdm_aximm_araddr  [2] = ip2hdm_aximm2_araddr ;
 assign ip2hdm_aximm_arlen   [2] = ip2hdm_aximm2_arlen ;
 assign ip2hdm_aximm_arregion[2] = ip2hdm_aximm2_arregion ;
 assign ip2hdm_aximm_aruser  [2] = ip2hdm_aximm2_aruser ;
 assign ip2hdm_aximm_arsize  [2] = ip2hdm_aximm2_arsize ;
 assign ip2hdm_aximm_arburst [2] = ip2hdm_aximm2_arburst ;
 assign ip2hdm_aximm_arprot  [2] = ip2hdm_aximm2_arprot  ;
 assign ip2hdm_aximm_arqos   [2] = ip2hdm_aximm2_arqos  ;
 assign ip2hdm_aximm_arcache [2] = ip2hdm_aximm2_arcache ;
 assign ip2hdm_aximm_arlock  [2] = ip2hdm_aximm2_arlock ;
 assign ip2hdm_aximm_arvalid [2] = ip2hdm_aximm2_arvalid;
 assign ip2hdm_aximm_rready  [2] = ip2hdm_aximm2_rready ;
 
 assign hdm2ip_aximm2_awready    =  hdm2ip_aximm_awready[2] ;
 assign hdm2ip_aximm2_wready     =  hdm2ip_aximm_wready [2] ;
 assign hdm2ip_aximm2_bvalid     =  hdm2ip_aximm_bvalid [2] ;
 assign hdm2ip_aximm2_bid        =  hdm2ip_aximm_bid    [2] ;
 assign hdm2ip_aximm2_buser      =  hdm2ip_aximm_buser  [2] ;
 assign hdm2ip_aximm2_bresp      =  hdm2ip_aximm_bresp  [2] ;
 assign hdm2ip_aximm2_arready    =  hdm2ip_aximm_arready[2] ;
 assign hdm2ip_aximm2_rvalid     =  hdm2ip_aximm_rvalid [2] ;
 assign hdm2ip_aximm2_rlast      =  hdm2ip_aximm_rlast  [2] ;
 assign hdm2ip_aximm2_rid        =  hdm2ip_aximm_rid    [2] ;
 assign hdm2ip_aximm2_rdata      =  hdm2ip_aximm_rdata  [2] ;
 assign hdm2ip_aximm2_ruser      =  hdm2ip_aximm_ruser  [2] ;
 assign hdm2ip_aximm2_rresp      =  hdm2ip_aximm_rresp  [2] ;

//Channel-3
 assign ip2hdm_aximm_awid    [3] = ip2hdm_aximm3_awid ;
 assign ip2hdm_aximm_awaddr  [3] = ip2hdm_aximm3_awaddr ;
 assign ip2hdm_aximm_awlen   [3] = ip2hdm_aximm3_awlen ;
 assign ip2hdm_aximm_awregion[3] = ip2hdm_aximm3_awregion ;
 assign ip2hdm_aximm_awuser  [3] = ip2hdm_aximm3_awuser ;
 assign ip2hdm_aximm_awsize  [3] = ip2hdm_aximm3_awsize  ;
 assign ip2hdm_aximm_awburst [3] = ip2hdm_aximm3_awburst ;
 assign ip2hdm_aximm_awprot  [3] = ip2hdm_aximm3_awprot  ;
 assign ip2hdm_aximm_awqos   [3] = ip2hdm_aximm3_awqos   ;
 assign ip2hdm_aximm_awcache [3] = ip2hdm_aximm3_awcache ;
 assign ip2hdm_aximm_awlock  [3] = ip2hdm_aximm3_awlock  ;
 assign ip2hdm_aximm_awvalid [3] = ip2hdm_aximm3_awvalid;
 assign ip2hdm_aximm_wdata   [3] = ip2hdm_aximm3_wdata ;
 assign ip2hdm_aximm_wstrb   [3] = ip2hdm_aximm3_wstrb ;
 assign ip2hdm_aximm_wlast   [3] = ip2hdm_aximm3_wlast ;
 assign ip2hdm_aximm_wuser   [3] = ip2hdm_aximm3_wuser ;
 assign ip2hdm_aximm_wvalid  [3] = ip2hdm_aximm3_wvalid;
 assign ip2hdm_aximm_bready  [3] = ip2hdm_aximm3_bready ;
 assign ip2hdm_aximm_arid    [3] = ip2hdm_aximm3_arid ;
 assign ip2hdm_aximm_araddr  [3] = ip2hdm_aximm3_araddr ;
 assign ip2hdm_aximm_arlen   [3] = ip2hdm_aximm3_arlen ;
 assign ip2hdm_aximm_arregion[3] = ip2hdm_aximm3_arregion ;
 assign ip2hdm_aximm_aruser  [3] = ip2hdm_aximm3_aruser ;
 assign ip2hdm_aximm_arsize  [3] = ip2hdm_aximm3_arsize ;
 assign ip2hdm_aximm_arburst [3] = ip2hdm_aximm3_arburst ;
 assign ip2hdm_aximm_arprot  [3] = ip2hdm_aximm3_arprot  ;
 assign ip2hdm_aximm_arqos   [3] = ip2hdm_aximm3_arqos  ;
 assign ip2hdm_aximm_arcache [3] = ip2hdm_aximm3_arcache ;
 assign ip2hdm_aximm_arlock  [3] = ip2hdm_aximm3_arlock ;
 assign ip2hdm_aximm_arvalid [3] = ip2hdm_aximm3_arvalid;
 assign ip2hdm_aximm_rready  [3] = ip2hdm_aximm3_rready ;
 
 assign hdm2ip_aximm3_awready    =  hdm2ip_aximm_awready[3] ;
 assign hdm2ip_aximm3_wready     =  hdm2ip_aximm_wready [3] ;
 assign hdm2ip_aximm3_bvalid     =  hdm2ip_aximm_bvalid [3] ;
 assign hdm2ip_aximm3_bid        =  hdm2ip_aximm_bid    [3] ;
 assign hdm2ip_aximm3_buser      =  hdm2ip_aximm_buser  [3] ;
 assign hdm2ip_aximm3_bresp      =  hdm2ip_aximm_bresp  [3] ;
 assign hdm2ip_aximm3_arready    =  hdm2ip_aximm_arready[3] ;
 assign hdm2ip_aximm3_rvalid     =  hdm2ip_aximm_rvalid [3] ;
 assign hdm2ip_aximm3_rlast      =  hdm2ip_aximm_rlast  [3] ;
 assign hdm2ip_aximm3_rid        =  hdm2ip_aximm_rid    [3] ;
 assign hdm2ip_aximm3_rdata      =  hdm2ip_aximm_rdata  [3] ;
 assign hdm2ip_aximm3_ruser      =  hdm2ip_aximm_ruser  [3] ;
 assign hdm2ip_aximm3_rresp      =  hdm2ip_aximm_rresp  [3] ;


 `else

 assign   mc2ip_0_sr_status      =  mc_status[0]                   ;
 assign   mc2ip_1_sr_status      =  mc_status[1]                   ;


//Channel-0
 assign ip2hdm_aximm_awid    [0] = ip2hdm_aximm0_awid ;
 assign ip2hdm_aximm_awaddr  [0] = ip2hdm_aximm0_awaddr ;
 assign ip2hdm_aximm_awlen   [0] = ip2hdm_aximm0_awlen ;
 assign ip2hdm_aximm_awregion[0] = ip2hdm_aximm0_awregion ;
 assign ip2hdm_aximm_awuser  [0] = ip2hdm_aximm0_awuser ;
 assign ip2hdm_aximm_awsize  [0] = ip2hdm_aximm0_awsize  ;
 assign ip2hdm_aximm_awburst [0] = ip2hdm_aximm0_awburst ;
 assign ip2hdm_aximm_awprot  [0] = ip2hdm_aximm0_awprot  ;
 assign ip2hdm_aximm_awqos   [0] = ip2hdm_aximm0_awqos   ;
 assign ip2hdm_aximm_awcache [0] = ip2hdm_aximm0_awcache ;
 assign ip2hdm_aximm_awlock  [0] = ip2hdm_aximm0_awlock  ;
 assign ip2hdm_aximm_awvalid [0] = ip2hdm_aximm0_awvalid;
 assign ip2hdm_aximm_wdata   [0] = ip2hdm_aximm0_wdata ;
 assign ip2hdm_aximm_wstrb   [0] = ip2hdm_aximm0_wstrb ;
 assign ip2hdm_aximm_wlast   [0] = ip2hdm_aximm0_wlast ;
 assign ip2hdm_aximm_wuser   [0] = ip2hdm_aximm0_wuser ;
 assign ip2hdm_aximm_wvalid  [0] = ip2hdm_aximm0_wvalid;
 assign ip2hdm_aximm_bready  [0] = ip2hdm_aximm0_bready ;

 //adding FIFO on the AR channel 0
 typedef struct packed {
    logic  [7:0]   arid       ;         
    logic  [51:0]  araddr     ;         
    logic  [9:0]   arlen      ;         
    logic  [3:0]   arregion   ;         
    logic          aruser     ;         
    logic  [2:0]   arsize     ;         
    logic  [1:0]   arburst    ;         
    logic  [2:0]   arprot     ;         
    logic  [3:0]   arqos      ;         
    logic  [3:0]   arcache    ;         
    logic  [1:0]   arlock     ;         
 } ar_channel_t;
 
 ar_channel_t   ar_ch_0_fifo_din;
 ar_channel_t   ar_ch_0_fifo_dout;
 logic          ar_ch_0_fifo_empty;
 logic          ar_ch_0_fifo_full;

 assign ar_ch_0_fifo_din.arid     = ip2hdm_aximm0_arid;
 assign ar_ch_0_fifo_din.araddr   = ip2hdm_aximm0_araddr;
 assign ar_ch_0_fifo_din.arlen    = ip2hdm_aximm0_arlen;
 assign ar_ch_0_fifo_din.arregion = ip2hdm_aximm0_arregion;
 assign ar_ch_0_fifo_din.aruser   = ip2hdm_aximm0_aruser;
 assign ar_ch_0_fifo_din.arsize   = ip2hdm_aximm0_arsize;
 assign ar_ch_0_fifo_din.arburst  = ip2hdm_aximm0_arburst;
 assign ar_ch_0_fifo_din.arprot   = ip2hdm_aximm0_arprot;
 assign ar_ch_0_fifo_din.arqos    = ip2hdm_aximm0_arqos;
 assign ar_ch_0_fifo_din.arcache  = ip2hdm_aximm0_arcache;
 assign ar_ch_0_fifo_din.arlock   = ip2hdm_aximm0_arlock;

sync_fifo
#(
    .LOG_DEPTH       (3),
    .WIDTH           ($bits(ar_channel_t)),
    .USE_LUTRAM      (1),
    .USE_OUTREG      (1),
    .SHOW_AHEAD      (1)
)
u_ar_ch_0_fifo (
    .rst            (~rst_n),
    .clk            (clk),
    .wrreq          (ip2hdm_aximm0_arvalid && ~ar_ch_0_fifo_full),
    .data           (ar_ch_0_fifo_din),
    .rdreq          (~ar_ch_0_fifo_empty && hdm2ip_aximm_arready[0]),
    .q              (ar_ch_0_fifo_dout),
    .full           (ar_ch_0_fifo_full),
    .almostfull     (),
    .empty          (ar_ch_0_fifo_empty),
    .almostempty    (),
    .overflow       (),
    .usedw          ()
);


 assign ip2hdm_aximm_arid    [0] = ar_ch_0_fifo_dout.arid ;
 assign ip2hdm_aximm_araddr  [0] = ar_ch_0_fifo_dout.araddr ;
 assign ip2hdm_aximm_arlen   [0] = ar_ch_0_fifo_dout.arlen ;
 assign ip2hdm_aximm_arregion[0] = ar_ch_0_fifo_dout.arregion ;
 assign ip2hdm_aximm_aruser  [0] = ar_ch_0_fifo_dout.aruser ;
 assign ip2hdm_aximm_arsize  [0] = ar_ch_0_fifo_dout.arsize ;
 assign ip2hdm_aximm_arburst [0] = ar_ch_0_fifo_dout.arburst ;
 assign ip2hdm_aximm_arprot  [0] = ar_ch_0_fifo_dout.arprot  ;
 assign ip2hdm_aximm_arqos   [0] = ar_ch_0_fifo_dout.arqos  ;
 assign ip2hdm_aximm_arcache [0] = ar_ch_0_fifo_dout.arcache ;
 assign ip2hdm_aximm_arlock  [0] = ar_ch_0_fifo_dout.arlock ;
 assign ip2hdm_aximm_arvalid [0] = ~ar_ch_0_fifo_empty;
 assign ip2hdm_aximm_rready  [0] = ip2hdm_aximm0_rready ;
 
 assign hdm2ip_aximm0_awready    =  hdm2ip_aximm_awready[0] ;
 assign hdm2ip_aximm0_wready     =  hdm2ip_aximm_wready [0] ;
 assign hdm2ip_aximm0_bvalid     =  hdm2ip_aximm_bvalid [0] ;
 assign hdm2ip_aximm0_bid        =  hdm2ip_aximm_bid    [0] ;
 assign hdm2ip_aximm0_buser      =  hdm2ip_aximm_buser  [0] ;
 assign hdm2ip_aximm0_bresp      =  hdm2ip_aximm_bresp  [0] ;
 assign hdm2ip_aximm0_arready    =  ~ar_ch_0_fifo_full;
 assign hdm2ip_aximm0_rvalid     =  hdm2ip_aximm_rvalid [0] ;
 assign hdm2ip_aximm0_rlast      =  hdm2ip_aximm_rlast  [0] ;
 assign hdm2ip_aximm0_rid        =  hdm2ip_aximm_rid    [0] ;
 assign hdm2ip_aximm0_rdata      =  hdm2ip_aximm_rdata  [0] ;
 assign hdm2ip_aximm0_ruser      =  hdm2ip_aximm_ruser  [0] ;
 assign hdm2ip_aximm0_rresp      =  hdm2ip_aximm_rresp  [0] ;

//Channel-1
 assign ip2hdm_aximm_awid    [1] = ip2hdm_aximm1_awid ;
 assign ip2hdm_aximm_awaddr  [1] = ip2hdm_aximm1_awaddr ;
 assign ip2hdm_aximm_awlen   [1] = ip2hdm_aximm1_awlen ;
 assign ip2hdm_aximm_awregion[1] = ip2hdm_aximm1_awregion ;
 assign ip2hdm_aximm_awuser  [1] = ip2hdm_aximm1_awuser ;
 assign ip2hdm_aximm_awsize  [1] = ip2hdm_aximm1_awsize  ;
 assign ip2hdm_aximm_awburst [1] = ip2hdm_aximm1_awburst ;
 assign ip2hdm_aximm_awprot  [1] = ip2hdm_aximm1_awprot  ;
 assign ip2hdm_aximm_awqos   [1] = ip2hdm_aximm1_awqos   ;
 assign ip2hdm_aximm_awcache [1] = ip2hdm_aximm1_awcache ;
 assign ip2hdm_aximm_awlock  [1] = ip2hdm_aximm1_awlock  ;
 assign ip2hdm_aximm_awvalid [1] = ip2hdm_aximm1_awvalid;
 assign ip2hdm_aximm_wdata   [1] = ip2hdm_aximm1_wdata ;
 assign ip2hdm_aximm_wstrb   [1] = ip2hdm_aximm1_wstrb ;
 assign ip2hdm_aximm_wlast   [1] = ip2hdm_aximm1_wlast ;
 assign ip2hdm_aximm_wuser   [1] = ip2hdm_aximm1_wuser ;
 assign ip2hdm_aximm_wvalid  [1] = ip2hdm_aximm1_wvalid;
 assign ip2hdm_aximm_bready  [1] = ip2hdm_aximm1_bready ;


 ar_channel_t   ar_ch_1_fifo_din;
 ar_channel_t   ar_ch_1_fifo_dout;
 logic          ar_ch_1_fifo_empty;
 logic          ar_ch_1_fifo_full;

 assign ar_ch_1_fifo_din.arid     = ip2hdm_aximm1_arid;
 assign ar_ch_1_fifo_din.araddr   = ip2hdm_aximm1_araddr;
 assign ar_ch_1_fifo_din.arlen    = ip2hdm_aximm1_arlen;
 assign ar_ch_1_fifo_din.arregion = ip2hdm_aximm1_arregion;
 assign ar_ch_1_fifo_din.aruser   = ip2hdm_aximm1_aruser;
 assign ar_ch_1_fifo_din.arsize   = ip2hdm_aximm1_arsize;
 assign ar_ch_1_fifo_din.arburst  = ip2hdm_aximm1_arburst;
 assign ar_ch_1_fifo_din.arprot   = ip2hdm_aximm1_arprot;
 assign ar_ch_1_fifo_din.arqos    = ip2hdm_aximm1_arqos;
 assign ar_ch_1_fifo_din.arcache  = ip2hdm_aximm1_arcache;
 assign ar_ch_1_fifo_din.arlock   = ip2hdm_aximm1_arlock;

sync_fifo
#(
    .LOG_DEPTH       (3),
    .WIDTH           ($bits(ar_channel_t)),
    .USE_LUTRAM      (1),
    .USE_OUTREG      (1),
    .SHOW_AHEAD      (1)
)
u_ar_ch_1_fifo (
    .rst            (~rst_n),
    .clk            (clk),
    .wrreq          (ip2hdm_aximm1_arvalid && ~ar_ch_1_fifo_full),
    .data           (ar_ch_1_fifo_din),
    .rdreq          (~ar_ch_1_fifo_empty && hdm2ip_aximm_arready[1]),
    .q              (ar_ch_1_fifo_dout),
    .full           (ar_ch_1_fifo_full),
    .almostfull     (),
    .empty          (ar_ch_1_fifo_empty),
    .almostempty    (),
    .overflow       (),
    .usedw          ()
);

 assign ip2hdm_aximm_arid    [1] = ar_ch_1_fifo_dout.arid ;
 assign ip2hdm_aximm_araddr  [1] = ar_ch_1_fifo_dout.araddr ;
 assign ip2hdm_aximm_arlen   [1] = ar_ch_1_fifo_dout.arlen ;
 assign ip2hdm_aximm_arregion[1] = ar_ch_1_fifo_dout.arregion ;
 assign ip2hdm_aximm_aruser  [1] = ar_ch_1_fifo_dout.aruser ;
 assign ip2hdm_aximm_arsize  [1] = ar_ch_1_fifo_dout.arsize ;
 assign ip2hdm_aximm_arburst [1] = ar_ch_1_fifo_dout.arburst ;
 assign ip2hdm_aximm_arprot  [1] = ar_ch_1_fifo_dout.arprot  ;
 assign ip2hdm_aximm_arqos   [1] = ar_ch_1_fifo_dout.arqos  ;
 assign ip2hdm_aximm_arcache [1] = ar_ch_1_fifo_dout.arcache ;
 assign ip2hdm_aximm_arlock  [1] = ar_ch_1_fifo_dout.arlock ;
 assign ip2hdm_aximm_arvalid [1] = ~ar_ch_1_fifo_empty;
 assign ip2hdm_aximm_rready  [1] = ip2hdm_aximm1_rready ;
 
 assign hdm2ip_aximm1_awready    =  hdm2ip_aximm_awready[1] ;
 assign hdm2ip_aximm1_wready     =  hdm2ip_aximm_wready [1] ;
 assign hdm2ip_aximm1_bvalid     =  hdm2ip_aximm_bvalid [1] ;
 assign hdm2ip_aximm1_bid        =  hdm2ip_aximm_bid    [1] ;
 assign hdm2ip_aximm1_buser      =  hdm2ip_aximm_buser  [1] ;
 assign hdm2ip_aximm1_bresp      =  hdm2ip_aximm_bresp  [1] ;
 assign hdm2ip_aximm1_arready    =  ~ar_ch_1_fifo_full ;
 assign hdm2ip_aximm1_rvalid     =  hdm2ip_aximm_rvalid [1] ;
 assign hdm2ip_aximm1_rlast      =  hdm2ip_aximm_rlast  [1] ;
 assign hdm2ip_aximm1_rid        =  hdm2ip_aximm_rid    [1] ;
 assign hdm2ip_aximm1_rdata      =  hdm2ip_aximm_rdata  [1] ;
 assign hdm2ip_aximm1_ruser      =  hdm2ip_aximm_ruser  [1] ;
 assign hdm2ip_aximm1_rresp      =  hdm2ip_aximm_rresp  [1] ;


`endif	

`else
assign iafu2cxlip_ready_eclk                = mc2iafu_ready_eclk             ;
assign iafu2cxlip_read_poison_eclk          = mc2iafu_read_poison_eclk       ;
assign iafu2cxlip_readdatavalid_eclk        = mc2iafu_readdatavalid_eclk     ;
assign iafu2cxlip_ecc_err_corrected_eclk    = mc2iafu_ecc_err_corrected_eclk ;
assign iafu2cxlip_ecc_err_detected_eclk     = mc2iafu_ecc_err_detected_eclk  ;
assign iafu2cxlip_ecc_err_fatal_eclk        = mc2iafu_ecc_err_fatal_eclk     ;
assign iafu2cxlip_ecc_err_syn_e_eclk        = mc2iafu_ecc_err_syn_e_eclk     ;
assign iafu2cxlip_ecc_err_valid_eclk        = mc2iafu_ecc_err_valid_eclk     ;
assign iafu2cxlip_cxlmem_ready              = mc2iafu_cxlmem_ready           ;
assign iafu2cxlip_readdata_eclk             = mc2iafu_readdata_eclk          ;
assign iafu2cxlip_rsp_mdata_eclk            = mc2iafu_rsp_mdata_eclk         ;  


assign iafu2mc_writedata_eclk               = cxlip2iafu_writedata_eclk     ;
assign iafu2mc_byteenable_eclk              = cxlip2iafu_byteenable_eclk    ;
assign iafu2mc_read_eclk                    = cxlip2iafu_read_eclk          ;
assign iafu2mc_write_eclk                   = cxlip2iafu_write_eclk         ;
assign iafu2mc_write_poison_eclk            = cxlip2iafu_write_poison_eclk  ;
assign iafu2mc_write_ras_sbe_eclk           = cxlip2iafu_write_ras_sbe_eclk ;
assign iafu2mc_write_ras_dbe_eclk           = cxlip2iafu_write_ras_dbe_eclk ;
//assign iafu2mc_address_eclk                 = cxlip2iafu_chan_address_eclk       ;
assign iafu2mc_address_eclk                 = cxlip2iafu_address_eclk       ;
assign iafu2mc_req_mdata_eclk               = cxlip2iafu_req_mdata_eclk     ;

`endif


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "xOiMljyL+uEG4POJPfCL4p5v8YxX3yRYbM/Lvsk+r2yHjggdh2qskEj/0KRQ3+PEhBaUYq1/BqG8Yv2Si7VVH0jVEPw5rrxpaRXSzzVL6+z1QOpVXV0BqMuMzgRIAm9iJBd56K7WBlHO+OiDPfSEju3siYKQ0p6m4nCaQ1Mu1bEKBRXapesxsjTaDwLjA2d6l7rjbnzSdjUNvgk8V++w225chQSu0hR3a9RzKBKy7+GTymVGuIWOjaH0p8nVkuokHQ3arxoJadBYYff36JfMjYBHswB7CXbvNDizHTQtbiPHroBb6LuixWP30KAI2vQpbPAf3Gf0DVv5ccdcuqZN7Y0Gtlo/fiUbevfvYmaokd8JIc2E0fQ8ZXYE/bXZ+cCirM5Lh3lr6X+cmqZfaLMypZgdoO8xrvDFHYt0Hp5sT6xsz3rqLR69bRZvqzIk60O/mVKvk29KjZA0AbgfUuJx/9cc3U+HI5tujElfwVtgA43fG26kRJxvhTu+2iAMGvY3B4gMPPw/v1o4ukPmDOOACIFys1hy7yBp71QVNCetV1N3MbRWCjJmruR5LtAsxfrfSsnzXXsmujIo+CJ1s2LGB6j3SzTFzcC4e8hQKUIbZ6BZ5KOeBHWxA4f1w34calcsngccvQ9lJh69CNocc+anqdVgb5VlbRtvq+rF1xb/lP84ceih56vXRsX92qsLLN0ydT0X6QizOoeF1yYGNZUcS0aZXPc/cNjfA+ZuSUHoQpxOfarrSNJ5e+RBWHfthXQ9SosJaSgqaBZeydyBJdfrViC8xhzsP+iiSplD7QJdgoh5Lo/QyuIuh5ECkcnhAKh6n/XTOJwjLnx7TUPyHkQIRAnhzDsIBqWX/ezpzHnrXg/3R5liynNTUh9Id0T2X4MdeGNulOKxUzMGLW6L8JuVUvkI8B/KMxKJy5TaW3Mkln4v38ucRO/2ZetzApewHHM2aXWGo5M5mQ66X2ElEhr2Cxa5YCvGmKfCN1IqLBD3S+2FsDITdAbieCeCEYkkzOiy"
`endif