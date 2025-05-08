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


// Copyright 2022 Intel Corporation.
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

package ext_csr_if_pkg;

// copied from cafu csr0 cfg pkg
typedef struct packed {
    logic  [0:0] power_mgt_init_complete;  // RO/V
    logic [11:0] reserved0;  // RSVD
    logic  [0:0] cxl_reset_error;  // RO/V
    logic  [0:0] cxl_reset_complete;  // RO/V
    logic  [0:0] cache_invalid;  // RO/V
    logic [11:0] reserved1;  // RSVD
    logic  [0:0] cxl_reset_mem_clr_enable;  // RW
    logic  [0:0] initiate_cxl_reset;  // RW/1S/V
    logic  [0:0] initiate_cache_wb_and_inv;  // RW/1S/V
    logic  [0:0] disable_caching;  // RW
} bbs_copy_cafu_DVSEC_FBCTRL2_STATUS2_t;

// copied from cafu csr0 cfg pkg
typedef struct packed {
    logic  [0:0] pm_init_comp_capable;  // RO
    logic  [0:0] viral_capable;  // RO
    logic  [0:0] mld;  // RO
    logic  [0:0] reserved0;  // RSVD
    logic  [0:0] cxl_reset_mem_clr_capable;  // RO
    logic  [2:0] cxl_reset_timeout;  // RO
    logic  [0:0] cxl_reset_capable;  // RO
    logic  [0:0] cache_wb_and_inv_capable;  // RO
    logic  [1:0] hdm_count;  // RO
    logic  [0:0] mem_hwInit_mode;  // RO
    logic  [0:0] mem_capable;  // RO
    logic  [0:0] io_capable;  // RO
    logic  [0:0] cache_capable;  // RO
    logic [15:0] dvsec_id;  // RO
} bbs_copy_cafu_DVSEC_FBCAP_HDR2_t;

// copied from cafu csr0 cfg pkg
typedef struct packed {
    logic  [0:0] reserved0;  // RSVD
    logic  [0:0] viral_status;  // RW/1C/V/P
    logic [14:0] reserved1;  // RSVD
    logic  [0:0] viral_enable;  // RW/L
    logic  [1:0] reserved2;  // RSVD
    logic  [0:0] cache_clean_eviction;  // RW/L
    logic  [2:0] cache_sf_granularity;  // RW/L
    logic  [4:0] cache_sf_coverage;  // RW/L
    logic  [0:0] mem_enable;  // RW/L
    logic  [0:0] io_enable;  // RO
    logic  [0:0] cache_enable;  // RW/L
} bbs_copy_cafu_DVSEC_FBCTRL_STATUS_t;

typedef struct packed {
    bbs_copy_cafu_DVSEC_FBCAP_HDR2_t       dvsec_fbcap_hdr2;       // 32 bits wide
    bbs_copy_cafu_DVSEC_FBCTRL2_STATUS2_t  dvsec_fbctrl2_status2;  // 32 bits wide
    bbs_copy_cafu_DVSEC_FBCTRL_STATUS_t    dvsec_fbctrl_status;    // 32 bits wide
} cafu2ip_csr0_cfg_if_t;

// Module connect script has issue with "= $bits(cafu2ip_csr0_cfg_if_t)"
localparam CAFU2IP_CSR0_CFG_IF_WIDTH = 96;
localparam IP2CAFU_CSR0_CFG_IF_WIDTH = 7;
localparam TMP_NEW_DVSEC_FBCTRL2_STATUS2_T_BW = $bits( bbs_copy_cafu_DVSEC_FBCTRL2_STATUS2_t );

typedef struct packed {
   logic [51:6]    DevAddr;
   logic [32:0]    SBECnt;
   logic [32:0]    DBECnt;
   logic [32:0]    PoisonRtnCnt;
   logic           NewSBE;
   logic           NewDBE;
   logic           NewPoisonRtn;
   logic           NewPartialWr;
} mc_err_cnt_t;


//-------------------------
//----- CXL Device Type
//      Used by DOE CDAT FSM
typedef enum logic [1:0] {
    INV_TYPE_DEV        = 2'b00,        // (mem_capable, cache_capable)
    TYPE_1_DEV          = 2'b01,
    TYPE_3_DEV          = 2'b10,
    TYPE_2_DEV          = 2'b11
} CxlDeviceType_e;

//-------------------------
//----- DOE CDAT POR values.
//      Type 1 POR Values
//      Included structures DSMAS, DSLBIS and DSIS
localparam  TYPE1_CDAT_0 = 32'h00000030;        // CDAT Length
localparam  TYPE1_CDAT_1 = 32'h0000AA01;        // CDAT Checksum and Rev.

//      Type 3 POR Values
//      Included structures DSMAS, DSLBIS and DSEMTS
localparam  TYPE3_CDAT_0 = 32'h00000058;        // CDAT Length
localparam  TYPE3_CDAT_1 = 32'h00005501;        // CDAT Checksum and Rev.


endpackage: ext_csr_if_pkg
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "n2XcJZ07Jm43bx1M8XpHia2ruIzazHuijI1yijoflqOn7I/5ECRpX3AD2MuWI5gSNjn593jzAp73l+NpO4Wrk5ssiF/2ttaG2OQ7u8j8+jpYQumLH/ciLj4KnC8p5auDB0Zgl8gK99Xa+X0ZewtdgT1TEeLXUOnfCjsVxW1xka9RcOZ7tdPYJf89VeOZZmQQFcqSxR9TmZYgKGUEf0/uWMNAbhWF/sjWgA+Staf8Xvy58nCJtuj0qRiwSTYFSAADDw89OLaZL2hAMKyvDUOU7A/EwVcKX9oXtblzv65x/Sl4leqhs/j546hDCFTJdE1fQ4fI8mTP/sKn4X11+uS3vZUhMX1E5S6/M2bbYznsmuxyYlSGp6v/QS48Wg1Av9yt0WS2bq7UZBj5RhbFjcNoYDtUYNjWbn1NS4yyyJe/zCfIfntMxtqK+cZtZTJvpv5betEJHfAP/pb29F8gtzBO+KjWcy2bJwNIY6JWxLEx1/qejkvB2XY9HD5kSxWadm2bt+0m5EsYNMdeFnLeUgS0plTNVVloUFoper6o9qUzZsr63NspGg7jHcKjOQFZ2Hs9lYdFtBOGi1NgDhBfqBR3vV9ys8c8jvdGuFl+Z9NAsni/GDfjLCEbJgwubi0IgApMi8lESd1WfWxsLp7dEIV44ENHvfNaQzXSu/fCrsdribeFJ9j1XNLA07Vg2e7gZzJ6h+Xn5YmXEINGTQMAqmiHUYBE2+1eGRUilubmNaluAcrW3p8MJ/6XUop3UnuzippuMSvU/1XYxpGKpfQR4bIMEdBsoxZNrvhVxclY1WewQ1FePyto7f2Qv9daBuaYvgw438jMGj02IWYEhIjmqB0uk4qwqc9HMhs9SBPMiKaav+b6XknTv8InsiF7EZnll+0atXXKczcA4csefxIxpVyKuJv5oKbe4+Yq9wAh03pmF8biYfflo7XpMCKLZ1vVBNPpGD50wHmH3Fq14uifoD8wmwHSjwAnditVhFByQ3wJjTToUj8zplJzYgbVOrq/d6in"
`endif
