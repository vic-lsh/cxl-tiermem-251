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
// Description: Generic RAM with one read port and one write port.
//              Write port includes byte enables.
//

module cafu_ram_1r1w_be (clk,    // input   clock
                         we,     // input   write enable
                         be,     // input   write ByteEnables
                         waddr,  // input   write address with configurable width
                         din,    // input   write data with configurable width
                         raddr,  // input   read address with configurable width
                         dout    // output  write data with configurable width
                        );

parameter BUS_SIZE_ADDR = 4;                  // number of bits of address bus
parameter BUS_SIZE_DATA = 32;                 // number of bits of data bus
parameter BUS_SIZE_BE   = BUS_SIZE_DATA/8;
parameter GRAM_STYLE    = "no_rw_check, M20K";


input                           clk;
input                           we;
input   [BUS_SIZE_BE-1:0]       be;
input   [BUS_SIZE_ADDR-1:0]     waddr;
input   [BUS_SIZE_DATA-1:0]     din;
input   [BUS_SIZE_ADDR-1:0]     raddr;
output  [BUS_SIZE_DATA-1:0]     dout;

//Add directive to don't care the behavior of read/write same address
(*ramstyle=GRAM_STYLE*) reg [BUS_SIZE_BE-1:0][7:0] ram [(2**BUS_SIZE_ADDR)-1:0];  //ram divided into bytes.

reg [BUS_SIZE_ADDR-1:0] raddr_q;
reg [BUS_SIZE_DATA-1:0] dout;
reg [BUS_SIZE_DATA-1:0] ram_dout;
/*synthesis translate_off */
reg                     driveX;         // simultaneous access detected. Drive X on output
/*synthesis translate_on */


always_ff @(posedge clk)
begin
    if (we)
      for (int i=0; i < (BUS_SIZE_DATA/8); i++) 
      begin
        if (be[i])                
          ram[waddr][i]  <= din[7+(8*i)-:8];  // synchronous RAM write with byte enables
      end
    ram_dout<= ram[raddr];
    dout    <= ram_dout;
    /*synthesis translate_off */
    if(driveX)
      dout    <= 'hx;
    if( (raddr==waddr) && we )
      driveX <= 1;
    else
      driveX <= 0;            
    /*synthesis translate_on */
end


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4NFsU4rDNkPeFUDpnbx38SO1uJUwZRvVXQKCegzIWSILq7mpQ1XsDir8/fnt28sH19XAlIPu+lhe+PxiVIQBA3JG3ScDUsvD56+DfpbzT2xOIx0pWv0/MfZtijabBbSgY0RU4F+B3uuuxbVttuXZs4D0nSvQkLQymj6m7mbjmRV30WKB2F8ZIXMYxiKqW/e4qaJpnwYH98NxIzLfY5nulrUN64yeY5P5EEya0gw/eIMhbjtudH2fUjkpplWw5IJtjidjIRqYgBRDBf6MgSRrWvJR7TVHvWe4/EeCRtmO4IbTPlxnGLGnmAKAE5ztnad9J5ZyHJ9Wny22Wkw2OrXiTOxzlG7Bz0odXQg9uIo3tSo3fLbQrMmdaP+j/CG2lsYADv5/qXc8hcU12NOYZWAkIJaBVtHFX9H0UdyhKkZUJFkBnGI/Chk+aax9KMMR188gqksxaPpNaeZZQ6ADluklRU/AHA0r/BlI+tUM2U0Qlk6GwL1ssGtb593/R3a3kYIrgJb4cLhz9O0PflBZGWwK4A+102v5yx1Vgx1cuQbpeywn2ad2rQvGfeEkfz1KEEz6EPr75Hrh24pjqOJiG/RmQqWfPdHXBJIKFuqemr+a1k5F0bkQYGKGz6fgqtzRctLStE2YmsT2Nkuqgeo7ldAEbcNEvoEfvHpFXHtPXo3oJwU3lebIFvUMh8twuWrESULETeYUy5oX6sPRj5UUYA9fZRKQ/hVutG0MGFIjqOrtUNtIZvZOPOTScaJTPJx4W+qwWvzvG/ekGinTL2DxWu0dBQy"
`endif