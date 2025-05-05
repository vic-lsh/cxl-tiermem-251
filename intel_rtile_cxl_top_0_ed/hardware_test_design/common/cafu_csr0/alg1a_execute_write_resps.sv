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
///////////////////////////////////////////////////////////////////////
`include "ccv_afu_globals.vh.iv"

module alg1a_execute_write_resps
    import ccv_afu_pkg::*;
    import cafu_common_pkg::*;
(
  input logic clk,
  input logic reset_n,    // active low reset

  /*  signals to/from the write phase FSM of the execute stage of Algorithm 1a
  */
  input logic enable_in,       // active high

  /*  signals around a SLVERR on the AXI write response channel
  */
  input logic clear_slverr,    // active high

  output logic slverr_received,
  output logic busy_out,  // active high

  /* signals for AXI-MM write responses channel
  */
  output cafu_common_pkg::t_cafu_axi4_wr_resp_ready   bready,
  input  cafu_common_pkg::t_cafu_axi4_wr_resp_ch      write_resp_chan,

  /*  signals from configuration and debug registers
  */
  input logic [8:0] NAI,
  input logic [7:0] number_of_address_increments_reg,
  input logic       single_transaction_per_set,        // active high
  input logic       force_disable_afu                   // active high
);
    
// =================================================================================================
typedef enum logic [1:0] {
  IDLE          = 'd0,
  START         = 'd1,
  CHECK_COUNT   = 'd2,
  COMPLETE      = 'd3
} fsm_enum;

fsm_enum   state;
fsm_enum   next_state;

// =================================================================================================
logic initialize;
logic pipe_1_valid;
logic pipe_2_valid;
logic pipe_2_slverr_received;
logic set_to_not_busy;

logic [8:0] pipe_3_response_count;
logic [8:0] NAI_clkd;

cafu_common_pkg::t_cafu_axi4_resp_encoding    pipe_1_resp;

// =================================================================================================
always_ff @( posedge clk )
begin
  NAI_clkd <= ~reset_n
              ? 'd0
              : force_disable_afu
                ? 'd0
                : enable_in
                  ? NAI
                  : NAI_clkd;
end

// =================================================================================================
always_ff @( posedge clk )
begin
  busy_out <= ~reset_n
              ? 1'b0
              : initialize
                ? 1'b1
                : set_to_not_busy
                  ? 1'b0
                  : busy_out;
end

// =================================================================================================
/*  this is the BREADY signal to the AXI-MM write response channel
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )                      bready <= 1'b0;
  else if( initialize == 1'b1 )                   bready <= 1'b1;
  else if( single_transaction_per_set == 1'b1 )
  begin
    if( pipe_3_response_count < 1 )               bready <= bready;
    else                                          bready <= 1'b0;
  end
  else if( pipe_3_response_count < (NAI_clkd+1) ) bready <= bready;
  else                                            bready <= 1'b0;
end

// =================================================================================================
/*  treating the BREADY signal as a 'busy' flag for this module
    if BREADY is low, valids are low
    if BREADY is high, clock the BVALID signal of the AXI-MM write response channel
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 ) pipe_1_valid <= 1'b0;
  else if( bready == 1'b0 )  pipe_1_valid <= 1'b0;
  else                       pipe_1_valid <= write_resp_chan.bvalid;
end

// =================================================================================================
/*  treating the BREADY signal as a 'busy' flag for this module
    if BREADY is low, set to zero
    if BREADY is high, clock the BRESP signal of the AXI-MM write response channel
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 ) pipe_1_resp <= eresp_CAFU_EXOKAY;
  else if( bready == 1'b0 )  pipe_1_resp <= eresp_CAFU_EXOKAY;
  else                       pipe_1_resp <= write_resp_chan.bresp;
end

// =================================================================================================
/*  treating the BREADY signal as a 'busy' flag for this module
    if BREADY is low, valids are low
    if BREADY is high, clock the result of the logic indicating a valid write response
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 ) pipe_2_valid <= 1'b0;
  else if( bready == 1'b0 )  pipe_2_valid <= 1'b0;
  else                       pipe_2_valid <= pipe_1_valid; // want to count slverr in response count
  //else begin
  //     pipe_2_valid <= ( ( pipe_1_valid == 1'b1 )
  //                     & ( pipe_1_resp  == eresp_OKAY )
  //                     );
  //end
end

// =================================================================================================
/*  treating the BREADY signal as a 'busy' flag for this module
    if BREADY is low, set to zero
    if BREADY is high, increment by the value in pipe_2_valid (1 or 0)
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )    pipe_3_response_count <= 9'd0;
  else if( initialize == 1'b1 ) pipe_3_response_count <= 9'd0;
  else if( bready == 1'b0 )     pipe_3_response_count <= 9'd0;
  else                          pipe_3_response_count <= pipe_3_response_count + {8'd0, pipe_2_valid};
end

// =================================================================================================
/* Have to monitor bresp for a SLVERR. If received, treat like an error and record
   all errors the same except for patterns.
*/
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )      pipe_2_slverr_received <= 1'b0;
  else if( clear_slverr == 1'b1 ) pipe_2_slverr_received <= 1'b0;
  else if( bready == 1'b0 )       pipe_2_slverr_received <= 1'b0;
  else begin
       pipe_2_slverr_received <= ( ( pipe_1_valid == 1'b1 )
                                 & ( pipe_1_resp  == eresp_CAFU_SLVERR ) )
                                 | pipe_2_slverr_received;          // once dedicated, keep it until clear
  end
end


assign slverr_received = pipe_2_slverr_received;

// =================================================================================================
always_ff @( posedge clk )
begin
       if( reset_n == 1'b0 )                state <= IDLE;
  else if( force_disable_afu== 1'b1 )       state <= COMPLETE;   // so that set_to_not_busy pulses
  else if( pipe_2_slverr_received == 1'b1 ) state <= COMPLETE;   // so that set_to_not_busy pulses
  else                                      state <= next_state;
end

// =================================================================================================
always_comb
begin
  initialize = 1'b0;
  set_to_not_busy = 1'b0;

  case( state )
    IDLE : 
    begin
      if( enable_in == 1'b1 )
      begin
                                                      next_state = START;
                                                      initialize = 1'b1;
      end
      else begin
                                                      next_state = IDLE;
      end
    end

    START :
    begin
                                                      next_state = CHECK_COUNT;

    end

    CHECK_COUNT :
    begin
           if( force_disable_afu == 1'b1 )            next_state = COMPLETE;
      else if( single_transaction_per_set == 1'b1 )
      begin
           if( pipe_3_response_count == 'd0 )         next_state = CHECK_COUNT;
           else                                       next_state = COMPLETE;
      end
      else if( pipe_3_response_count < (NAI_clkd+1) ) next_state = CHECK_COUNT;
      else                                            next_state = COMPLETE;
    end

    COMPLETE :
    begin
                                                 set_to_not_busy = 1'b1;
                                                      next_state = IDLE;
    end

    default :                                         next_state = IDLE;
  endcase
end


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "KfPH2h2o6ygmchzDset6LuVAD9YpqMRQdAzjgr0wk2126ElJrwVM1+IMThlQvaUd9eQr8K7B/w4N6hgRLwTZ/rM6ENl+ieJV0tHeZg5yQxZmj5t9MbORdNhsFcz9E/9a25qeEStMYKwOL9rwRQmUVLDgieVlA24VAxKOSroXFdDlmIGNBIPZe7YT6CP6NkIsBlBst74zNDeMiw9IiC40K+TLCq3/OKloX/uW9V1v1hv9tckK7JlqLHq4K35L+s2aJUBNNxbflrkKmAInPX9CDjAceDWJqFdWhnQOAZbVOIMlknEHXUbOB2OgPTRC6Ue/ErhDNv+M1AQyl2zhu8hOo90MhFL7osRTFqw+Eik48kHVt92nxopMgf7CdJjGs4NN3Doq/4Vrqd+5+Y9Y09kJ9N8De43ntqwJQCF7YYGkqOEX305A4n1BUT35IXzUG/1Se1kNR3d+a6NZKnENGGXUR8aWhbiFjvjYek5Xhq/DWnzPiXK4f5mDCnSZPiXXYUE/QJvzK3nbyR+3t9OitFmpZ/PrsAXJzaY+GahNwgmY82Q9ae4o9o/UdSmg/8bKB5eOLj0U/G+daMh888HW3SSzf9RSfeEBau67EMgcfwzf1jHck3bmJJ8mHCvabELAHbjCv3hpU1nss37hrjHXHCf2mUpKG15ZK1RvE+OfcmDo/jYbEzcepPSr2WAscna7QZrYM1hWmPcq1noTiYKPw4D+/mtRtcUEI5OVAIcMJIGwF1x/XoKtXcbHCitZngi3QfnIHAT4oJX588wvu1ZE0zKn8Tzx0XPXGNIerOJ3cjohT2ohXIBvKxK6etbcxAJfYj4uTeAAQtvauWSFMhHs7u564IMfgpc/b+rISsljo6+V+MrwXLqmfjzTHSUblibIeCWlrGuoYqohiKKhLcwjbE5q1XLx0Tj+P+HWq3roR/TO9x9IGAg0sMTBQwCSPtpTo532JklE+RR38czbziKhQqw761vgYgM0OOyS1hkDY55+r8Z9hZgTWAhxvWkqz849F2gd"
`endif