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

module mwae_afu_status_regs
//   import ccv_afu_cfg_pkg::*;
   import tmp_cafu_csr0_cfg_pkg::*;
   import ccv_afu_pkg::*;
(
  input clk,
  input reset_n,                //  active low
  input i_mwea_top_level_fsm_busy,
  input i_alg_1a_execute_busy,
  input i_alg_1a_verify_sc_busy,
  input i_alg_1a_verify_nsc_busy,
  input i_alg_1b_execute_busy,
  input i_alg_1b_verify_sc_busy,
  input i_alg_1b_verify_nsc_busy,
  input i_alg_2_execute_busy,

  input [7:0]  i_current_loop_number,
  input [3:0]  i_current_set_number,
  input [31:0] i_current_base_pattern,
  input [51:0] i_current_base_address,

  output tmp_cafu_csr0_cfg_pkg::tmp_new_DEVICE_AFU_STATUS1_t device_afu_status_1_reg,
  output tmp_cafu_csr0_cfg_pkg::tmp_new_DEVICE_AFU_STATUS2_t device_afu_status_2_reg
);


always_ff @( posedge clk )
begin
  if( reset_n == 1'b0 ) 
  begin
       device_afu_status_1_reg.afu_busy               <= 1'b0;
       device_afu_status_1_reg.alg_execute_busy       <= 1'b0;
       device_afu_status_1_reg.alg_verify_nsc_busy    <= 1'b0;
       device_afu_status_1_reg.alg_verify_sc_busy     <= 1'b0;
       device_afu_status_1_reg.loop_number            <= 'd0;
       device_afu_status_1_reg.set_number             <= 'd0;
       device_afu_status_1_reg.current_base_pattern   <= 'd0;
  end
  else begin
       device_afu_status_1_reg.afu_busy               <= i_mwea_top_level_fsm_busy;
       device_afu_status_1_reg.alg_execute_busy       <= i_alg_1a_execute_busy;
       device_afu_status_1_reg.alg_verify_nsc_busy    <= i_alg_1a_verify_nsc_busy;
       device_afu_status_1_reg.alg_verify_sc_busy     <= i_alg_1a_verify_sc_busy;
       device_afu_status_1_reg.loop_number            <= i_current_loop_number;
       device_afu_status_1_reg.set_number             <= i_current_set_number;
       device_afu_status_1_reg.current_base_pattern   <= i_current_base_pattern;
  end
end

always_ff @( posedge clk )
begin
  if( reset_n == 1'b0 )  device_afu_status_2_reg.current_base_address <= 'd0;
  else                   device_afu_status_2_reg.current_base_address <= i_current_base_address;
end


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4ODnPc/z/D/nb8v4US2xt+B+4Si7CtNb6kATu7laJEpxSklwDlYHmMRnmbVEvEURxBkuusYWOtNBRBtnavfaAMupKVz/C8ps60aucKhoKyHzuTBgyL7NQpcnuA1Sga0t9YvLWR3W8sZzWbyP6fIBxGEsdTd142KzcK/Q33H5HRPLAQOudPMxBx/5oSE8OHnV6SwXpsB2NqYjl4NwbJ5AhpokuUgjqAZfzqzqlx1XeGbSLRCk2tI0ioFCuCsHDkbEaXbaQvUUt/bn42m7iCVT+3RY24H9fDgAO/FbvULOMkQluO0cnbLQkVna/DmAhcMkrKV9sjjvb9qJLudVjxh92bSyIh6MvqtTfgctCzybdz6r/z07ZfekuB4+w+JyNpW1bOSmqp0K7VdF8T+J0DuObnWHBMfhKCpwGb94j7dUw5Zpn0LXG82E+m+wp/C9f2gyyy8KoAk2eDi1ED9HQFTE44wjFSqeq5981WYTrBx2hlavLlyL7PlqR3jFvJgCxARwjriHFexodIrtp836Wbv9aofIFYY8Hx2UT4CVuK8yWTRvMgJ0Ul/f/ok4IbptUCmbltnZdAywadJzO1QRxX9I11P/Pt5U/aBlWnh4SgeeZkhiHCLPKfQABsDs1EpchyjhRlgHWEgl/QhjC3zctua4366lzeBW4hoBwgDYfpDu5ua/xx5WNVX1SmUQFksjLe7SkrwaaGU/w/ENUbsUWYl75tAZCmVX8inXcY/877nc/MUOzxQuCPayut3ZMrVixKsgPX6QOV1HrrLp4pi4KtsOyhX"
`endif