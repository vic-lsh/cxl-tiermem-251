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

module mwae_error_injection_regs
    import ccv_afu_pkg::*;
//   import ccv_afu_cfg_pkg::*;
   import tmp_cafu_csr0_cfg_pkg::*;
(
  input clk,
  input reset_n,

  `ifdef INCLUDE_POISON_INJECTION
         input [2:0] algorithm_reg,
         input       force_disable_afu,
         input       i_cache_poison_inject_busy,
  `endif

  output tmp_cafu_csr0_cfg_pkg::tmp_new_DEVICE_ERROR_INJECTION_t   new_device_error_injection_reg
);

logic cache_poison_busy;

`ifdef INCLUDE_POISON_INJECTION
  always_ff @( posedge clk )
  begin
         if( reset_n == 1'b0 )           cache_poison_busy <= 1'b0;
//    else if( algorithm_reg == 'd0 )      cache_poison_busy <= 1'b0;
    else if( force_disable_afu == 1'b1 ) cache_poison_busy <= 1'b0;
    else                                 cache_poison_busy <= i_cache_poison_inject_busy;
  end
`else
      assign cache_poison_busy = 1'b0;
`endif

assign new_device_error_injection_reg.CachePoisonInjectionBusy = cache_poison_busy;
//assign new_device_error_injection_reg.MemPoisonInjectionBusy   = 1'b0;
//assign new_device_error_injection_reg.IOPoisonInjectionBusy    = 1'b0;
//assign new_device_error_injection_reg.CacheMemCRCInjectionBusy = 1'b0;

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4P082YZ2CaSDE6Xx/C0wzqFD23EMGQgdTjlQaXqB/CS7DhZbryH41NBKonwb1uXt9E1IFIybCfvRNX/9Ip9zaHj4ch44w3BG2W06umR3aDALMMQhgnuns5JzqB0Fmj8cJTjD9WjSRluFcyU3V0ucI4U2QE2ENwzGOjYjo0CRmxzH43Bjxv3UDILLsXDYhyxD48xV2DeiQP0N3M/v3iXRfUoqz4yUoE9CAPoTYTSzxodrM8DY7cmWtUa/kDe1aQ4mlEJWIPyIiSc5swXZWgSTc2JeDU/2h/2rTVSA2vD/+xoGgs/jgIMzvaZ7ZSLkI9Lzpdx0rLsyvOaqjZJzA0v0l1Eu+f2Nw3jemGGaQlUgtXmqQwB48PL2b/GDtLHFW5P36epKo/iUCi8aSgI70dOchqrLWQFsjL2V3d6fIn/5OktYz/C7UM/HCwEtHlNQ45Vdf/5XvCTG80UTKVJfbB6vxBPImoNDAtOOLXzeAcReQg0kZ4jqD2B4zc9fY+wloZFksQV5DYgzvCiwiRIjgKpGmFoI6McVNwJLXNsIzbQ6obCj3210OkH2tRUNxae4Sq5NqbX9Zl5/lmbymRWhI3aavtV7M2L3qr4ECxljeOgFICGkur1AMNWbV70nKsj+7gjTl6P8Qju2GY9ZHmnKLap0nLKIgEiKwJWi6+bH7iX/D0y8Rvp8Zb3kZZHK7AOjW1+2rd4yo+7cVlpXesj2ExhPquY6N3rA6Ishbpk2osHYfve7yq/9v25WPCpmjKm55ipI0AdyrfLTkVl2880mHqQKpVv"
`endif