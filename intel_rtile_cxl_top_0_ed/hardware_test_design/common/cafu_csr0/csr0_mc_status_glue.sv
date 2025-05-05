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

module csr0_mc_status_glue 
  import tmp_cafu_csr0_cfg_pkg::*;
  import cafu_common_pkg::*;
(
  input logic clk,
  input logic rst,
        
  input logic [cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] mc_status [cafu_common_pkg::CAFU_MC_CHANNEL-1:0],

  output tmp_cafu_csr0_cfg_pkg::tmp_MC_STATUS_t      csr0_mc_status,
  output logic                                       csr0_mem_active
);

/* internal signals begin */
logic [cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] mc_statusQ [cafu_common_pkg::CAFU_MC_CHANNEL-1:0];
tmp_cafu_csr0_cfg_pkg::tmp_MC_STATUS_t      csr0_mc_status_i;    
/* internal signals end */

/* Functional Logic begin */
assign csr0_mc_status = csr0_mc_status_i;

always_ff @(posedge clk)
begin
    mc_statusQ <= mc_status; 
end

  // MC[n][cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] status bits:
  // - status[0] = emif_cal_fail_eclk
  // - status[1] = emif_cal_success_eclk
  // - status[2] = emif_reset_done_eclk
  // - status[3] = emif_pll_locked_eclk
  // - status[4] = ram_init_done
assign csr0_mc_status_i.mc0_status[cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] = mc_statusQ[0];
assign csr0_mc_status_i.mc0_status[15:cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH]  = '0;

generate if (cafu_common_pkg::CAFU_MC_CHANNEL == 2)
begin : GenMc1Status
      assign csr0_mc_status_i.mc1_status[cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] = mc_statusQ[1];
      assign csr0_mc_status_i.mc1_status[15:cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH]  = '0;
      assign csr0_mem_active = mc_statusQ[0][4] & mc_statusQ[1][4];
end
else if (cafu_common_pkg::CAFU_MC_CHANNEL == 4)
begin : GenMc1Status
      assign csr0_mc_status_i.mc1_status[cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH-1:0] = mc_statusQ[1];
      assign csr0_mc_status_i.mc1_status[15:cafu_common_pkg::CAFU_MC_SR_STAT_WIDTH]  = '0;
      assign csr0_mem_active =   mc_statusQ[0][4]
                              & mc_statusQ[1][4]
                              & mc_statusQ[2][4]
                              & mc_statusQ[3][4];
end
else begin : GenMc1Status
      assign csr0_mc_status_i.mc1_status = '0;
      assign csr0_mem_active = mc_statusQ[0][4];
end
endgenerate

/* Functional Logic end */
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4PN43wI6S38xEK7Rged9kMq5rdOKgZ2VyJwT49szKai/c5xLQQrly+mGMUoOQP2ono61eW6ApTbza6sGcLpf01if2Mwhyf03Cx7Ip97YjjKu3YAkg2+hJ7eiZsCqoCgqUogApefH87hLIhOmoVb1l6+5Eoq33a+DScd0ignwEBxmpq+bJWDT4Ghnj8geJJOT30ETMg9RNTx/gMpnRYF0+X0vAx1zVXxZY5ExKigoAPb5HrogsmH0aw4uc+EZoOWYybKHBnILwIaIcW7CIbnQiLZ5dwDrDAgftGuZ+hltS7PZOj5FHJnI/Tu2nsty0fJlnSpOyLm7eEKccUc1Z8zWAvL0ILLQ4bY6rCdX8YBCoWIZaACzASptxl0Q3XWqytFvC/s/E/HdbLIxm7Qq11AbqBSz73F9s0FeNvhXo7BbuggWe6yPc+M958lBLQg0qaaEZXim7rKqmjRwLrVeMvO1g0Me8Dyo1WX8JZTXHzUcN4z1dhWou+5kiItMVTSXwkywJ0/BhqqSDqZU8XD6K5yl89QZlSwfPD85d6kPWTgIhDxH5f+7hRYaYXiVXm0rQEdiVy09LXg9w3ZA3mJzS+C/JjHDL2v7kEdw6EH8ikRu2ZqzUqcDfOiqyy0HYDujDr2OVvQzniGqXMfoSr3QF/pFJLZwjCEN2vVq16B+ORzkRn7KxFsf/dlSE0A3a7ZbDvbz2XJo6ETVczE4GEOUTiw/WSveIs4XuUZiTYaBDFqoK1U48z4fKbpe6oOf0bTZrMAjDajrcxfXA8qOISsAQb38o7j"
`endif