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
//
///////////////////////////////////////////////////////////////////////

package clst_pkg;

// @@copy for common_afu_pkg@@start
    typedef enum logic [3:0] {
        CLSTSTATE_I       = 4'h0,
        CLSTSTATE_S       = 4'h1,
        CLSTSTATE_E       = 4'h2,
        CLSTSTATE_M       = 4'h3,
        CLSTSTATE_IMPRECISE_IS = 4'h4,
        CLSTSTATE_UNKNOWN      = 4'h5,
        CLSTSTATE_RSVD_06 = 4'h6,
        CLSTSTATE_RSVD_07 = 4'h7,
        CLSTSTATE_RSVD_08 = 4'h8,
        CLSTSTATE_RSVD_09 = 4'h9,
        CLSTSTATE_RSVD_10 = 4'hA,
        CLSTSTATE_RSVD_11 = 4'hB,
        CLSTSTATE_RSVD_12 = 4'hC,
        CLSTSTATE_RSVD_13 = 4'hD,
        CLSTSTATE_RSVD_14 = 4'hE,
        CLSTSTATE_ILLEGAL = 4'hF
    } clst_state_e;

    typedef enum logic {
        CLSTCHGSRC_CAFU = 1'b0,
        CLSTCHGSRC_HOST = 1'b1
    } clst_chg_src_e;

    typedef struct packed {
        logic [2:0]            Rsvd;
        clst_chg_src_e         ChgSrc;
        clst_state_e           HostFinalState;
        clst_state_e           HostOrigState;
        clst_state_e           IPFinalState;
        clst_state_e           IPOrigState;
        logic [51:0]  Addr;
    } clst_attr_t;
// @@copy for common_afu_pkg@@end

endpackage: clst_pkg
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "n2XcJZ07Jm43bx1M8XpHia2ruIzazHuijI1yijoflqOn7I/5ECRpX3AD2MuWI5gSNjn593jzAp73l+NpO4Wrk5ssiF/2ttaG2OQ7u8j8+jpYQumLH/ciLj4KnC8p5auDB0Zgl8gK99Xa+X0ZewtdgT1TEeLXUOnfCjsVxW1xka9RcOZ7tdPYJf89VeOZZmQQFcqSxR9TmZYgKGUEf0/uWMNAbhWF/sjWgA+Staf8XvwxmDsPkanRttZzO6SKczQCLJQwKbCaQ0xmvVOaeuRwTZm+CaElzpM8zb/82NdNyca8/cWsXpZEG/V7p4sxvfmFida8gUHRxL0zx3rtNCbSixo8NgNn6xYWYgR8ay8IywR6J+xpqBsr2sxSaIg2pG5mEKWHA0LNvtn7uh01dXyiMp6MC/QdfY9mWjymkQwRl1ORn/6ItlgziuPkjEFvLrCtjA0LQwDlUzIB/6KE7IjjE0zykA1JOgt38amqEBJNkRWUqDT3EXvwXPZojEw+qf5X8BkYTY64CU7Znc2heLluZONoIJ1IkWxkKGygVF1bejrmOZCdrpTvfSUkG/qKayE5wFEPK6e3Dw07wuZVvRggKeBcSzoY6GmOeNZ1ekb614zIHnYn7Qqw20hX4Q3SXLpRWBhdZVQf+SCr1+tbIFOfjQC3Em6LREMbjwqdRMXM1pGZnN+R/07aEupd5IMxBEEt6I07b6fwo23sCq9PJR/3cegUE7hxrho03qxQ9LrkNKHJ228bBw5wswz72vbe+XW5NAw6QJ/DyR8wQNyDl2vi3rfknA1/SkUDoDXDUux/wu2+XOsDvFbGql3wHUf4gA9wytMpst2V4uh02mHo6R2W8oxmIzEZ/9K6gHwg78E9clCr5pglR9KOhZjBSkQq9VgBpRZLXmcTGjGLU+8FtNZ/CvtBMx/ur8Y4DHdF9DoLnOK0oKMUm3xphD52h55t8xmS8AI4yKezoMkIvXF61dcPPMc7V094vlI4fbI5SHTuT3ej1MejGNOXoVVFDxif598F"
`endif