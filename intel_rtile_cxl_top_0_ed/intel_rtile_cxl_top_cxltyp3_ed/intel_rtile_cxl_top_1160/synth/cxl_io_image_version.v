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

module cxl_io_image_version (data_out);
    output [31:0] data_out;
    assign data_out[15:0] = 16'h4202; //CXL IO version
    assign data_out[31:16] = 16'h5191;
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "ky/HEfdVXkJAw1qMYWhWXW5O5RVi8yRIreK8r8hZD97Ilhu7VLS50Z+wuk0UN0KGgflyuM5gGtMcBlZMQB7qbIhtCiQJg4xBbyYYY3aiK4Zfduus5p/ut+W/Gz3L9/1EQDLIszy1d28qXYjoOaB6X6cYmtKuEBxV6b2XzZ90KDFtzMUB9zMWbVFL8kyZUvgTo+LqB4p4339N1k5GY9t5xfvs+tkq4nDgjmRapb8C9Y7DzWt3Ey+sGx9KfpSLibMdl+GQ0R3r2iuoRg7l0qPFybVVQvbJ423qIHtyzbtnpfUjlQE0vQkXKyPBweqMorZMUtTNR0XMSiveMf9VI5fwZ2F/4s1LLW3e/X9NWzbdls4aft8oxsWtG0wFMc5mDKje1/Vsh4jM5ibImrXNl8Gk8nEJDGZUQ66sWB2KTwrY9cemM4/42rBWEW7sDLhoMr2GaIQsOIz+91G/QVKT9QL+gUl2gLnXn1fOzmYhjsYWmI5w4yQBLt44rpxb/+ESZPRqySLyGo47uG2FrJ3mxpaN1nat0u3dMTchdc6o49yxEie+qg0Uha+rxplg0FoGevO8DnK68kLBJF6rPC0CDIw7+3LJTtPevXaLSF3HIdX8boqCNARM0e+djs3meLe2yYJdGJoxZm77PpO4QDhHAvRfWPf+1k0CQZGDm01THrrNNSt3Ta99GzzZzTihy8o1FnwXMLR1+n3H4+wa1JtrRbOCMOeDvS/ykd/70L53Y0dovgQo0VS9dYER0RkUfIOtJuURoi7bedulN+Wup2uTPyky/4GJGLMOGKTujTFsKUnk4CCgqYQ8gTEAEZo5eD6nYlL0c7M/I4BMJwDmKvh7ZFZNnGXHgTSBwntH2/DVh4p4C0t8RcuQHH4+wQ/CEKcHiu5KD7XB5ylI0bO+FR2YiSpkWCesv7Z7HXYe7ilJj6Lq2WO9q6LpJZFelLZhmNc0DpBtCJ+QtJf/NiMKGHXZWc3LXhB9+Uhzg4CyCS4Q0CDyeEKm6FX07j7DXL2NNjoNfZ9H"
`endif
