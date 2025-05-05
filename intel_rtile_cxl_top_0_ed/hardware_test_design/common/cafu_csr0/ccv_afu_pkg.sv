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
/*
  Description   : FPGA CXL Compliance Engine Initiator AFU
                  Speaks to the AXI-to-CCIP+ translator.
                  This afu is the initiatior
                  The axi-to-ccip+ is the responder
*/

`ifndef CCV_AFU_PKG_VH
`define CCV_AFU_PKG_VH

package ccv_afu_pkg;

//-------------------------
//------ Parameters
//-------------------------
localparam CCV_AFU_DATA_WIDTH   =   512;
localparam CCV_AFU_ADDR_WIDTH   =   52;


typedef struct packed {
  logic illegal_base_address;
  logic illegal_protocol_value;
  logic illegal_write_semantics_value;
  logic illegal_read_semantics_execute_value;
  logic illegal_read_semantics_verify_value;
  logic illegal_pattern_size_value;
} config_check_t;





endpackage: ccv_afu_pkg

`endif
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4MaXLeMeEjDkzgBeM9o23z6+pHbj35m8ySf7hHVcd6a1zaIQvEdx1bEl4ZYuHNnjWWg7jhW0jhIIf7e2iZmQAGT78VKBny5MuxUzfgKEtM5ghNvSAGTdIMJHzRWa7yVi8+x30WDORpNVfqEPRa3NZxX4cCigFyMaqo04+/xygLcbFkwwl9Snp1qxge34vA1L2Fv74eFEXzS4RmHkS4/HBN6jElvgZ+M9UE1Vo+9QkdFTaL6rykLfJMyKCjr1LdcQs+5PibuMZhF1eBgWD7GfpvOFdrZYEvC+qKN9EOzH1dlW9GiboQkIvtJHnnNzosZvKE1WTXEEPG8gKMYqsgxD4BWQlR2mBr/aqQPgzBiYU4Leon1nBIlqqxOOT2rmkF8/3iLdUKPk7jHlNEki8gXE/WYw2VCmKBz6LacOEOwxm8tlBQNt31PnW3jG2LOnZ+ye6rW5SDaca3gpWTMIHCddd3fq4qF0yjd85VLDxx9xIYE78k/XZUEh39j9SD6Q62OXCYklxpxIFLxSo/oUi13bOdHEWJpPvG8KJudWwpf4JOQ88BNHG3EuWBZbfThHokrit1a5/cj4qQj50yOK7ntsMaSmTYJkpb/sw+jdsNnkSGVpnPGB+GDCdgfS0f0lgDy+Ms0MyVUXAK+6UxdOP854VFhJl2loWjlcKYdQnHvCu/PChf78vv6HNtYZK3+43/ZHkRQXeon9OznRhaTg/XCIurDoxg/IV+dcHBUZoetl4PGu27pUasPrfUvwXItYPfkEnZ6wmrf54X3JgoGe8dEhv4e"
`endif