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

module mwae_poison_injection
(
  input clk,
  input reset_n,
  input wvalid,    // from the axi write data channel
  input poison_injection_start,
  input force_disable_afu,

  output logic poison_injection_busy,
  output logic set_wuser_poison
);

/* =======================================================================================
*/
typedef enum logic [1:0] {
  IDLE                   = 2'd0,
  CHECK_FOR_WVALID       = 2'd1,
  CLEAR_BUSY             = 2'd2,
  WAIT_START_LOW         = 2'd3
} fsm_enum;

fsm_enum    state;
fsm_enum    next_state;

/* =======================================================================================
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )           state <= IDLE;
  else if( force_disable_afu == 1'b1 ) state <= IDLE; 
  else                                 state <= next_state;
end

/* =======================================================================================
*/
logic set_busy_high;
logic set_busy_low;

always_comb
begin
  set_busy_high    = 1'b0;
  set_busy_low     = 1'b0;
  set_wuser_poison = 1'b0;

  case( state )
    IDLE :
    begin
      if( poison_injection_start == 1'b0 )    next_state = IDLE;
      else begin
	                                   set_busy_high = 1'b1;
                                              next_state = CHECK_FOR_WVALID;
      end
    end

    CHECK_FOR_WVALID :
    begin
      if( wvalid == 1'b0 )                    next_state = CHECK_FOR_WVALID;
      else begin
	                                set_wuser_poison = 1'b1;
                                              next_state = CLEAR_BUSY;
      end
    end

    CLEAR_BUSY :
    begin
	                                    set_busy_low = 1'b1;
                                              next_state = WAIT_START_LOW;
    end

    WAIT_START_LOW :   // require clear of start to do another poison injection
    begin
      if( poison_injection_start == 1'b0 )    next_state = IDLE;
      else                                    next_state = WAIT_START_LOW;
    end

    default :                                 next_state = IDLE;
  endcase
end

/* =======================================================================================
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )       poison_injection_busy <= 1'b0;
  else if( set_busy_high == 1'b1 ) poison_injection_busy <= 1'b1;
  else if( set_busy_low  == 1'b1 ) poison_injection_busy <= 1'b0;
  else                             poison_injection_busy <= poison_injection_busy;
end

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4PRmFTG8K4W+zWTWtDXUuz7jR6J15TZUTsUAz8fSey9q1K5DcvYYPZ5KV5xOkFyeR5JQq8uJti05MXkOMkxlQcibts3BBzyMZ41pi0Mvzc1PdeJ+dFT+353o9IdIC8fu7QHstqZ3znCworRP/1mc33flM0WVle1Mj0PS+2r7OdkF6jOuHKpxfQqMVwkpJpNHx2jkOGj+lnoH+QAtjgbEztMiHbJjf8z2Jk8xVpIpso0QuStPTvP2rzK+ixMhgKqlZHgIkgxBeBBqGngjA5StzYYUqRNhe46LDbeADDlyhUOgCoFbVWMwCJUEzkoPKyuX4CN7u6D3ub6z3n1Okq5nOjAIn8RNQxIgkU58gjY7juqDcbQVeHJt6+JHEDt8tyRbtFVje2c79jyjCC94lbTfOzRiH/9CdGUqAZj6GLkH6iGM3e2ZBLb0r2VVwK1SJ4SsDg39rI/q0x2MJHAtReoHU1WB1MKWEIc++7CnOuldU14rT5tK7oHA1nKhnBEz7NwATnBHTWRVDP+R2I534Jh0g+8A7rwbSuc0o2LOMh+nWINUlzbez5k6OMoNH5fJn4MANS86BbPQM+IbbqJZdjpcpkzMMQTsSGcsW+XfrxusyqsZ0FsMGYdYYLtDqpVNHxVT73OE905NK5BIv3xFKvTaxI9AMzSL3Mo/Zo4Z2bdQOXrw5ueWDgFrwtjZzJFm2bIBl3XtKPVxwwZLE6dihNPqV+zPj39imqiG5IBvtsQOzc607VfBoeS3IGzE64XBCVf+7v5pqQi4IZXWvXmQUbouOE7"
`endif