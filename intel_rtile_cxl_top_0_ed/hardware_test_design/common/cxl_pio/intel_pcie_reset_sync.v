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


// (C) 2001-2023 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporat's design                tools, logic functions and other
// software and tools, and its AMPP partner logic functions, and any output
// files any of the foregoing (including device programming or simulation
// files), and any associated documentation or information are expressly subject
// to the terms and conditions of the Altera Program License Subscription
// Agreement, Altera MegaCore Function License Agreement, or other applicable
// license agreement, including, without limitation, that your use is for the
// sole purpose of programming logic devices manufactured by Altera and sold by
// Altera or its authorized distributors.  Please refer to the applicable
// agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

//`default_nettype none

module intel_pcie_reset_sync #(
  parameter                  WIDTH_RST              = 1
) (
  input                      clk,
  input                      rst_n,
  output [WIDTH_RST-1:0]     srst_n
);

  wire                       sync_rst_n;

  reg   [WIDTH_RST-1:0]      sync_rst_n_r /* synthesis dont_merge */;
  reg   [WIDTH_RST-1:0]      sync_rst_n_rr /* synthesis dont_merge */;

  assign srst_n              = sync_rst_n_rr;

  intel_std_synchronizer_nocut sync (.clk (clk), .reset_n (rst_n), .din (1'b1), .dout (sync_rst_n) );

  always @(posedge clk) begin
    sync_rst_n_r             <= {(WIDTH_RST){sync_rst_n}};
    sync_rst_n_rr            <= {(WIDTH_RST){sync_rst_n_r}};
  end 


endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5JZ4O3M/4Zqqu48r9yNEVtubDWkXBsxWBI9VrJKzoD/1V5UUY9/oub7LgnrgoOdTHZ5N/740KmdyK1hxc1mUbqpw5OqLX2TPWkn7pVIOQucwc5BDoFzIdjfAQ9KzNfvRg/HJOj5Hm3+jn2eqA9LxRrka2edf+V21bo0ZADMKSz5CsxaX3VScNvzve5RUC2Mql+r5/imA4PWSXci+Eh2hDtydsez5juK5fbso/0JHKw5/koEi6XGdH6YTnh9BWC4/2LnjVRhgxEnNqCV/iCtLjyMT+8947dsmnz8yrcvjbG/LOma9aFoeY28ps6pJH19H08cSQRBjosyfjkCanEdxyupUwRrDpLv+Rh/hibjfmXFdKf5qQQs6Q132kKS4UD9DDChjbqDlHranLPwpGLLF8s6+RaDlb8UrXfZsawDXk7cIBSTjqawlP3qZIyonIqNPyxAzofrWW+Cnbmj6wurD8je7DauoNxU5JC267OvOfrL3uIjOHEBjmmGHcpj0Bc0eVzr+dlSB6N8N9BgN4IhnR7YhzrmSXhU3fZSrKQClkuGsz7+qt5azkrkKMzfMpNF5XjWRTNGjSK6tzsH8cMn93UGGpQjQaASjSU9XZbZqY5g+AZYaISspVj7P7krC6KPA+UVCgUouu5ycaQDOzHbUB12ZxyFD5XnGOs8PXIjaCKkPWw6d5DPuVcF4Y/W5kVNftaSRdEuk54qWQ6QDcvaaDC4NPzE/zeGe/VqdrjDwaT38QoIzmPnnaBidc/yjrQvFcaNUIqmidCdZdUa8U7qh9jR"
`endif