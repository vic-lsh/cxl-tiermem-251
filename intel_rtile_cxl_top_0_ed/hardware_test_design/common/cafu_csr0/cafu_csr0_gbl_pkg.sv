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


// Copyright 2024 Intel Corporation.
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
//-------------------------------------------------------------------------
//  Global Defines
// ------------------------------------------------------------------------
//
package cafu_csr0_gbl_pkg;

/* This define configures the design for the design validation environment of a single bbs slice.
   This mode is not intended for customer use and may result in unexpected behaviour if set.
 */
//`define INTEL_ONLY_CXLIPDEV  1


endpackage : cafu_csr0_gbl_pkg
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "JR9cM/TIGZ5bYvz0oDMc1wmyIMti8wIPoYYthhwhFEU251bHCqbN3TLTjyqI9pi446kPCBZST5Wme4Lj4a2oyXgpo05hq8tqeTT0DnKpUTQPQLBi1kxNX1Dmb/atW4lPtlVVMre2c1Z93XtG9/7fVrQOXerUVXQR+/YiRsYYtItbCkgOw2LBUO1A++on6zfk0rRPOEwxgFdLF7FQQiTewmN3sZ2SXvtVhJ2eBWTAi4OmaCyQ+rVD9U7zJPFYnGgRB+KxlKCtlqCWmDUKjKRmdFE8LYHpZDV7K3Ecx/u7szA4mXikrSJTET5uwNI8KVCm19ielHuGBcwNYfFFP2uqd3D8y0lSBgAS8kLdRnHdBWZ70abz6hB28HP/RkI3Ydicgcv4FAtbgBhu8xzLjvhosXfhOfxaTN/CpeVF4muasNTEho/7/5IQXkkOI9CKTvYQ5jT7OCHatm4dqU9Zhn6VcK4fAqm88i1ggTDvn0tJid4IW02y430EZYBdZa48crBmoOTgggF5vFNagb+yZIkmFDHlwgsnHvcbSHjrQumfa8OjLf2BwQzaI46DBqRUgkeyQDCoX/tSFqHkjfrFBmzaEbYsQg9IQ3oWaKOuYORHRShNlB9Z5X6+b/pe38XkEzyf/ehWNIjLLXPvhhD+fYcm1alIq+x/N/fzBddpVhgjM1CYeUIrCdhrFbF1Z2oQcl5DeDB/1btJo9RNtZ5s1Lv7gPxn/lYRi03G+nCTICIhkqdRVD4s6BX0T2eZODMseec5WpnqIcAp6rb39rklEDhAS0O1O5bl4rs6QQxeZR443bWHq7p3psaSHqkeAdrRTrvkstJ3cUB6tS96t5S8un2cKbbF57DNpnAlZjMjMEsrV46NUOrYWDFxdqgJERriTq0Xq+z7kX//OMIbM0fFr5kl7nbTM5YZBIUbFsE1V5F5TDZz+rZmg3FfHQCWOy6KWByS5v35YR2gmy4NVeIAyb+YFX/bPZLvRFhiBH8OK8tueChMNBJfIBCMOQXUCJIdWBQK"
`endif