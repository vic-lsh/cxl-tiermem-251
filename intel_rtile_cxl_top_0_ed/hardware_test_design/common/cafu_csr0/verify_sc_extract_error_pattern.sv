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

/*  Page 602 of CXL 2.0 Spec
*/

module verify_sc_extract_error_pattern
(
    input           clk,
    input           reset_n,
    input [511:0]   data_in,
    input [63:0]    compare_mask_in,
    input [2:0]     pattern_size_reg_in,
//    input           error_found_in,
   input            enable_in,
  
    output logic [31:0]   first_error_pattern_out
);

logic [31:0] temp_error_pattern_comb;
logic [31:0] temp_error_pattern;


always_comb
begin
  if( enable_in == 1'b0 )                        temp_error_pattern_comb = temp_error_pattern;
  else begin
         if( compare_mask_in[0] == 1'b1 )        temp_error_pattern_comb = data_in[31:0];
    else if( compare_mask_in[1] == 1'b1 )        temp_error_pattern_comb = data_in[31:0];
    else if( compare_mask_in[2] == 1'b1 )        temp_error_pattern_comb = data_in[31:0];
    else if( compare_mask_in[3] == 1'b1 )        temp_error_pattern_comb = data_in[31:0];
    else if( compare_mask_in[4] == 1'b1 )        temp_error_pattern_comb = data_in[63:32];
    else if( compare_mask_in[5] == 1'b1 )        temp_error_pattern_comb = data_in[63:32];
    else if( compare_mask_in[6] == 1'b1 )        temp_error_pattern_comb = data_in[63:32];
    else if( compare_mask_in[7] == 1'b1 )        temp_error_pattern_comb = data_in[63:32];
    else if( compare_mask_in[8] == 1'b1 )        temp_error_pattern_comb = data_in[95:64];
    else if( compare_mask_in[9] == 1'b1 )        temp_error_pattern_comb = data_in[95:64];
    else if( compare_mask_in[10] == 1'b1 )       temp_error_pattern_comb = data_in[95:64];
    else if( compare_mask_in[11] == 1'b1 )       temp_error_pattern_comb = data_in[95:64];
    else if( compare_mask_in[12] == 1'b1 )       temp_error_pattern_comb = data_in[127:96];
    else if( compare_mask_in[13] == 1'b1 )       temp_error_pattern_comb = data_in[127:96];
    else if( compare_mask_in[14] == 1'b1 )       temp_error_pattern_comb = data_in[127:96];
    else if( compare_mask_in[15] == 1'b1 )       temp_error_pattern_comb = data_in[127:96];
    else if( compare_mask_in[16] == 1'b1 )       temp_error_pattern_comb = data_in[159:128];
    else if( compare_mask_in[17] == 1'b1 )       temp_error_pattern_comb = data_in[159:128];
    else if( compare_mask_in[18] == 1'b1 )       temp_error_pattern_comb = data_in[159:128];
    else if( compare_mask_in[19] == 1'b1 )       temp_error_pattern_comb = data_in[159:128];
    else if( compare_mask_in[20] == 1'b1 )       temp_error_pattern_comb = data_in[191:160];
    else if( compare_mask_in[21] == 1'b1 )       temp_error_pattern_comb = data_in[191:160];
    else if( compare_mask_in[22] == 1'b1 )       temp_error_pattern_comb = data_in[191:160];
    else if( compare_mask_in[23] == 1'b1 )       temp_error_pattern_comb = data_in[191:160];
    else if( compare_mask_in[24] == 1'b1 )       temp_error_pattern_comb = data_in[223:192];
    else if( compare_mask_in[25] == 1'b1 )       temp_error_pattern_comb = data_in[223:192];
    else if( compare_mask_in[26] == 1'b1 )       temp_error_pattern_comb = data_in[223:192];
    else if( compare_mask_in[27] == 1'b1 )       temp_error_pattern_comb = data_in[223:192];
    else if( compare_mask_in[28] == 1'b1 )       temp_error_pattern_comb = data_in[255:224];
    else if( compare_mask_in[29] == 1'b1 )       temp_error_pattern_comb = data_in[255:224];
    else if( compare_mask_in[30] == 1'b1 )       temp_error_pattern_comb = data_in[255:224];
    else if( compare_mask_in[31] == 1'b1 )       temp_error_pattern_comb = data_in[255:224];
    else if( compare_mask_in[32] == 1'b1 )       temp_error_pattern_comb = data_in[287:256];
    else if( compare_mask_in[33] == 1'b1 )       temp_error_pattern_comb = data_in[287:256];
    else if( compare_mask_in[34] == 1'b1 )       temp_error_pattern_comb = data_in[287:256];
    else if( compare_mask_in[35] == 1'b1 )       temp_error_pattern_comb = data_in[287:256];
    else if( compare_mask_in[36] == 1'b1 )       temp_error_pattern_comb = data_in[319:288];
    else if( compare_mask_in[37] == 1'b1 )       temp_error_pattern_comb = data_in[319:288];
    else if( compare_mask_in[38] == 1'b1 )       temp_error_pattern_comb = data_in[319:288];
    else if( compare_mask_in[39] == 1'b1 )       temp_error_pattern_comb = data_in[319:288];
    else if( compare_mask_in[40] == 1'b1 )       temp_error_pattern_comb = data_in[351:320];
    else if( compare_mask_in[41] == 1'b1 )       temp_error_pattern_comb = data_in[351:320];
    else if( compare_mask_in[42] == 1'b1 )       temp_error_pattern_comb = data_in[351:320];
    else if( compare_mask_in[43] == 1'b1 )       temp_error_pattern_comb = data_in[351:320];
    else if( compare_mask_in[44] == 1'b1 )       temp_error_pattern_comb = data_in[383:352];
    else if( compare_mask_in[45] == 1'b1 )       temp_error_pattern_comb = data_in[383:352];
    else if( compare_mask_in[46] == 1'b1 )       temp_error_pattern_comb = data_in[383:352];
    else if( compare_mask_in[47] == 1'b1 )       temp_error_pattern_comb = data_in[383:352];
    else if( compare_mask_in[48] == 1'b1 )       temp_error_pattern_comb = data_in[415:384];
    else if( compare_mask_in[49] == 1'b1 )       temp_error_pattern_comb = data_in[415:384];
    else if( compare_mask_in[50] == 1'b1 )       temp_error_pattern_comb = data_in[415:384];
    else if( compare_mask_in[51] == 1'b1 )       temp_error_pattern_comb = data_in[415:384];
    else if( compare_mask_in[52] == 1'b1 )       temp_error_pattern_comb = data_in[447:416];
    else if( compare_mask_in[53] == 1'b1 )       temp_error_pattern_comb = data_in[447:416];
    else if( compare_mask_in[54] == 1'b1 )       temp_error_pattern_comb = data_in[447:416];
    else if( compare_mask_in[55] == 1'b1 )       temp_error_pattern_comb = data_in[447:416];
    else if( compare_mask_in[56] == 1'b1 )       temp_error_pattern_comb = data_in[479:448];
    else if( compare_mask_in[57] == 1'b1 )       temp_error_pattern_comb = data_in[479:448];
    else if( compare_mask_in[58] == 1'b1 )       temp_error_pattern_comb = data_in[479:448];
    else if( compare_mask_in[59] == 1'b1 )       temp_error_pattern_comb = data_in[479:448];
    else if( compare_mask_in[60] == 1'b1 )       temp_error_pattern_comb = data_in[511:480];
    else if( compare_mask_in[61] == 1'b1 )       temp_error_pattern_comb = data_in[511:480];
    else if( compare_mask_in[62] == 1'b1 )       temp_error_pattern_comb = data_in[511:480];
    else if( compare_mask_in[63] == 1'b1 )       temp_error_pattern_comb = data_in[511:480];
    else                                         temp_error_pattern_comb = 'd0;
  end
end


always_ff @( posedge clk )
begin
  temp_error_pattern <= ~reset_n ? 'd0 : temp_error_pattern_comb;
end


assign first_error_pattern_out = temp_error_pattern;
  
/*  
  case( pattern_size_reg_in )
      3'd0 :        first_error_pattern_out = 'd0;
      3'd1 :        first_error_pattern_out = {24'd0, temp_error_pattern[7:0]};
      3'd2 :        first_error_pattern_out = {16'd0, temp_error_pattern[15:0]};
      3'd3 :        first_error_pattern_out = {8'd0,  temp_error_pattern[23:0]};
      default :     first_error_pattern_out = temp_error_pattern;
  endcase
end
*/

endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "KfPH2h2o6ygmchzDset6LuVAD9YpqMRQdAzjgr0wk2126ElJrwVM1+IMThlQvaUd9eQr8K7B/w4N6hgRLwTZ/rM6ENl+ieJV0tHeZg5yQxZmj5t9MbORdNhsFcz9E/9a25qeEStMYKwOL9rwRQmUVLDgieVlA24VAxKOSroXFdDlmIGNBIPZe7YT6CP6NkIsBlBst74zNDeMiw9IiC40K+TLCq3/OKloX/uW9V1v1hsSlDA7UYdsmx6bYtxo9eesAXaQtYmZl7yAoVpgGUMBfNSSMne7mBKbG7RwO36Ydg+nc2tOEs4w1RWQaV3Me7x3yFtEST3hwk8wPz/iQQcak6Y88qBpTCNr5MPKCNXZ/aGW9KXysY+hN2JRHko1GnUR9U5eo6+jrHSw6ztltzxuutRRwRioCPW3tl0mnQ4V2+1n8nYn2/OTzmvztlEpOvpx75AvYAT8oDNIS2pdy7THWDFGzod1fikpMQMr+c5gDepeD0Txd+Dl021ig/NtWXd29MqWGwrFQlUTM+LVFP+AW84V9bVMI+S8h/NSPuFbSEv/ogKMwvJ/RCe/ectGH8nYTra1psZz5sBTKNuynJiIzsHRQ2fPNjfXRrKnmgX/5LhPAaJuXftpKJWm/FJd8+QkJc8bIp0NGMIZdJHd4nOEcNk5N6rzC74kZ+krIK1HR2kRl/Tqkvvo0orrABvYyrkPDH1i97bdW/28tle5ywojzJCOcZY8llrNLfiv+ngKCs4ViIgRGOlaruzIDfSBTYnvX5wLKLLKvUVxbYXXPU3UFusS+XA8Ml5hGSbH+WyFEwDYrWN/Oy4I5FeHZRgZU97Q6ytflgJnde5+c95Mh2hoT6XtAgxFK6sQodVnDaD+SckxYFtzRjo9qfkhfvhHIyun1niJk09uShBPWQZCTFQypwfn7RUgfdtb4sxRV/RrRBZRlaf5jFf4imMGgeI4g1G+kWirrrqAffWF/NjIqzBHFdulVJKQ/FmjUdtc4F6hYcQeL12EgY04N+CN6aa8ZXPv"
`endif