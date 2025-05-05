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

module mc_single_chan_devmem_errors
  import ddr_mc_top_common_pkg::*;
  import mc_ecc_pkg::*;
(
  input logic ipclk,
  input logic ipresetn,
  input logic rchan_rspfifo_rdempty_ipclk,

  input ddr_mc_top_common_pkg::t_rchan_rspfifo_data     rchan_rspfifo_dout_data_intf_ipclk,
  input ddr_mc_top_common_pkg::t_rchan_rspfifo_ecc      rchan_rspfifo_dout_ecc_intf_ipclk,

  output logic [mc_ecc_pkg::MC_ERR_CNT_WIDTH-1:0] mc_err_cnt_ipclk
);

// ================================================================================================
/* only want to collect ECC to be counted if rchan_cdc_rspfifo rdempty is low
*/
logic collect_ecc;

assign collect_ecc = rchan_rspfifo_dout_data_intf_ipclk.read_resp_valid
                   & ~rchan_rspfifo_rdempty_ipclk;

// ================================================================================================
/* Add register stage for timing
*/
mc_ecc_pkg::mc_devmem_if_t     mc_devmem_if_ipclk;

always_ff @(posedge ipclk)
begin
   mc_devmem_if_ipclk.RdDataValid     <= (~ipresetn | ~collect_ecc) ? 1'b0 : rchan_rspfifo_dout_data_intf_ipclk.read_resp_valid;
   mc_devmem_if_ipclk.RdDataECC.Valid <= (~ipresetn | ~collect_ecc) ? 1'b0 : rchan_rspfifo_dout_ecc_intf_ipclk.ecc_err_valid;
   mc_devmem_if_ipclk.RdDataECC.DBE   <= (~ipresetn | ~collect_ecc) ? 8'd0 : rchan_rspfifo_dout_ecc_intf_ipclk.ecc_err_fatal;
   mc_devmem_if_ipclk.RdDataECC.SBE   <= (~ipresetn | ~collect_ecc) ? 8'd0 : ( rchan_rspfifo_dout_ecc_intf_ipclk.ecc_err_corrected
                                                                             | rchan_rspfifo_dout_ecc_intf_ipclk.ecc_err_syn_e );
end

// ================================================================================================
mc_devmem_top    mc_devmem_top_inst
(
        .clk          ( ipclk ),
        .rst          ( ~ipresetn ),
        .mc_devmem_if ( mc_devmem_if_ipclk ),  
        .mc_err_cnt   (   mc_err_cnt_ipclk )   
);

// ================================================================================================
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5IzKoZIZxIxEMNCwFkdyz7TYW2ceCpSVkC0zOavfYCuBXp2Io4wNalmHIxHW8T/KQrAKAB+YsjKTASUqUWSjLmkhyjmTL18LeKiXoCQ/5lvZ2lmM/glf2Yup7LJJvOOclM9UK9FcOdTupfAp6pzZ1rdGJ1ezRuyVEP0I0oRLQQgfa57Jc5ESi7KOIPPyPCPqcqw1B2Izt0UjiYz+GsJEAiPyYwWAEsJ/69aAfG5HyXBVfWHN5Y6oL2ENnlytTfoLV2gTtqKPTCJsutS6RHgk+jBKAa92pwH30Io1JvOcvz0TKyMi5I9XpDziMxTZWjNDWO31AB613Bb66XVsXWylq877s5SqBVywbsgS+sKbBZXL3MGBv86FOdQ75jBo90I98BSdWLd1exqmot/lQ4LpkNftzZPrWoX+9SY12YtGWMsDkFbK2KCdwQ29PFGqTcRJT7Vsp/sipkErQfwklXbHVPF59zcrHMwVBLg6yA24V7OCNMzmOvvXQmt1lUiF3Za6HNx77P90CavBnRsrnEdY3Qq2/biSjUfVjgrMd8QlpPHYhr61ZGj/v79zcTw4yzHR9v0nMYVyJ5Hirsj2hOphGC4CkMwQ41S+wY2nFn86aIWFe0udyafrhs1mPsYArUWBqkVe873yO/eKKUcVFFa+DCFCEqHBOMj5x5/xxY1XMSW8TZ2c+nQqXcDDNfXoyD2W7iQw+Rp6JRtTQjy8czsM7WKPcnYXvXfW9zgFnNN/nESiVeBXj9hMUIlGkOg0gDLYWqIj8PLdn2SP87ATsIG4Wjm"
`endif