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
//
// THIS IS AN AUTO-GENERATED FILE!!!!!
//
// INTEL PSG INTERNAL USE : DO NOT EDIT THIS AUTO-GENERATED, VERSION CONTROLLED FILE
// Please goto <MODEL_ROOT/scripts and run 'python gen_example_design_common_pkg.py'
//   to run the script that updates this version controlled file
// Please check in updated file.
//
// CUSTOMER USE : This make structs and parameters previously hidden behind encryption
//   under the CXLIP boundary visible. Instructions and warnings on editing these structs
//   and parameters will be provided in-line where considered necessary.
//

package cafu_common_pkg;

    import tmp_cafu_csr0_cfg_pkg::*;



// This define configures the design for the design validation environment of a single bbs slice.
// This mode is not intended for customer use and may result in unexpected behaviour if set.
//`define INTEL_ONLY_CXLIPDEV  1




// parameters and structs required for access to the cafu csr0 configuration and debug register space

// @@copy for common_afu_pkg@@start
typedef enum logic [3:0] {
    MRD   = 4'h0,
    MWR   = 4'h1,
    IORD  = 4'h2,
    IOWR  = 4'h3,
    CFGRD = 4'h4,
    CFGWR = 4'h5,
    CRRD  = 4'h6,
    CRWR  = 4'h7
} cafu_cfg_opcode_t;

localparam CAFU_CR_REQ_ADDR_LEN = 48;
localparam CAFU_CR_REQ_ADDR_HI = 47;

localparam CAFU_CR_MEM_ADDR_HI = 47;
typedef struct packed { // 48
    logic [CAFU_CR_MEM_ADDR_HI:0] offset;
} cafu_cfg_addr_mem_t;

localparam CAFU_CR_IO_ADDR_HI = 15;
typedef struct packed { // 32+16=48
    logic [31:0] pad;
    logic [CAFU_CR_IO_ADDR_HI:0] offset;
} cafu_cfg_addr_io_t;

localparam CAFU_CR_CFG_ADDR_HI = 11;
typedef struct packed { // 36+12=48
    logic [35:0] pad;
    logic [CAFU_CR_CFG_ADDR_HI:0] offset;
} cafu_cfg_addr_cafu_cfg_t;

localparam CAFU_CR_MSG_ADDR_HI = 15;
typedef struct packed { // 32+16=48
    logic [31:0] pad;
    logic [CAFU_CR_MSG_ADDR_HI:0] offset;
} cafu_cfg_addr_msg_t;

localparam CAFU_CR_CR_ADDR_HI = 15;
typedef struct packed { // 32+16=48
    logic [31:0] pad;
    logic [CAFU_CR_CR_ADDR_HI:0] offset;
} cafu_cfg_addr_cr_t;

typedef union packed { // All structs must be 48
    cafu_cfg_addr_mem_t mem;
    cafu_cfg_addr_io_t  io;
    cafu_cfg_addr_cafu_cfg_t cfg;
    cafu_cfg_addr_msg_t  msg;
    cafu_cfg_addr_cr_t  cr;
} cafu_cfg_addr_t;

typedef struct packed { 
    logic        valid;
    cafu_cfg_opcode_t opcode;
    cafu_cfg_addr_t   addr;
    logic  [7:0] be;
    logic [63:0] data;
    logic [7:0] sai;
    logic  [7:0] fid;
    logic [2:0] bar;
} cafu_cfg_req_64bit_t;

typedef struct packed {
    logic        read_valid;
    logic        read_miss;
    logic        write_valid;
    logic        write_miss;
    logic        sai_successfull;
    logic [63:0] data;
} cafu_cfg_ack_64bit_t;


// parameters and structs copied from the CXLIP top package

// @@copy for common_mctop_pkg@@start
// number of memory controller channels
`ifdef INTEL_ONLY_CXLIPDEV
  localparam CAFU_MC_CHANNEL                  = 1;
`else 
  `ifdef ENABLE_1_SLICE   // 1 slice
    localparam CAFU_MC_CHANNEL                = 1;
  `elsif ENABLE_4_SLICE   // 4 slice
    localparam CAFU_MC_CHANNEL                = 4;
  `else                   // 2 slice  
    localparam CAFU_MC_CHANNEL                = 2;
  `endif
`endif
localparam CAFU_MC_HA_DDR4_ADDR_WIDTH     = 17;
localparam CAFU_MC_HA_DDR4_BA_WIDTH       = 2;
localparam CAFU_MC_HA_DDR4_BG_WIDTH       = 2;
localparam CAFU_MC_HA_DDR4_CK_WIDTH       = 1;
localparam CAFU_MC_HA_DDR4_CKE_WIDTH      = 1;
localparam CAFU_MC_HA_DDR4_CS_WIDTH       = 1;
localparam CAFU_MC_HA_DDR4_ODT_WIDTH      = 1;
localparam CAFU_MC_HA_DDR4_DQS_WIDTH      = 9;
localparam CAFU_MC_HA_DDR4_DQ_WIDTH       = 72;
localparam CAFU_MC_HA_DDR4_DBI_WIDTH      = 9;

localparam MEMCNTRL_ADDR_WIDTH = 46;

localparam CAFU_EMIF_AMM_ADDR_WIDTH      = 27;
localparam CAFU_EMIF_AMM_DATA_WIDTH      = 576;
localparam CAFU_EMIF_AMM_BURST_WIDTH     = 7;
localparam CAFU_EMIF_AMM_BE_WIDTH        = 72;

localparam EMIF_AXI_ADDR_WIDTH = 46;
localparam EMIF_AXI_DATA_WIDTH = 512;
localparam EMIF_AXI_STRB_WIDTH = 64;
localparam EMIF_AXI_ECC_WIDTH  = 64;  // should go to wuser

localparam CAFU_REG_ON_REQFIFO_INPUT_EN  = 0;
localparam CAFU_REG_ON_REQFIFO_OUTPUT_EN = 1;
localparam CAFU_REG_ON_RSPFIFO_OUTPUT_EN = 0;

localparam CAFU_MC_HA_DP_ADDR_WIDTH       = 46;  // 46 supports full cxl addr width [51:6]
localparam CAFU_MC_HA_DP_DATA_WIDTH       = 512;
localparam CAFU_MC_ECC_EN                 = 1;
localparam CAFU_MC_ECC_ENC_LATENCY        = 1;
localparam CAFU_MC_ECC_DEC_LATENCY        = 1;
localparam CAFU_MC_RAM_INIT_W_ZERO_EN     = 1;
localparam CAFU_MEMSIZE_WIDTH             = 64;

// These mc_top parameters are defined in mc_top as localparam.  Therefore, these localparam values
// can not be used as mc_top parameter inputs.  They are copied here to ensure the related signal
// widths are in sync with mc_top.
localparam CAFU_MC_MDATA_WIDTH            = 14;
localparam CAFU_MC_SR_STAT_WIDTH          = 5;
localparam CAFU_MC_HA_DP_BITS_PER_SYMBOL  = 8;
localparam CAFU_MC_HA_DP_BE_WIDTH = CAFU_MC_HA_DP_DATA_WIDTH / CAFU_MC_HA_DP_BITS_PER_SYMBOL;
localparam CAFU_REQFIFO_DEPTH_WIDTH       = 6;
localparam CAFU_RSPFIFO_DEPTH_WIDTH       = 6;

     // ==== CAFU_ALTECC ====
localparam CAFU_ALTECC_DATAWORD_WIDTH = 64;
localparam CAFU_ALTECC_WIDTH_CODEWORD = 72;
localparam CAFU_ALTECC_INST_NUMBER    = CAFU_MC_HA_DP_DATA_WIDTH / CAFU_ALTECC_DATAWORD_WIDTH;

// Specify lsb/msb for cxl-ip output cxlip2iafu_address_eclk.
// Set to full cxl addr width (addr[51:6]).
localparam CAFU_CXLIP_FULL_ADDR_LSB = 6;
localparam CAFU_CXLIP_FULL_ADDR_MSB = 51;

// The cxl-ip provides all cxl address bits for each memory request (addr[51:6]).
// The address bits to connect to a memory channel depends on the total amount
// of memory and the number of cxl-ip HDM request ports.
//
// If the cxl-ip is configured for one HDM request port, addr[n:6] is meaningful.
// (n is determined by the memory size).  If there is one memory channel, addr[n:6]
// from the HDM port should connect to the memory channel.  Note that addr[51:n+1]
// does not have to connect to the memory channel.
//
// If configured for two HDM request ports, addr[n:7] is meaningful and addr[6]
// is the interleave bit (one HDM port always has addr[6]=0 and the other
// HDM port always has addr[6]=1).  If there are two memory channels, addr[n:7]
// from each HDM port should connect to the corresponding memory channel.
//
// If configured for four HDM request ports, addr[n:8] is meaningful and addr[7:6]
// are the interleave bits (one HDM port always has addr[7:6]=00, one always
// has addr[7:6]=01, etc.).  If there are four memory channels, addr[n:8]
// from each HDM port should connect to the corresponding memory channel.
//
// The following table shows an example with 8GB of memory.
// In this case, 27 address bits are needed (2^27 * 64B = 8GB).
//
// @@copy for common_mctop_pkg@@start
// Mem Size  Addr Bits  Mem Chan  Mem/Ch  Ch Addr Bits
// --------  ---------  --------  ------  ------------
//   8GB      [32:6]       1       8GB       [32:6]
//                         2       4GB       [32:7]
//                         4       2GB       [32:8]
localparam CAFU_CXLIP_CHAN_ADDR_LSB = ( CAFU_MC_CHANNEL == 4 ) ? 8 : (( CAFU_MC_CHANNEL == 2 ) ? 7 : 6);
localparam CAFU_CXLIP_CHAN_ADDR_MSB = CAFU_CXLIP_FULL_ADDR_LSB + (MEMCNTRL_ADDR_WIDTH-1); //(CAFU_EMIF_AMM_ADDR_WIDTH - 1);


// parameters and structs copied for memory controller ECC logging

// @@copy for common_afu_pkg@@start
typedef struct packed {
    logic [15:0] mc1_status;  // RO/V
    logic [15:0] mc0_status;  // RO/V
} DDRMC_MC_STATUS_t;

typedef struct packed {
    logic  [2:0] reset_needed;  // RO/V
    logic  [0:0] mailbox_if_ready;  // RO/V
    logic  [1:0] media_status;  // RO/V
    logic  [0:0] fw_halt;  // RO/V
    logic  [0:0] device_fatal;  // RO/V
} DDRMC_new_CXL_MEM_DEV_STATUS_t;

localparam MC_STATUS_T_BW      = $bits( DDRMC_MC_STATUS_t );
localparam MEM_DEV_STATUS_T_BW = $bits( DDRMC_new_CXL_MEM_DEV_STATUS_t );

// @@copy for common_afu_pkg@@start 
localparam  CAFU_CL_ADDR_MSB = 51;
localparam  CAFU_CL_ADDR_LSB = 6;
typedef logic [CAFU_CL_ADDR_MSB:CAFU_CL_ADDR_LSB]        cafu_Cl_Addr_t;

// @@copy for common_afu_pkg@@start 
 typedef struct packed {
    cafu_Cl_Addr_t                        DevAddr;            //46
    logic [32:0]                     SBECnt;             //33
    logic [32:0]                     DBECnt;             //33
    logic [32:0]                     PoisonRtnCnt;       //33
    logic                            NewSBE;          
    logic                            NewDBE;
    logic                            NewPoisonRtn;
    logic                            NewPartialWr;
 } cafu_mc_err_cnt_t;

localparam CAFU_MC_ERR_CNT_WIDTH = $bits( cafu_mc_err_cnt_t ); //149;


// parameters and structs copied from CXLIP to debug config register space


typedef struct packed {
   tmp_cafu_csr0_cfg_pkg::tmp_DVSEC_FBCAP_HDR2_t       dvsec_fbcap_hdr2;       // 32 bits wide
   tmp_cafu_csr0_cfg_pkg::tmp_DVSEC_FBCTRL2_STATUS2_t  dvsec_fbctrl2_status2;  // 32 bits wide
   tmp_cafu_csr0_cfg_pkg::tmp_DVSEC_FBCTRL_STATUS_t    dvsec_fbctrl_status;    // 32 bits wide
} cafu_csr0_cafu2ip_csr0_cfg_if_t;


localparam CAFU_TMP_NEW_DVSEC_FBCTRL2_STATUS2_T_BW = $bits( tmp_cafu_csr0_cfg_pkg::tmp_DVSEC_FBCTRL2_STATUS2_t );


// @@copy for common_afu_pkg@@start
localparam CAFU_CAFU2IP_CSR0_CFG_IF_WIDTH = 96;

// @@copy for common_afu_pkg@@start
typedef struct packed {
   logic [51:6]    DevAddr;
   logic [32:0]    SBECnt;
   logic [32:0]    DBECnt;
   logic [32:0]    PoisonRtnCnt;
   logic           NewSBE;
   logic           NewDBE;
   logic           NewPoisonRtn;
   logic           NewPartialWr;
} cafu_csr0_mc_err_cnt_t;

// @@copy for common_afu_pkg@@start
typedef enum logic [1:0] {
    CAFU_INV_TYPE_DEV        = 2'b00,        // (mem_capable, cache_capable)
    CAFU_TYPE_1_DEV          = 2'b01,
    CAFU_TYPE_3_DEV          = 2'b10,
    CAFU_TYPE_2_DEV          = 2'b11
} cafu_csr0_CxlDeviceType_e;

// @@copy for common_afu_pkg@@start
localparam CAFU_TYPE1_CDAT_0 = 32'h00000030;        // CDAT Length
localparam CAFU_TYPE1_CDAT_1 = 32'h0000AA01;        // CDAT Checksum and Rev.

// @@copy for common_afu_pkg@@start
localparam CAFU_TYPE3_CDAT_0 = 32'h00000058;        // CDAT Length
localparam CAFU_TYPE3_CDAT_1 = 32'h00002801;        // CDAT Checksum and Rev.


// parameters and structs copied from CXLIP for the CXLIP-to-CAFU AXI interface

// @@copy for common_afu_pkg@@start    
    localparam CAFU_AFU_AXI_BURST_WIDTH            = 2;
    localparam CAFU_AFU_AXI_CACHE_WIDTH            = 4;
    localparam CAFU_AFU_AXI_LOCK_WIDTH             = 2;
    localparam CAFU_AFU_AXI_MAX_ADDR_USER_WIDTH    = 5;
    localparam CAFU_AFU_AXI_MAX_ADDR_WIDTH         = 64;
    localparam CAFU_AFU_AXI_MAX_BRESP_USER_WIDTH   = 4;
    localparam CAFU_AFU_AXI_MAX_BURST_LENGTH_WIDTH = 10;
    localparam CAFU_AFU_AXI_MAX_DATA_USER_WIDTH    = 4;
    localparam CAFU_AFU_AXI_MAX_DATA_WIDTH         = 512;
    localparam CAFU_AFU_AXI_MAX_ID_WIDTH           = 12;
    localparam CAFU_AFU_AXI_PROT_WIDTH             = 3;
    localparam CAFU_AFU_AXI_QOS_WIDTH              = 4;
    localparam CAFU_AFU_AXI_REGION_WIDTH           = 4;
    localparam CAFU_AFU_AXI_RESP_WIDTH             = 2;
    localparam CAFU_AFU_AXI_SIZE_WIDTH             = 3;
    localparam CAFU_AFU_AXI_BUSER_WIDTH            = 4;
    localparam CAFU_AFU_AXI_AWATOP_WIDTH           = 6;

// @@copy for common_afu_pkg@@start
//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 73, A4.7, Access Permissions
//  Table A4-6 Protection Encoding    
//------------------------------------------------------------------------   
    typedef enum logic [CAFU_AFU_AXI_PROT_WIDTH-1:0] {
        eprot_CAFU_UNPRIV_SECURE_DATA        = 3'b000,
        eprot_CAFU_UNPRIV_SECURE_INST        = 3'b001,
        eprot_CAFU_UNPRIV_NONSEC_DATA        = 3'b010,
        eprot_CAFU_UNPRIV_NONSEC_INST        = 3'b011,
        eprot_CAFU_PRIV_SECURE_DATA          = 3'b100,
        eprot_CAFU_PRIV_SECURE_INST          = 3'b101,
        eprot_CAFU_PRIV_NONSEC_DATA          = 3'b110,
        eprot_CAFU_PRIV_NONSEC_INST          = 3'b111
    } t_cafu_axi4_prot_encoding;
    
//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 48, A3.4.1, Access Permissions
//  Table A3-3 Burst type encoding    
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_BURST_WIDTH-1:0] {
        eburst_CAFU_FIXED     = 2'b00,
        eburst_CAFU_INCR      = 2'b01,
        eburst_CAFU_WRAP      = 2'b10,
        eburst_CAFU_RSVD      = 2'b11
    } t_cafu_axi4_burst_encoding;

//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 47, A3.4.1, Access Permissions
//  Table A3-2 Burst size encoding    
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_SIZE_WIDTH-1:0] {
        esize_CAFU_128          = 3'b100,
        esize_CAFU_256          = 3'b101,
        esize_CAFU_512          = 3'b110,
        esize_CAFU_1024         = 3'b111
    } t_cafu_axi4_burst_size_encoding;

//------------------------------------------------------------------------ 
//  AXI AFU HAS, page 32
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_QOS_WIDTH-1:0] {
        eqos_CAFU_BEST_EFFORT           = 4'h0,
        eqos_CAFU_USER_LOW              = 4'h4,
        eqos_CAFU_USER_HIGH             = 4'h8,
        eqos_CAFU_LOW_LATENCY           = 4'hC
    } t_cafu_axi4_qos_encoding;

//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 67
//  Table A4-5 MEMORY TYPE ENCODING
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_CACHE_WIDTH-1:0] {
        ecache_ar_CAFU_DEVICE_NON_BUFFERABLE                 = 4'b0000,
        ecache_ar_CAFU_DEVICE_BUFFERABLE                     = 4'b0001,
        ecache_ar_CAFU_NORMAL_NON_CACHEABLE_NON_BUFFERABLE   = 4'b0010,
        ecache_ar_CAFU_NORMAL_NON_CACHEABLE_BUFFERABLE       = 4'b0011,
        ecache_ar_CAFU_WRITE_THROUGH_NO_ALLOCATE             = 4'b1010,
        ecache_ar_CAFU_WRITE_BACK_NO_ALLOCATE                = 4'b1011,
        ecache_ar_CAFU_WRITE_THROUGH_READ_ALLOCATE           = 4'b1110,
        ecache_ar_CAFU_WRITE_BACK_READ_ALLOCATE              = 4'b1111
    } t_cafu_axi4_arcache_encoding;
    
//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 67
//  Table A4-5 MEMORY TYPE ENCODING
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_CACHE_WIDTH-1:0] {
        ecache_aw_CAFU_DEVICE_NON_BUFFERABLE                 = 4'b0000,
        ecache_aw_CAFU_DEVICE_BUFFERABLE                     = 4'b0001,
        ecache_aw_CAFU_NORMAL_NON_CACHEABLE_NON_BUFFERABLE   = 4'b0010,
        ecache_aw_CAFU_NORMAL_NON_CACHEABLE_BUFFERABLE       = 4'b0011,
        ecache_aw_CAFU_WRITE_THROUGH_NO_ALLOCATE             = 4'b0110,
        ecache_aw_CAFU_WRITE_BACK_NO_ALLOCATE                = 4'b0111,
        ecache_aw_CAFU_WRITE_THROUGH_WRITE_ALLOCATE          = 4'b1110,
        ecache_aw_CAFU_WRITE_BACK_WRITE_ALLOCATE             = 4'b1111
    } t_cafu_axi4_awcache_encoding;

//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 100, A7.4
//  Table A7-1 AXI3 atomic access encoding    
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_LOCK_WIDTH-1:0] {
        elock_CAFU_NORMAL            = 2'b00,
        elock_CAFU_EXECLUSIVE        = 2'b01,
        elock_CAFU_LOCKED            = 2'b10,
        elock_CAFU_RSVD              = 2'b11
    } t_cafu_axi4_lock_encoding;

//------------------------------------------------------------------------ 
//  AMBA AXI and ACE Protocol Specitifcation, Issue 4, 2013
//  page 57, A3.4.4
//  Table A3-4 RRESP and BRESP encoding   
//------------------------------------------------------------------------ 
    typedef enum logic [CAFU_AFU_AXI_RESP_WIDTH-1:0] {
        eresp_CAFU_OKAY              = 2'b00,
        eresp_CAFU_EXOKAY            = 2'b01,
        eresp_CAFU_SLVERR            = 2'b10,
        eresp_CAFU_DECERR            = 2'b11
    } t_cafu_axi4_resp_encoding;

    //------------------------------------------------------------------------
    //  write operation select
    //------------------------------------------------------------------------
    typedef enum logic [3:0] {
       eWR_CAFU_I_WO              = 4'h0,  
       eWR_CAFU_M                 = 4'h1,  
       eWR_CAFU_I_SO              = 4'h2,  
       eWR_CAFU_BARRIER           = 4'h3,
       eWR_CAFU_EVICT             = 4'h4,
       eWR_CAFU_FLUSHHOSTCACHE    = 4'h5,
       eWR_CAFU_FLUSHDEVCACHE     = 4'h6,
       eWR_CAFU_ILLEGAL_WREQ      = 4'hf   // can be used to test slverr
    } t_cafu_axi4_awuser_opcode;

    typedef struct packed {
      logic                  target_hdm;
      logic                  do_not_send_d2hreq;
      t_cafu_axi4_awuser_opcode   opcode;
    } t_cafu_axi4_awuser;

    localparam CAFU_AFU_AXI_AWUSER_WIDTH = $bits(t_cafu_axi4_awuser);

//------------------------------------------------------------------------
// Opcode mapping on WUSER
//------------------------------------------------------------------------
    typedef struct packed {
      logic        poison;
    } t_cafu_axi4_wuser;

    localparam CAFU_AFU_AXI_WUSER_WIDTH = $bits(t_cafu_axi4_wuser);

    //------------------------------------------------------------------------
    //  read operation select
    //------------------------------------------------------------------------
    typedef enum logic [3:0] {
       eRD_CAFU_I            = 4'h0,  
       eRD_CAFU_S            = 4'h1,  
       eRD_CAFU_EM           = 4'h2,  
       eRD_CAFU_ILLEGAL_RREQ = 4'hf   // can be used to test slverr
    } t_cafu_axi4_aruser_opcode;

    typedef struct packed {
      logic                  target_hdm;
      logic                  do_not_send_d2hreq;
      t_cafu_axi4_aruser_opcode   opcode;
    } t_cafu_axi4_aruser;

    localparam CAFU_AFU_AXI_ARUSER_WIDTH = $bits(t_cafu_axi4_aruser);

//------------------------------------------------------------------------
// Opcode mapping on RUSER
//------------------------------------------------------------------------
    typedef struct packed {
      logic        poison;
    } t_cafu_axi4_ruser;

    localparam CAFU_AFU_AXI_RUSER_WIDTH = $bits(t_cafu_axi4_ruser);


//------------------------------------------------------------------------
// AXI input & output buses.
// AXI3 + AXI4, no ACE IO
//------------------------------------------------------------------------
    typedef logic t_cafu_axi4_wr_addr_ready;
    
    typedef struct packed {
        logic [CAFU_AFU_AXI_MAX_ID_WIDTH-1:0]            awid;
        logic [CAFU_AFU_AXI_MAX_ADDR_WIDTH-1:0]          awaddr; 
        logic [CAFU_AFU_AXI_MAX_BURST_LENGTH_WIDTH-1:0]  awlen;
        t_cafu_axi4_burst_size_encoding                  awsize;
        t_cafu_axi4_burst_encoding                       awburst;
        t_cafu_axi4_prot_encoding                        awprot;
        t_cafu_axi4_qos_encoding                         awqos;
        logic                                       awvalid;
        t_cafu_axi4_awcache_encoding                     awcache;
        t_cafu_axi4_lock_encoding                        awlock;
        logic [CAFU_AFU_AXI_REGION_WIDTH-1:0]            awregion;
        t_cafu_axi4_awuser                               awuser;
    } t_cafu_axi4_wr_addr_ch;

    typedef logic t_cafu_axi4_wr_data_ready;
    
    typedef struct packed {
        logic [CAFU_AFU_AXI_MAX_DATA_WIDTH-1:0]     wdata;
        logic [(CAFU_AFU_AXI_MAX_DATA_WIDTH/8)-1:0] wstrb;
        logic                                  wlast;
        logic                                  wvalid;
        t_cafu_axi4_wuser                           wuser;
    } t_cafu_axi4_wr_data_ch;

    typedef logic t_cafu_axi4_wr_resp_ready;
    
    typedef struct packed {
        logic [CAFU_AFU_AXI_MAX_ID_WIDTH-1:0] bid;
        t_cafu_axi4_resp_encoding             bresp;
        logic                            bvalid;
        logic [CAFU_AFU_AXI_BUSER_WIDTH-1:0]  buser;
    } t_cafu_axi4_wr_resp_ch;

    typedef logic t_cafu_axi4_rd_addr_ready;
    
    typedef struct packed {
        logic [CAFU_AFU_AXI_MAX_ID_WIDTH-1:0]            arid;
        logic [CAFU_AFU_AXI_MAX_ADDR_WIDTH-1:0]          araddr;
        logic [CAFU_AFU_AXI_MAX_BURST_LENGTH_WIDTH-1:0]  arlen;
        t_cafu_axi4_burst_size_encoding                  arsize;
        t_cafu_axi4_burst_encoding                       arburst;
        t_cafu_axi4_prot_encoding                        arprot;
        t_cafu_axi4_qos_encoding                         arqos;
        logic                                       arvalid;
        t_cafu_axi4_arcache_encoding                     arcache;
        t_cafu_axi4_lock_encoding                        arlock;
        logic [CAFU_AFU_AXI_REGION_WIDTH-1:0]            arregion;
        t_cafu_axi4_aruser                               aruser;
    } t_cafu_axi4_rd_addr_ch;

    typedef logic t_cafu_axi4_rd_resp_ready;
    
    typedef struct packed {
        logic [CAFU_AFU_AXI_MAX_ID_WIDTH-1:0]        rid;
        logic [CAFU_AFU_AXI_MAX_DATA_WIDTH-1:0]      rdata;
        t_cafu_axi4_resp_encoding                    rresp;
        logic                                   rlast;
        logic                                   rvalid;
        t_cafu_axi4_ruser                            ruser;
    } t_cafu_axi4_rd_resp_ch;
    
    localparam CAFU_AFU_AXI_WR_ADDR_CH_WIDTH = $bits(t_cafu_axi4_wr_addr_ch);
    localparam CAFU_AFU_AXI_WR_DATA_CH_WIDTH = $bits(t_cafu_axi4_wr_data_ch);
    localparam CAFU_AFU_AXI_WR_RESP_CH_WIDTH = $bits(t_cafu_axi4_wr_resp_ch);
    localparam CAFU_AFU_AXI_RD_ADDR_CH_WIDTH = $bits(t_cafu_axi4_rd_addr_ch);
    localparam CAFU_AFU_AXI_RD_RESP_CH_WIDTH = $bits(t_cafu_axi4_rd_resp_ch);

endpackage : cafu_common_pkg
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4MkyBU+Z9lbf2r+adRxg9cRApgoPsS3RLb73l51wyAY0L5C8mFqz6pZwnbiOJpIyi/QuJnU3y9bN03z1Iopb1WUwEWMynlSH6sT5cyZimyXpddUuGMnx8r2bFCsCMfXK4UvwNuoVcRnNP8zvvcpT7kfjoYDNY5hwJMzjKo5HSBSmwheejqm2TeMM3bW+Do19Htcr61NP029HET8pbcEgW0dBZevsx7XZ+c9Uxt+S2wzPNElqmJOicZ2HrrRPX9nws38F7uwU8t1UpPc8pf7Q5tcQP2MEARY4IrhK6t4iEtAlka+CNlutFApwmgS05v2ZDxtgnoT6qiK2LA24YENG+GAkM05FgqIhR1pFu95gZRr+KNHfNFKd7toWOb8VjoB3d1jctv/Kn8hEuieAV517W3Me+1Oztaic1HnA/Hz5HQBnZ1E+pWof0PpEUPtavBWQmwsIYkGnMccQGi7H4nEwgsY6UofQ2oyPyUMllIdPsgikCoDse7o++WQca0u1xjis0xVeQGGxICNtPDBFzezAo9jZvISvrmYGULE6Oz2917z4UJXz2GHL+LMT/BTLgPfTdnH566fbeFXdfuK8F9NqsCHVsDa+myBMExCMtIJ28SD85DR60h2GFn9zO8ExUzivBoJgqjtceYRtd6h/fYJ411BtiW2DFPLuMMh7iLpOs87BxfZyYmj1GLyvnaEQZEulDbqtcG7gehGyV6NHnLIy/d6V2EZ5HsOLkC9wBE1rmhOJ8Ml/jsgGOy60WvUiCMpHzq77AwxGwrlKL335Jy0ZDSr"
`endif
