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

`ifndef CCV_AFU_ALG1A_PKG_VH
`define CCV_AFU_ALG1A_PKG_VH

package ccv_afu_alg1a_pkg;

//-------------------------
//------ Parameters
//-------------------------

typedef enum logic [1:0] {
  MODE_IDLE        = 2'd0,
  MODE_EXECUTE     = 2'd1,
  MODE_VERIFY_SC   = 2'd2,
  MODE_VERIFY_NSC  = 2'd3
} alg1a_mode_enum;

typedef enum logic [3:0] {
  AXI_WR_IDLE            = 4'd0,
//  AXI_WR_WAIT_TIL_4      = 4'd1,
  AXI_WR_WAIT_TIL_NOT_EMPTY = 4'd1,
  AXI_WR_FIRST_POP       = 4'd2,
  AXI_WR_FIRST_AWVALID   = 4'd3,
  AXI_WR_FIRST_AWREADY   = 4'd4,
  AXI_WR_NEXT_AWREADY    = 4'd5,
  AXI_WR_NEXT_AWVALID    = 4'd6,
  AXI_WR_LAST_AWREADY    = 4'd7,
  AXI_WR_LAST_AWVALID    = 4'd8,
  AXI_WR_LAST_WREADY     = 4'd9,
  AXI_WR_LAST_WVALID     = 4'd10,

  AXI_WR_FIRST_WAIT              = 4'd11,
  AXI_WR_FIRST_AWREADY_PLUS_POP2 = 4'd12



} alg1a_exe_axi_write_fsm_enum;







endpackage: ccv_afu_alg1a_pkg

`endif
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4O9F42OG8M2ivcH4RTUyjBAG8plkJH92TVBAFminNKKgl+wZCvOkIPdinOMJJ4q5mp4uGvb+pYT25VPwyYiXISG0qe5NiXFvaOhXamCd9NqZAJ4oxhaW5YEgz71cn80iWYRGgXEDPgdhJPFsJyr22dH1PZbl12Yr3HCF6MBw6EvaRdehXmqgLMHksjQMvYs6VIg63RM2ayo4zTJK2LbQnfSH+Hd1rz5dAzKDxa70mG8OGsRy7nl2FXTRx9vH9064G+2Mk+hYdNW472P44dJ6L5qajUa+npk6Abjf4gaAu/Hff32bbSF2Qdq03pNB2lOgmtmSUMyXEJOJEd44DMS+ksgwkp1rgz96+mU4l2EKCri/37r1mDl5KsfzenBp9XteaCXzLwWdL7AOIen2JXcm5/OzoHxJi4i9KUTqPm3hJoUg4u3EqdfJkGSxmBW2d8/MfDo7THX8tt4dEjI7ZF8gK7XRqak8ka0acvPfiqtVUq0PgmoexcJBOTdTA+1aaa4Q8R6eYUzWFIk6CtlfIaCXm7p86QXf33PlOlG7ftdQyzKnbxYcNAwmTj6a97mwNKaxmVML55ImJOXdFWtzPELLM/mRQjdAlfNFK9YxdIhpw+QSNuSu/fEzqiqumcNZjKt3Mc7pOWA1F5kNuXrgkxl+47RDpoJnM7OKt9OL35ldD2lY+GhSxAxvV3xmqpd2UWkRMKmvOaHZZ7gAUbIVTORG+9fOoxE56Uun0xPfl8Eyzs7Fly51z15UmvLh1Xwcp4Fbiv559oPRRU6ZWnD1/Gt9s7A"
`endif