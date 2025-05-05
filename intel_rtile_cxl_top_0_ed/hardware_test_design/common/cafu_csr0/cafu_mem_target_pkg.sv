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


// Copyright 2023 Intel Corporation.
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
//  No license under any patent, copyright, trade secret or other intellectual
//  property right is granted to or conferred upon you by disclosure or
//  delivery of the Materials, either expressly, by implication, inducement,
//  estoppel or otherwise. Any license under such intellectual property rights
//  must be express and approved by Intel in writing.
//
//------------------------------------------------------------------------------
//
package cafu_mem_target_pkg;
    
    localparam  CL_ADDR_MSB = 51;
    localparam  CL_ADDR_LSB = 6;    
    
    typedef logic [CL_ADDR_MSB:CL_ADDR_LSB]        Cl_Addr_t;
    
    typedef struct packed {
        logic [CL_ADDR_MSB:28]  Addr;
        logic [CL_ADDR_MSB:28]  Size;
        logic [3:0]             IW;
        logic [3:0]             IG;
    }  hdm_mem_base_t;  //used for address decode in fabric_slice 
    
    typedef enum logic {
       TARGET_HOST_MEM     = 1'b0,
       TARGET_DEV_MEM      = 1'b1
    } fabric_target_dcd_e;    
    
    function automatic fabric_target_dcd_e fabric_target_dcd_f;
        input Cl_Addr_t        Addr;
        input hdm_mem_base_t   Base;
    
        localparam ADDRMATCH1  = 'h0_0000_0004;
        localparam ADDRMATCH2  = 'h0_0000_0005;
    
        logic [CL_ADDR_MSB:28]      shifted_addr;
    
        //shifted_addr = Addr << 22; //since CL Addr, shift 22 instead of 28
        shifted_addr = Addr[CL_ADDR_MSB:28];
    
        if ( ( shifted_addr[CL_ADDR_MSB:28] <   (Base.Addr + Base.Size) )
           & ( shifted_addr[CL_ADDR_MSB:28] >=  Base.Addr )
           )
        begin
            fabric_target_dcd_f = TARGET_DEV_MEM;
        end
        else begin
            fabric_target_dcd_f = TARGET_HOST_MEM;
        end
    
    endfunction    
    

endpackage
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4Ozjk6yswn2eaGzjQyogyqK0y0lRN6hkfD8PjMkH0v+8SlMc1wIugo9tO42BndpYED4vvXg8dHvAg3qEfUfqVJxzqwSRZ9q42aX7VM/iBCWuEusrlZ9bMMMV0bWdDGswbZ8S7qfmjPcNNWwsbgfUrtslw0Cf4anXCB9XfK3Zg8crY8mXMBA771eJ+T94Bm4S2rGxjP2+EdFIlSqyfbMtxmNtw5vXoIQdCpkeMBq2wP2SZ+qLW7EbOVe8P4Mf2GvHNhspsXAIVzAKK1jRP1KZuu5K9N3jhHXExkp52qSb47g/p4db4lqSLOB0r1h45uSCbTziOMy6AoPlrKsXKd+VnW/HVW/83NXn4zQ8pjpbKFr+OsOmG7zmO0HxH5qIuEiLrgmSbxpIisGA8nByErpifFu7mfdM3ARYdQFM3WHu0p3yF1oZeQ8qrf+GUQIc7OtxMVyizz50+pS4sydi09NNQDJ2RzNDENd+czURgzofIT5++nU+RF+zno2RnJRn9ssRM/NcOKM31oNh5M48ck4k3EyRfcUqK/NgNoFrwz6/TqN34fBuR+U75q18sgsJDhLBr3+fQQlt/qJNy3MFNJ2WigLSHdhnutkTRFMZZeWz52tzl5/FSc5GOw8FVd7yf8V8WceoevCm8aI0YhoyDGWvoF/rifxbsfwpWCnpe9zBVe/y+O+4hbIDK8swfTmyJWCKiPSaeOAYwMbYtacGW4hs5AB48yQxuwy4Ll5Rz3LlEYAwQjjvSvTlJfnedzDS9BdXbjiprDvr8436xcv/3BnItbJ"
`endif