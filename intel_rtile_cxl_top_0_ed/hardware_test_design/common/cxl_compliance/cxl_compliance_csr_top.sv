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

module cxl_compliance_csr_top (
    input               Uclk,
    input               Ureset_n,    
    input  logic        csr_avmm_clk,
    input  logic        csr_avmm_rstn,  
    output logic        csr_avmm_waitrequest,  
    output logic [63:0] csr_avmm_readdata,
    output logic        csr_avmm_readdatavalid,
    input  logic [63:0] csr_avmm_writedata,
    input  logic [21:0] csr_avmm_address,
    input  logic        csr_avmm_write,
    input  logic        csr_avmm_read, 
    input  logic [7:0]  csr_avmm_byteenable,
    input  logic [31:0] cxl_compliance_conf_base_addr_high ,
    input  logic        cxl_compliance_conf_base_addr_high_valid,
    input  logic [31:0] cxl_compliance_conf_base_addr_low ,
    input  logic        cxl_compliance_conf_base_addr_low_valid
);


//CSR block

   cxl_compliance_csr_avmm_slave cxl_compliance_csr_avmm_slave_inst(
       .clk          (csr_avmm_clk),
       .reset_n      (csr_avmm_rstn),
       .writedata    (csr_avmm_writedata),
       .read         (csr_avmm_read),
       .write        (csr_avmm_write),
       .byteenable   (csr_avmm_byteenable),
       .readdata     (csr_avmm_readdata),
       .readdatavalid(csr_avmm_readdatavalid),
       .address      (csr_avmm_address),
       .waitrequest  (csr_avmm_waitrequest)
   );

//USER LOGIC Implementation 
//
//


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "VPRJHuKBSkSPGqxQDsKp6ARIrVJ/JuQG7uZx0P1nXK/e/CQAE/8L7VsejyszKLHa9j1PwK+IcBx4m6FOfacz5KCx7FTpSaNB7yKuch2x0uA1d+KbFLrhoAwDqySq9o2kAG7O4YN2yedXt8uVKVTd5vlDnbKG0FLvgE1X9gEV8z6fMxtQhu0DZwctIsD8CwbTu6sDbR6mv/DpJi4GBU9qJgx5VtJ+E16qkMADG1A0VfX0htJD17WIz7Gv4pprIwO0Yn2vpL7hjmE+Vh+JgOcWlarmNPTMZmOVxxFl2e1dR8eTIKoIkJHR9R2dfMRocVupbCUPa9tVm8G87fQn24T+7dTCpgvnQP4rxmKY0rfDJExY0GVL03/TNGV7kxYwiKIuEzaPV6n3KOK5XQyQL+r1SIA00vusHrpGm6iWfJ1jtWk9tUuz+Tbe4Hch1RgosRhBgvsgLAEx5AVhUExNBvQbzx7NCGlx+NXtyEHqgNMfiFXbOU3wEsQWzO2gFgMmYnZ25hV8TZd2yMdjPsDOSPU11OV+xAIyge+IynEJYeCo35Ho1xpwr0Wwyh/1mH7aVg+0NCnsK32lIiASzeapikGa0SkPKlCV8FBtzROEM9MGxlMlvi7xAuYRlYrl9SG+bQ6onhHRVDx9Q2bt1mDuqGAS2gYKhmPIBF620TofuF6WhqvfSvjo5lbrJezQov2dq5u9ngq+rd+L4EnJtZV+FDO6SGrCXMdvD50LuHLgfKrHJAIKXuaWZiLqKDr5Xe0W7ux4iWP03vKV2Fi2c4mxNEcHb+B6UJIak51Z6bNRN8JqQChc42oZzN051k7ePIeYJsA8+LB5RWaYimagka+GcXFWbVvdCpW5AEegIFJAewr2y2Kkmz5MUbh+KL8dxZT75LZA2GGjXIMlAVmg08Z2FEe+GZOG52g61HjUUQDejrX3+DuxEwZlxMahPoAmjGe3nx+ZcMkkn5R2UOqGPp3WvQ2yM4nqPtpsv8GX9YQUEVMJP3h7WpUPOz9ZEzsga4dKN03H"
`endif