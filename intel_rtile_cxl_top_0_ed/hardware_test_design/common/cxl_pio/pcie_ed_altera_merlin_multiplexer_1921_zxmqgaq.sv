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


// (C) 2001-2014 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.




// ------------------------------------------
// Merlin Multiplexer
// ------------------------------------------

// altera message_off 13448

`timescale 1 ns / 1 ns


// ------------------------------------------
// Generation parameters:
//   output_name:         pcie_ed_altera_merlin_multiplexer_1921_zxmqgaq
//   NUM_INPUTS:          1
//   ARBITRATION_SHARES:  1
//   ARBITRATION_SCHEME   "round-robin"
//   PIPELINE_ARB:        1
//   PKT_TRANS_LOCK:      1220 (arbitration locking enabled)
//   ST_DATA_W:           1267
//   ST_CHANNEL_W:        1
// ------------------------------------------

module pcie_ed_altera_merlin_multiplexer_1921_zxmqgaq
(
    // ----------------------
    // Sinks
    // ----------------------
    input                       sink0_valid,
    input [1267-1   : 0]  sink0_data,
    input [1-1: 0]  sink0_channel,
    input                       sink0_startofpacket,
    input                       sink0_endofpacket,
    output                      sink0_ready,


    // ----------------------
    // Source
    // ----------------------
    output reg                  src_valid,
    output [1267-1    : 0] src_data,
    output [1-1 : 0] src_channel,
    output                      src_startofpacket,
    output                      src_endofpacket,
    input                       src_ready,

    // ----------------------
    // Clock & Reset
    // ----------------------
    input clk,
    input reset
);
    localparam PAYLOAD_W        = 1267 + 1 + 2;
    localparam NUM_INPUTS       = 1;
    localparam SHARE_COUNTER_W  = 1;
    localparam PIPELINE_ARB     = 1;
    localparam ST_DATA_W        = 1267;
    localparam ST_CHANNEL_W     = 1;
    localparam PKT_TRANS_LOCK   = 1220;
    localparam SYNC_RESET       = 1;

    assign	src_valid			=  sink0_valid;
    assign	src_data			=  sink0_data;
    assign	src_channel			=  sink0_channel;
    assign	src_startofpacket  	        =  sink0_startofpacket;
    assign	src_endofpacket		        =  sink0_endofpacket;
    assign	sink0_ready			=  src_ready;
endmodule


`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5LrxMvofLUniDnFQVC4LO/mu+LdM3utJ6BpbG/Rg9rPq3etPLcFs7R8tOLhxb7gjkPDgcdQTT2X8yD2RocYhbMKoTBWSpt/LLMIcjBLAM85xjkilqw+rmOEOSVzP02hmcA5oRjrnHYYcaFx3NUgOUQiHHiubmIFB3lirC58ljfOmQPyH3A+xoLY2i8M3vzs8J1LF2MLXwD8hbcCQUHld5+SUAGVKa6DSiKSR94s27uZeiA+n7+xIARBTjY84jrPkJx9sAeSF+O+zVzPYevk4E77oFR78CJDM8PXBbISaUduHzXiyOvh41ShVCoTJARB1zR93tyawazq14zuh5qqHkegUNjK+dmQG6uGvZmGTKd+XmlccLXmeEhCVb88ehco88EuK7GmX24UjwSbBZR/K7iWbJ1HDWBOOuEPSUnYLsqGrB7kvtzLvO9ymSuvGQz8xrMWYuzSx6PFd0sGV9amvZ1ksfEz6BaIq8K61O01GRGTV5PmDszm+lVuOIH6crgAZNswiBMFwHKJisw9lmijz6kvqG7MCLHKiqLkBqWzimVBrQaTmNd5hcY8JQFJ2rylLAp/4TkoUqD53a17MdxJTZjTNsitpuOEjjpdSZCOWYRBAlzS3dLL7fIkETX66WsIiUCwElZu2gGgwO4OJgUhj5Jo0smgnEwK/AF0qmTZjqpN0THgCJk/5KqktghwGU1OXhYZf+ivYwgxYK+gVJ1LBKvyfQo7hQyRTMCZ8abk8TQMM3+rYjYMO6MOp746Fa1rZGQB3hJYzz4jwPFJ9fS9mxEx"
`endif