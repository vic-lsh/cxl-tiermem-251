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

module cxl_io_build_version (data_out);
    output [31:0] data_out;
    assign data_out[31] = 1'h1; //1 - debug, 0 - release
    assign data_out[30:0] = 30'h00000000;
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ky/HEfdVXkJAw1qMYWhWXW5O5RVi8yRIreK8r8hZD97Ilhu7VLS50Z+wuk0UN0KGgflyuM5gGtMcBlZMQB7qbIhtCiQJg4xBbyYYY3aiK4Zfduus5p/ut+W/Gz3L9/1EQDLIszy1d28qXYjoOaB6X6cYmtKuEBxV6b2XzZ90KDFtzMUB9zMWbVFL8kyZUvgTo+LqB4p4339N1k5GY9t5xfvs+tkq4nDgjmRapb8C9Y565eVwoTqU6iJ3uxoC4L7Z9vtULz5iJD5TjXm3YpCi8WhIrSMhOAa1QBfqDbELHq6+l0pes0NGMYpgOuG2w6YDJWZcNH0o3HX+ej6Xi6T01cUpAi9aLiVZ96ltoYgX/x/KiIlwQntuSCgpoIScx5NAODnfM76JH31xlGBOWm9OHXvLdqSBhru3DlQxBb/LNv3ZzPaDhOGpxoXUq1tLRNAgkFSggaDB0fiXJRQWsr0a8/h3kpYRpqhJaD0oEi6/A0B5B4fm3ruH+UBDAT0Y4+umJbUbNDOXSQa2iETFOSuiKcKnfBhBGWWe1kM5OPB8pmg/El8VwiktX8X9094L+Cl42lM3/v0gp6anNh5P8GK51mmCxmERTj6ZyhBQXvpHh3e708ACkyHiJV/ynzQD+QVm8trmFhsFeqab4PYHVOlDP2/IrfBUHKKO1e5FC1geeVX1pJrPPSZO5ar8NiVV5S9ErbCjZvtlb0KOTnTLpz+b7J+yUiXf0X6tQRa2602oZTEZXJBaGgXv08LAnXwoIo23nOGgkKJutS/paM/wZf5njD5pNcdR+gGgUerHYPRlI6bufqYINvzzvN36w4GIw38RXylOHj37i1CaHhFLiR8n8/FTddkud6iJWPiRkN/k2FKcqwbDHuk24bTfPbEfUBKeVhOu/jUlW9CeSf4Is46EASKUewRBqN5+inWOrGlHOpFRMkBWloH5uvYbBrEB5nKjWCo0htZ7o7OeU0owbkDbrxUm5WWYn+as4YxJxVptDFWvNAe+X4QT4wtY+q7TUgDr"
`endif