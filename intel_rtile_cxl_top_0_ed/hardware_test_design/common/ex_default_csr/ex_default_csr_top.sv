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

module ex_default_csr_top (
    input  logic        csr_avmm_clk,
    input  logic        csr_avmm_rstn,  
    output logic        csr_avmm_waitrequest,  
    output logic [63:0] csr_avmm_readdata,
    output logic        csr_avmm_readdatavalid,
    input  logic [63:0] csr_avmm_writedata,
    input  logic [21:0] csr_avmm_address,
    input  logic        csr_avmm_poison,
    input  logic        csr_avmm_write,
    input  logic        csr_avmm_read, 
    input  logic [7:0]  csr_avmm_byteenable
);


//CSR block


  

   ex_default_csr_avmm_slave ex_default_csr_avmm_slave_inst(
       .clk          (csr_avmm_clk),
       .reset_n      (csr_avmm_rstn),
       .writedata    (csr_avmm_writedata),
       .read         (csr_avmm_read),
       .write        (csr_avmm_write),
       .byteenable   (csr_avmm_byteenable),
       .readdata     (csr_avmm_readdata),
       .readdatavalid(csr_avmm_readdatavalid),
       .address      ({10'h0,csr_avmm_address}),
       .poison       (csr_avmm_poison),
       .waitrequest  (csr_avmm_waitrequest)
   );

//USER LOGIC Implementation 
//
//


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5IHIkI63jqy84zclkQZxrEOjAUIklPc2kZbHMUIucEk7zuqp8dEofevEAVJTxJR25PR96WdFqzfxdXdEprh00I+Vu2QEOpYUNXOwvT0R3U8rDvvaoVUup8of5xniEfe1pTDyoUa5QoFbMYIPjOBp0bZ0ZZa2Oh/eqbM0lx33bd4JhBokysjhLdLfI26SoFjDT3yvob0Ztl8wR5trghH6XtjdaSQ5P8UneMyUvJlj2DzLyQfg0AOP/E9EzSFpRNXZUqw0Wy3p6yAfrQDdxOkdGxrGHHXfSFvxU4c+Fu1noXqpUiRJQO49/uYANHIVvqK7ej8Mg8aRyskiMdbjV32H/uIdUtHM6/KVYJyt1dZKCjLWpAkyQ9OWQvizF1mPez2CaM5KXLh2qFBZtDOf3MyO9Ny+sWtKu4ayCtFrnvSg+MJSWPm2LhS1x1UWMwdFMormF/+Zh8fSNL3G/PyyFCQEPcoMJynvBKop1xPkSjDW41b4p7j/iG6DfZaK5AuiPrZ51N8XBEe7j4WoUghazBvovMAvfOZc63IifxUZTNmof5g/VNaTTxfMEq6Z1wc933N3UumZRjPb2j41nGHhJv+X4GzcI9b76/OQRKjtUVnxs1MgFykn9WD/x311xRJqww+CKF9y2lDVf6mPQuLV4VXYTmtinDO21mqMIk/34kYJ94VWl/yRtfQnIEUY1tGQlHIcJYF1+Q78tGv7tIwgEiEfCEitikuHmcrBDtOuRhvt5CzFFiUc9CusplDo+8eBjppuwcV2nEaCwLHkVWlUEFGK3K9"
`endif