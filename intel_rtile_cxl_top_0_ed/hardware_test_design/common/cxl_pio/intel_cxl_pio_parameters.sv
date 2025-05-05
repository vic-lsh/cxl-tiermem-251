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


package intel_cxl_pio_parameters;
    parameter ENABLE_ONLY_DEFAULT_CONFIG= 0;
    parameter ENABLE_ONLY_PIO           = 0;
    parameter ENABLE_BOTH_DEFAULT_CONFIG_PIO = 1;
    parameter PFNUM_WIDTH               = 3;
    parameter VFNUM_WIDTH               = 12;
    parameter DATA_WIDTH                = 1024;
    parameter BAM_DATAWIDTH             = DATA_WIDTH;
    parameter DEVICE_FAMILY             = "Agilex";
    //parameter CXL_IO_DWIDTH = 256; // Data width for each channel
    //parameter CXL_IO_PWIDTH = 32;  // Prefix Width
    //parameter CXL_IO_CHWIDTH = 1;  // Prefix Width

endpackage
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5IbMqbRCF8P5u/IbunBSOM1p7p0VcMogT8J0Rv0GgkVoXQ/jNtXS5UjcIO+iL0Q9e4tVaJlK1pVBkFI/Dhzd/tfNS0r54MaiLz4p31UwddlNJW5eNGAtNYfSlZzILhGwvqls8QzQsPlj0pzACLERlI01/scKBQDBYFeQKA11i2FgxAylC/gPjQQqFrgqrgRuv4AllMO2syAwQ1hg0nYECYi5OHLAVky0fSNW5rtGmlu/pJOywP0SQ8xFTsUDTuyGPsIOLB3VR6/oZpdvALicc3iLOtFmiSz9tx3f54jTNmwIOVtbQy6qbf2SLTA7XXlkdz8j9hfLQ+QAgmeys7WQIpCpQW6i9e6jaFhfc6eCHnMfNMr3QwBI73Z1e++nBZv9KR8kuh9C1Q5MvELZpzzOuxwHEOlz8OPBNb4qXpUc7dEjC6gV++Flkm2Agr4AAmP/GZA4kUCnnOGUdxdjKWtODHOI2ymF/qdocLE1udl3LOr9cZZP46vYEjPb5OOL3bVC8GWeY6Xi6WCu6paMplPMMvHdBlYg6HW+gAH6DIw+jkQpGik4lgI98Ei8kLr88W+u38fg+T8EPAUUgvoDvPd0bvQXprJbGoaQbhxA1VONam8noPJlbcOyL9xphf/J02PHvpkL46V+QzzUGOZ+AKwkw8xcenmsfYRryibYwkDaQt013YhATs5GyTZLL1jDrbYNvQ5cFErZulyPFmYpV5tx0y46/BgO2lfbEpKIF3md+eiAZUf9whvi8TSuDNTpEQL3rz+qbmEmcYpH542KK5AAIHU"
`endif