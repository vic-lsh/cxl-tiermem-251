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

import afu_axi_if_pkg::*;
module intel_cxl_afu_cache_io_demux( 

    input					clk,
    input					rst,

    input					afu_cache_io_select, //afu_cache_io_select == 1 ? select io else cache
    //--to/from afu
    input   t_axi4_rd_addr_ch                   afu_axi_ar,
    output  t_axi4_rd_addr_ready                afu_axi_arready,    
    output  t_axi4_rd_resp_ch                   afu_axi_r,
    input   t_axi4_rd_resp_ready                afu_axi_rready, 
   
    input   t_axi4_wr_addr_ch                   afu_axi_aw,
    output  t_axi4_wr_addr_ready                afu_axi_awready,   
    input   t_axi4_wr_data_ch                   afu_axi_w,
    output  t_axi4_wr_data_ready                afu_axi_wready,    
    output  t_axi4_wr_resp_ch                   afu_axi_b,
    input   t_axi4_wr_resp_ready                afu_axi_bready,    

    //-- to/from cache
    output   t_axi4_rd_addr_ch                   afu_cache_axi_ar,
    input    t_axi4_rd_addr_ready                afu_cache_axi_arready,    
    input    t_axi4_rd_resp_ch                   afu_cache_axi_r,
    output   t_axi4_rd_resp_ready                afu_cache_axi_rready, 
   
    output   t_axi4_wr_addr_ch                   afu_cache_axi_aw,
    input    t_axi4_wr_addr_ready                afu_cache_axi_awready,   
    output   t_axi4_wr_data_ch                   afu_cache_axi_w,
    input    t_axi4_wr_data_ready                afu_cache_axi_wready,    
    input    t_axi4_wr_resp_ch                   afu_cache_axi_b,
    output   t_axi4_wr_resp_ready                afu_cache_axi_bready,    

    //-- to/from io
    output   t_axi4_rd_addr_ch                   afu_io_axi_ar,
    input    t_axi4_rd_addr_ready                afu_io_axi_arready,    
    input    t_axi4_rd_resp_ch                   afu_io_axi_r,
    output   t_axi4_rd_resp_ready                afu_io_axi_rready, 
   
    output   t_axi4_wr_addr_ch                   afu_io_axi_aw,
    input    t_axi4_wr_addr_ready                afu_io_axi_awready,   
    output   t_axi4_wr_data_ch                   afu_io_axi_w,
    input    t_axi4_wr_data_ready                afu_io_axi_wready,    
    input    t_axi4_wr_resp_ch                   afu_io_axi_b,
    output   t_axi4_wr_resp_ready                afu_io_axi_bready

);

    assign afu_io_axi_ar         = afu_cache_io_select ? afu_axi_ar             : 'h0  ;
    assign afu_io_axi_rready     = afu_cache_io_select ? afu_axi_rready         : 'h0  ;
    assign afu_io_axi_aw         = afu_cache_io_select ? afu_axi_aw             : 'h0  ;
    assign afu_io_axi_w          = afu_cache_io_select ? afu_axi_w              : 'h0  ;
    assign afu_io_axi_bready     = afu_cache_io_select ? afu_axi_bready         : 'h0  ;

    assign afu_axi_arready       = afu_cache_io_select ? afu_io_axi_arready     :  afu_cache_axi_arready  ;
    assign afu_axi_r             = afu_cache_io_select ? afu_io_axi_r           :  afu_cache_axi_r        ;
    assign afu_axi_awready       = afu_cache_io_select ? afu_io_axi_awready     :  afu_cache_axi_awready  ;
    assign afu_axi_wready        = afu_cache_io_select ? afu_io_axi_wready      :  afu_cache_axi_wready   ;
    assign afu_axi_b             = afu_cache_io_select ? afu_io_axi_b           :  afu_cache_axi_b        ;

    assign afu_cache_axi_ar      = afu_cache_io_select ? 'h0 : afu_axi_ar       ;
    assign afu_cache_axi_rready  = afu_cache_io_select ? 'h0 : afu_axi_rready   ;
    assign afu_cache_axi_aw      = afu_cache_io_select ? 'h0 : afu_axi_aw       ;
    assign afu_cache_axi_w       = afu_cache_io_select ? 'h0 : afu_axi_w        ;
    assign afu_cache_axi_bready  = afu_cache_io_select ? 'h0 : afu_axi_bready   ;

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "VPRJHuKBSkSPGqxQDsKp6ARIrVJ/JuQG7uZx0P1nXK/e/CQAE/8L7VsejyszKLHa9j1PwK+IcBx4m6FOfacz5KCx7FTpSaNB7yKuch2x0uA1d+KbFLrhoAwDqySq9o2kAG7O4YN2yedXt8uVKVTd5vlDnbKG0FLvgE1X9gEV8z6fMxtQhu0DZwctIsD8CwbTu6sDbR6mv/DpJi4GBU9qJgx5VtJ+E16qkMADG1A0VfU6uQRovDTzxG9AdaDYn98B0gm77pNymjbwZyRSfCwlNp0oxdh0i7q4Q6iDxLL8u5cppDucqQLNMuviyXZB3Tcf/+BjSdSTQAonRdFJ1puihnXt6C6O3j67HHqNVqo8Buq7c95iYU17MWllgIe45T/U/4RaoQA30GAs/PxLYiQlDjCk7KybP6vySB3mrxpERtq3SQygkNBcQ775F4K2oYU2AwmAmqEHmcdl14s38GPBsPaUlYWb48V5XW4D/Z6Uhn5anxxii0mVGsDP3PvoNJTnZA642OTT325NzaWtk/vkP10PivKwwJgizFtKy9iJLP0JR1VW1ctg3sqIv6YxQJXEUQBZKoXWiU/mtikJG39usR3CEr7f0clbDuspgJxktvmfhDMS4AwPRWN5K304m4lSBvhnxHzuTGJlZgdr4qnOYdApzcEEXP7YUmLiCMIvoaNVTw8ao4QtdJNZOhA19Jsdj1rAnF4coLPlZbCPrGUN0RopRsZLRs3bP219mdKtdXSjMd7F+euU4Winz93zodhfbTQG9PeBHSFA1gtrdMlFZ6sOxPoxrCufLP+r3FEwJkOHZskBAW+Me/OgkZgqdTGTPFfcfv0lcZhhyHRaceGv7oYgjral6fnWLgjsurwxgRKI/0RCTuHFvzJi56XSpHhRP4XqM+lz0slZ3Ks8LUgCAkJJrY4ZQXlXWQn1x2OLaULcE9x6dvRs6BjA8kZbi1+LAkZQuvpaQC1BXTj8Y6HHz1/8NPmlM/O+J9KK2FBmZw4sTIjq5qR0/EIERrT0MdGn"
`endif