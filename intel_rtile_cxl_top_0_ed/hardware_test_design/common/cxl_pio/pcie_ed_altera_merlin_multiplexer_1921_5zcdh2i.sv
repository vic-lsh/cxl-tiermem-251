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
//   output_name:         pcie_ed_altera_merlin_multiplexer_1921_5zcdh2i
//   NUM_INPUTS:          1
//   ARBITRATION_SHARES:  1
//   ARBITRATION_SCHEME   "no-arb"
//   PIPELINE_ARB:        0
//   PKT_TRANS_LOCK:      1220 (arbitration locking enabled)
//   ST_DATA_W:           1267
//   ST_CHANNEL_W:        1
// ------------------------------------------

module pcie_ed_altera_merlin_multiplexer_1921_5zcdh2i
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
    localparam PIPELINE_ARB     = 0;
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
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5IinNTg0t7ePNjcwgNKXJy5P3tgf2FM+thcmi+3kJwxkNynonDODlPxIo3FJu/XVNEs1aQo56cS4YqWpP9vBEOvtwt3oZ/Ypr/ALia+ziiTp1w0utFkf5JwiaDmvXMLc3n6OCM1CJsDLBxgJP/2JJE98Rj14Tz9T1lEmeIasxFtpyViqJXBh7EqMFqRvnWARn4BJeRYR5D4tQkGqDdYFkP4CG2ulnnznYlK+gMllq5yCLWupt1bfT2WAmJbA33cb1sW59Wf4W7lTWEE2hQqP7KATcMC8T+R6fmPzAnkj/bIC6tINbMmrgcMyID7F5T0VD5ciZ2OklmZx6ONa3YMO+2Q4ZcsgQ7bQhcszlNRzTu9HpQSKhoEsZBCi5/ZEswmv6o7/12bBphf1Ec5CnvXP9UUQr28DMCGAS4ArSLSv9A/WbmeyOEvXNRb07McgsENaiQ5gsMgmRoZCncnSU7FDt+HTIvQgLpg8NBw20pIEKvj1JRdFAHN/14m3rres8crzFvmx6QymCjUpt1eJNWmRf9wvMgd08iS21pywVKxnslkqiSwmEdYHjCodU5XIBdMGVbNTimXoRrcHTTUQV28O6NZqV9DXVf7vDL1AKbGMRVNf/oZzeRsDQJkk+21sbaBQ47QEPZRK09KcZ7ktyf6+331iOeVH697FOG/VOKXuriUOYPAVqBWI0/0OKsiUmkZprvSh7q2YG+hLj8aBKVW20GHVKuobFR+sJl7fMI924WXCsaT0u3TIU6BGhmae/2u7BiSRo/F2uiE6pzDygCC2HgS"
`endif