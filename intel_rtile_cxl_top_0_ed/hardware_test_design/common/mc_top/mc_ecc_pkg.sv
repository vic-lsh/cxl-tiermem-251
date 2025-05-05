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
// Creation Date : Feb, 2023
// Description   : SBCNT/DBCNT 

package mc_ecc_pkg;

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
// @@copy for common_afu_pkg@@end

//-------------------------
//------ Dev Mem Interfaces
//-------------------------

 typedef struct packed {
    logic [7:0]                      SBE;
    logic [7:0]                      DBE;
    logic                            Valid;
 } mc_rddata_ecc_t;

  typedef enum logic [1:0] {
    M2S_METAVALUE_INVALID       = 2'b00,
    M2S_METAVALUE_RSVD1         = 2'b01,
    M2S_METAVALUE_ANY           = 2'b10,
    M2S_METAVALUE_SHARED        = 2'b11
  } M2S_MetaValue_e;

  typedef enum logic [1:0] {
    M2S_METAFIELD_META0         = 2'b00,
    M2S_METAFIELD_RSVD1         = 2'b01,
    M2S_METAFIELD_RSVD2         = 2'b10,
    M2S_METAFIELD_NOOP          = 2'b11
  } M2S_MetaField_e;

// @@copy for common_afu_pkg@@start 
localparam  CL_ADDR_MSB = 51;
localparam  CL_ADDR_LSB = 6;
typedef logic [CL_ADDR_MSB:CL_ADDR_LSB]        Cl_Addr_t;
// @@copy for common_afu_pkg@@end 

typedef struct packed {
    logic [255:0]   Data1;
    logic [255:0]   Data0;
} DataCL_t;

typedef struct packed {
        DataCL_t                     Data;
        logic [3:0]                  EventTriggerB;
        M2S_MetaValue_e              MetaValue;
        M2S_MetaField_e              MetaField;
        logic                        Poison;
} dev_mem_rd_data_t;


 typedef struct packed {
    mc_rddata_ecc_t                  RdDataECC;
    logic                            RdDataValid;
 } mc_devmem_if_t;

// @@copy for common_afu_pkg@@start 
 typedef struct packed {
    Cl_Addr_t                        DevAddr;            //46
    logic [32:0]                     SBECnt;             //33
    logic [32:0]                     DBECnt;             //33
    logic [32:0]                     PoisonRtnCnt;       //33
    logic                            NewSBE;          
    logic                            NewDBE;
    logic                            NewPoisonRtn;
    logic                            NewPartialWr;
 } mc_err_cnt_t;

localparam MC_ERR_CNT_WIDTH = $bits( mc_err_cnt_t ); //149;
// @@copy for common_afu_pkg@@end 

endpackage : mc_ecc_pkg
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5Jq3Zkmg6eChA1+SHeXOJ+kLYtWemmdT5Ew5dhIlDcW3njDYdiPzDq2qkAISIqYzB0b/RgChL+LwIvlaV0sWDeV1s0YPwoTeqrzyHIibGhitf3rg+SI76AQSnP7CGUvpIA/r0lW5SwY8DwnULlaizlsJxXoZ9klnb979pyolThWXWoekZZ9wYx7dnzLWaojNRzNVp1lw+s9PQVArey7rsbgB7/lhOKD4+e+za0fU3F7xRQeohpcdNnBp0r22fl+YEmNZAHq9/qgs6Z3W7gzp7nQSyQd10rlBoI35nw1tzYlzvELyuzTt7do5bpeHZJ+qZdKqFz+GeHsPI3/a7xsyqKfIJUOcZl1y75vt6+6gt3Xg0JRub/9kjs6OOqiOIiZuZBmUxaPgyZBwqbM7W4W6/RiateVWa7t1KkjMD9CZNfRyRr0rKfQ40SXQyRzgHRck7R+cWtGXegaWv8D6ztGPyFx13smkREGjRGPTTRCzhPuugx0LwfXNXDyuyStpERGfJt13aE8sntjOq3WSTPjeQa1dTb+8lQ3A/K5snkNnECmJB4Qfd8kwDXaU5UxRUD8EZC/ZGuuPLL14bqNrrQX0/YjjWyZBAa1PgiPDGuSqbeCDrPoNppDJRx4himRkce8xqHto0lKIBWEW1D7AjMzf1LruV4De3JkoGjlsz7u4a9Bk1m2SJOXc+I5mArk/B/3DLn1toogpkFRPGDZtn1kpl6pO1+5L5kNvOgQdAkfZFy5GanKgLIeqFsvErqytMbTOpSom5QnKvypjXl58lgI0BTj"
`endif