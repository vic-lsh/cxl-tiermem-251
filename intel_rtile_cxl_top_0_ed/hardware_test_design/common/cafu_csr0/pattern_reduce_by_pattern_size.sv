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

/*  Page 603 of CXL 2.0 Spec

PatternSize: Defines what size (in bytes) of P or B to use starting from 
least significant byte. As an example, if this is programmed to 3b011, 
only the lower 3 bytes of P or B registers will be used as a pattern. 
This will be programmed consistently with the ByteMask field and the base
address.
*/

module pattern_reduce_by_pattern_size
(
   input [2:0]           pattern_size_reg_in,
   input [31:0]          pattern_in,

   output logic [31:0]   pattern_out
);


always_comb
begin
  case( pattern_size_reg_in )
    // 3'b100 : pattern_out = pattern_in;
    3'b011  : pattern_out = {8'd0, pattern_in[23:0]};
    3'b010  : pattern_out = {16'd0, pattern_in[15:0]};
    3'b001  : pattern_out = {24'd0, pattern_in[7:0]};
    3'b000  : pattern_out = 32'd0;
    default : pattern_out = pattern_in;
  endcase
end



endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4O8DM0eyMhqUcc5uFflSsdWa13t7nVGPnSDhW8sLzd+wz7wZK2hLIoFYTZvSJpd8hF6ZJuIoVoOsqVYz+A7Hg9/Zv7z/vGo735pfmtvq+jgfxpa00eC1YQrpSGITxvpXRm0e01AJ/v43KSh/OPbrz/PGwmtmbyD29dUCmlfjoEZbgDKhDJJciXun9ivJD8EKvCLzuOLXCDv9iRhtmhxakJeSAgpYEcoj4YDmNQA1S1vbv9+x6BLGnXiAZv13SJn6+/inCA0+VDxXvrtXHbsQBZJBG4G6/UhfblJnFEsInXbf2pIToa1PVBiaR0MIRI9CMrrDCLHKM0BjYuLNSgfrrvSZeYTWfAtx7emXm7IthGsYP1d+Q0ZgShuccaQ0vfq0WJuec7ucopg46cefcasBIbtBCAx4x4OoXn14mBLK890skYq3EmJXqz1PvhV3sY7hWnlQYL75vBzxTKdNuDEopp8TZB3zuCvldqMYUuUNLUgMkQuhF0qd1KiIDIM7EEkIgYHX5cjptlNAheBLTLaOot3XxG+gjXoLqmRMX99Ceo93GAZTNxuInGYk12ioqk7XG0v4MqyiFVGy9zUwKmkhHysbj7Mpww3HwCbj8rXuJlkI/tSIl0qCyzzJs5KpiJj6EefFdi0BsVeWnnOzNNpd2L8LtZAFQtGJ5/PL8mQW8dRoJatzI8b+qSHDK63fxeoDAMjQJGKOZ90RtbrqgBHdTj2fDFTlkE98cFj9C5tGy9Tju7IuhvpqZMtf9Ao0UYMVJjVz/LJZz1q0Q5XaLEZ6D33"
`endif