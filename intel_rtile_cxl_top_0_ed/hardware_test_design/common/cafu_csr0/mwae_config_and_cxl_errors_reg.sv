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
`include "ccv_afu_globals.vh.iv"

module mwae_config_and_cxl_errors_reg
//   import ccv_afu_cfg_pkg::*;
   import tmp_cafu_csr0_cfg_pkg::*;
   import ccv_afu_pkg::*;
(
  input clk,
  input reset_n,                //  active low

  /* signal from mwae_top level fsm
  */
  input i_mwae_top_fsm_set_to_busy,   // active high
  input i_valid_illegal_config,       // active high
  input i_slverr_on_write_response,   // active high
  input i_slverr_on_read_response,    // active high
  input i_poison_on_read_response,    // active high

  input config_check_t   i_config_check_values,

  input unsupported_cache_flush_error,

  /* registers that are RW to hardware
  */
  output tmp_cafu_csr0_cfg_pkg::tmp_new_CONFIG_CXL_ERRORS_t        config_and_cxl_errors_reg
);

logic illegal_base_address;
logic illegal_protocol;
logic illegal_write_semantics;
logic illegal_eread_semantics;
logic illegal_vread_semantics;
logic illegal_pattern_size;

always_ff @( posedge clk )
begin
   if( reset_n == 1'b0 )
   begin
            illegal_base_address      <= 1'b0;
            illegal_protocol          <= 1'b0;
            illegal_write_semantics   <= 1'b0;
            illegal_eread_semantics   <= 1'b0;
            illegal_vread_semantics   <= 1'b0;
            illegal_pattern_size      <= 1'b0;
   end
   else if( i_mwae_top_fsm_set_to_busy == 1'b1 )
   begin
            illegal_base_address      <= 1'b0;
            illegal_protocol          <= 1'b0;
            illegal_write_semantics   <= 1'b0;
            illegal_eread_semantics   <= 1'b0;
            illegal_vread_semantics   <= 1'b0;
            illegal_pattern_size      <= 1'b0;
   end
   else if( i_valid_illegal_config == 1'b1 )
   begin
            illegal_base_address      <= i_config_check_values.illegal_base_address;
            illegal_protocol          <= i_config_check_values.illegal_protocol_value;
            illegal_write_semantics   <= i_config_check_values.illegal_write_semantics_value;
            illegal_eread_semantics   <= i_config_check_values.illegal_read_semantics_execute_value;
            illegal_vread_semantics   <= i_config_check_values.illegal_read_semantics_verify_value;
            illegal_pattern_size      <= i_config_check_values.illegal_pattern_size_value;
   end
   else begin
            illegal_base_address      <= illegal_base_address;
            illegal_protocol          <= illegal_protocol;
            illegal_write_semantics   <= illegal_write_semantics;
            illegal_eread_semantics   <= illegal_eread_semantics;
            illegal_vread_semantics   <= illegal_vread_semantics;
            illegal_pattern_size      <= illegal_pattern_size;
   end
end

`ifdef FLUSHCACHE_NOT_SUPPORTED
      assign config_and_cxl_errors_reg.illegal_cache_flush_call = unsupported_cache_flush_error;
`else
      assign config_and_cxl_errors_reg.illegal_cache_flush_call = 1'b0;
`endif

assign config_and_cxl_errors_reg.illegal_protocol               = illegal_protocol;
assign config_and_cxl_errors_reg.illegal_write_semantics        = illegal_write_semantics;
assign config_and_cxl_errors_reg.illegal_execute_read_semantics = illegal_eread_semantics;
assign config_and_cxl_errors_reg.illegal_verify_read_semantics  = illegal_vread_semantics;
assign config_and_cxl_errors_reg.illegal_pattern_size           = illegal_pattern_size;
assign config_and_cxl_errors_reg.illegal_base_address           = illegal_base_address;

logic poison;

always_ff @( posedge clk )
begin
        if( reset_n == 1'b0 )                    poison <= 1'b0;
   else if( i_mwae_top_fsm_set_to_busy == 1'b1 ) poison <= 1'b0;
   else if( i_poison_on_read_response == 1'b1 )  poison <= 1'b1;
   else                                          poison <= poison;
end

logic slverr_read;

always_ff @( posedge clk )
begin
        if( reset_n == 1'b0 )                    slverr_read <= 1'b0;
   else if( i_mwae_top_fsm_set_to_busy == 1'b1 ) slverr_read <= 1'b0;
   else if( i_slverr_on_read_response == 1'b1 )  slverr_read <= 1'b1;
   else                                          slverr_read <= slverr_read;
end

logic slverr_write;

always_ff @( posedge clk )
begin
        if( reset_n == 1'b0 )                    slverr_write <= 1'b0;
   else if( i_mwae_top_fsm_set_to_busy == 1'b1 ) slverr_write <= 1'b0;
   else if( i_slverr_on_write_response == 1'b1 ) slverr_write <= 1'b1;
   else                                          slverr_write <= slverr_write;
end

assign config_and_cxl_errors_reg.poison_on_read_response  = poison;
assign config_and_cxl_errors_reg.slverr_on_read_response  = slverr_read;
assign config_and_cxl_errors_reg.slverr_on_write_response = slverr_write;

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4OhFhMMNycBG453u1MIPyQRT8Xcx6Rs2Cp5WE4OxTp7bydRSIEAYQefk/OxbCLCyjsW53fszsCnjXx9qL1FubQg/mVQx+7q/j9iUqtes9gU0oyrvpgeiYVmiX9U94m+4zpV0qEyQpXOnabqWmhGIoN0yyNN9QxmG/RJem8zXtIuUCz71raCt8Pxx0rMRKoHaoOzxC8g8C1NGSM7vsw07w+lEaxIXDF+nO1EUvgiAqaanSWlp8eEWUfEI82+CHWBlaF3LA67uy8cmS05MUM/dqZJMQ++Wi6YB9WZ/RSKLsL/B5shQOemCN4RtLcuDkZ3wnADdIIxlztj4W5BSOkwGuQEeuA08nPA6L5LPie5zXXV7ZsYs9Xig9C2Wyww4CLPCgPsgS5bMRa26s5LaMMsWURfdyLoV9RpRi0WlaArMZ3fewTQGfuI36P1V6heHsAkVgEHuSGlNMEyZhn/u4yqkgIbYHrEZU3aI/lfzyjjge4eUo6r+TJML4af6xgy1Cut4fQQU3RyxCeTBn0QJ1/p8I+1ywmfPmQrVcb3gjGTQeDatn+Yq8GAbKmqrij9brE9s2/F/MB7E22eDgHrsfieHs8J968bI7SNdu734/TEZJKhTcOj80hsTzqu1wDpfN/0ldGJSFE2SrkMVww4rhDngJjEZeYB4bwmm0okZBL/+qucrE8V8M1QeellFOnw6bDeULgy3J/N8JXUyOHE+vIs6dAgFVa6VN3HK0wCdb/CihgWEsH9VfU81LJJdazjrvIiMrBAAZw6oli+aOw6jF4cF1//"
`endif