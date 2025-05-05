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


//Legal Notice: (C)2023 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 13469 16735 16788 

module pcie_ed_MEM0_altera_avalon_onchip_memory2_1932_vi4l4uq (
                                                                // inputs:
                                                                 address,
                                                                 byteenable,
                                                                 chipselect,
                                                                 clk,
                                                                 clken,
                                                                 freeze,
                                                                 reset,
                                                                 reset_req,
                                                                 write,
                                                                 writedata,

                                                                // outputs:
                                                                 readdata
                                                              )
;

//  parameter INIT_FILE = "pcie_ed_MEM0_MEM0.hex";


  output  [1023: 0] readdata;
  input   [  7: 0] address;
  input   [127: 0] byteenable;
  input            chipselect;
  input            clk;
  input            clken;
  input            freeze;
  input            reset;
  input            reset_req;
  input            write;
  input   [1023: 0] writedata;


wire             clocken0;
wire             freeze_dummy_signal;
reg     [1023: 0] readdata;
wire    [1023: 0] readdata_ram;
wire             reset_dummy_signal;
wire             wren;
  assign reset_dummy_signal = reset;
  assign freeze_dummy_signal = freeze;
  always @(posedge clk)
    begin
      if (clken)
          readdata <= readdata_ram;
    end


  assign wren = chipselect & write;
  assign clocken0 = clken & ~reset_req;
  altsyncram the_altsyncram
    (
      .address_a (address),
      .byteena_a (byteenable),
      .clock0 (clk),
      .clocken0 (clocken0),
      .data_a (writedata),
      .q_a (readdata_ram),
      .wren_a (wren)
    );

  defparam the_altsyncram.byte_size = 8,
//           the_altsyncram.init_file = INIT_FILE,
           the_altsyncram.lpm_type = "altsyncram",
           the_altsyncram.maximum_depth = 256,
           the_altsyncram.numwords_a = 256,
           the_altsyncram.operation_mode = "SINGLE_PORT",
           the_altsyncram.outdata_reg_a = "UNREGISTERED",
           the_altsyncram.ram_block_type = "AUTO",
           the_altsyncram.read_during_write_mode_mixed_ports = "DONT_CARE",
           the_altsyncram.read_during_write_mode_port_a = "DONT_CARE",
           the_altsyncram.width_a = 1024,
           the_altsyncram.width_byteena_a = 128,
           the_altsyncram.widthad_a = 8;

  //s1, which is an e_avalon_slave
  //s2, which is an e_avalon_slave

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5KDctSdR9Z7LPkLbs3aV7+9FT1x1KhxQfcQzV6+hTcQU2sKGRGI0WUi4ciGgVQzbOqv7bwWOMWrFBw/cmvID+ziui2UbF4PDs3gYgUKAgm4R+W14maBY6vRLxJ6+Q2fN9n3yXwvtyz3dT8ESfht/jtMRl6HGouJ7orFbuIy4ledXb+y1wbJVhRc2+w3SayHep8ID4Oeyw3E0rtt8oUwE6CRMQenvcgsyKz5yMtf/qYbgthiNjlUmnQVe4DzZsdHUUbZQILKipkO7CNrhJ1sp/hXOHKV+FpeZgXblp9D9AjDKMAMogU8qatR9JE6Y8NksSAo1kOop9amKzyUmeenm9r/mHk6kSLCM+rVoCxXb5GRQeY7x5wLnYkEPYdRfPzO3jvKvuEpzAjh0sGPq7wb6dWMZ0Bnj0bMnxcjyqmRshDR4uXq8SEsqiN7HjK5S2sHijtmHSD7SfAqKXXgLIfirxPxe9EJn6681Dkx9I1I9OdPJ/33E0I6LuZJErsNpVGNZmQzJsl/LOAMNrmAxZEBu9bNta3VlkV5gtgHo2ReUbQ3mP3YnzKI/G26zFGxfjCoVA/SHC039/OKSMxV0FNAXDbCcTHz5U4taxzpzNP+hwE0aZslqdjPQYMvuF5dKtBhimQzzUArYkibd7fswCsRSHzOcLu0wWzDWVXtbQkNmcZyR/b8tRx19Z8pHpgcscqb/WVgqWd63N9SXqQDjAw1PdhPtZfGLBBOdJFT5naQZJ92m6JhV0TBxrPYkLDgxDMPlcCVpUbfjYVB2o5sAhTExIlf"
`endif