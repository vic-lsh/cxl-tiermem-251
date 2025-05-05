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


// -------------------------------------
// Merlin Demultiplexer
//
// Asserts valid on the appropriate output
// given a one-hot channel signal.
// -------------------------------------

`timescale 1 ns / 1 ns

// ------------------------------------------
// Generation parameters:
//   output_name:         pcie_ed_altera_merlin_demultiplexer_1921_s5kn7vi
//   ST_DATA_W:           1267
//   ST_CHANNEL_W:        1
//   NUM_OUTPUTS:         1
//   VALID_WIDTH:         1
// ------------------------------------------

//------------------------------------------
// Message Supression Used
// QIS Warnings
// 15610 - Warning: Design contains x input pin(s) that do not drive logic
//------------------------------------------

// altera message_off 16753
module pcie_ed_altera_merlin_demultiplexer_1921_s5kn7vi
(
    // -------------------
    // Sink
    // -------------------
    input  [1-1      : 0]   sink_valid,
    input  [1267-1    : 0]   sink_data, // ST_DATA_W=1267
    input  [1-1 : 0]   sink_channel, // ST_CHANNEL_W=1
    input                         sink_startofpacket,
    input                         sink_endofpacket,
    output                        sink_ready,

    // -------------------
    // Sources 
    // -------------------
    output reg                      src0_valid,
    output reg [1267-1    : 0] src0_data, // ST_DATA_W=1267
    output reg [1-1 : 0] src0_channel, // ST_CHANNEL_W=1
    output reg                      src0_startofpacket,
    output reg                      src0_endofpacket,
    input                           src0_ready,


    // -------------------
    // Clock & Reset
    // -------------------
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) // setting message suppression on clk
    input clk,
    (*altera_attribute = "-name MESSAGE_DISABLE 15610" *) // setting message suppression on reset
    input reset

);

    localparam NUM_OUTPUTS = 1;
    wire [NUM_OUTPUTS - 1 : 0] ready_vector;

    // -------------------
    // Demux
    // -------------------
    always @* begin
        src0_data          = sink_data;
        src0_startofpacket = sink_startofpacket;
        src0_endofpacket   = sink_endofpacket;
        src0_channel       = sink_channel >> NUM_OUTPUTS;

        src0_valid         = sink_channel[0] && sink_valid;

    end

    // -------------------
    // Backpressure
    // -------------------
    assign ready_vector[0] = src0_ready;

    assign sink_ready = |(sink_channel & ready_vector);

endmodule

`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5KTDfuyu3XAZ1c806c7oYVpWre4Uhf+BGPSwp1ejVHOADjcTKetP6V7r+Ln1dohipZrn77cGK37A4IAwCfGMs5dNpoEM2O6tK37ZTqyc7DjRsgAZEBYZqd+DYv8UUFxjS21GW4UXw+De5qdd65eitA5xo0EnE6rehJEv4Z9xuRw/cQBVepZLsYxZ8JXb2OLZSsu/LsmVEKP8/HmmjScsRUidxD01IjqM7wjkU5EjtXWYVEMGne7CNh/oaaH9y500KPlWGzRGaTzF7KSTWjhP42QowFZZqFRxW7dd3RbWvIRH1A+LKKBrCdfriuxI0wCfxGUUdrH3FRN7BaItxujM63qwmnXo2KIyCzyvLDj+yjf+eHp95bQtttUbCr9OvzddV6kylbyHB2kEVb53px3xp2S9GVAdHTm99sFr5CWtLTxTEs2oY7LQT3NeJd6pumiaDDakmyFuN3Vl38jDSYHhT1NVQA5+d42EMrX0JT8T5AT0nENAe9yC42S/nZXh8ZubPjcJdDcjphWnsnuC7Fts63UpHMS6SpfuTk9m8bz43bzjTl5h7RXP4ziQFog4JTk3pY9HKHi04RJhjKPmn2O9ibDcwtxohV10534t1j21KIUAVon/Q+SWlOpV8OCFpRPAkndEpbcESm9WO4TBBbqWwgxGiWPGLVBwvJS1sVRj0xNDEaY+oX+jKaABikIhXSmuoaKA1WVkqE3WWyLtSma5UlVF/tJxKHee2WEOPkm2ZXEFr/bBhWCvRdoQa2ZZLMDryQnlmH/+D9LcpPtrzxJhWqN"
`endif