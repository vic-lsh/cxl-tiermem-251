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

module mc_single_chan_ecc_req
  import ddr_mc_top_common_pkg::*;
  import hdm_axi_if_pkg::*;
#(
  parameter ALTECC_DATAWORD_WIDTH = 64,
  parameter ALTECC_CODEWORD_WIDTH = 72,
  parameter ALTECC_INST_NUMBER    = 8,
  parameter MC_ECC_ENC_LATENCY    = 0, // supported option 0 and 1; (latency in emif_usr_clk cycles)
  parameter MC_ECC_DEC_LATENCY    = 1, // supported option 1 and 2; (latency in emif_usr_clk cycles)

  localparam ECCENC_DATA_WIDTH     = ALTECC_INST_NUMBER * ALTECC_CODEWORD_WIDTH,
  localparam MEM_SYMBOL_WIDTH      = 8,
  localparam MEM_BE_WIDTH          = ECCENC_DATA_WIDTH / MEM_SYMBOL_WIDTH
 )
(
  input logic emifclk,                         // EMIF User Clock
  input logic emifresetn,                      // EMIF reset
  input logic emif_avmm_1_axi_0,
 
  /* signals to/from mc_rmw_block
  */
  input logic from_mcrmw_reqfifo_empty_emifclk,
  
  input ddr_mc_top_common_pkg::t_reqfifo_data_postRMW_preECC     from_mcrmw_new_req_emifclk,
 
  output logic to_mcrmw_mem_ready_emifclk,
 
  /* signals to/from emif-avmm-FSM
  */
  input ddr_mc_top_common_pkg::t_emif_fsm_cntrl_to_ecc      from_fsm_avmm_cntrl_emifclk,
  
  output ddr_mc_top_common_pkg::t_reqfifo_data_post_ecc_avmm     to_fsm_avmm_new_req_emifclk,
 
  /* signals to/from emif-aaxi4-FSM
  */
  input ddr_mc_top_common_pkg::t_emif_fsm_cntrl_to_ecc      from_fsm_axi4_cntrl_emifclk,
  
  output logic to_fsm_axi4_reqfifo_empty_emifclk,
  
  output ddr_mc_top_common_pkg::t_reqfifo_data_post_ecc_axi     to_fsm_axi4_new_req_emifclk
);

// ================================================================================================
/* altecc_enc_* -> encode (swivel) ecc with data
   altecc_dec_* -> unswivel ecc from data and determine any errors
*/
logic [ECCENC_DATA_WIDTH-1:0] writedata_with_ecc_encoded;

generate for( genvar alteccCount = 0 ; alteccCount < ddr_mc_top_common_pkg::MCTOP_ALTECC_INST_NUMBER ; alteccCount=alteccCount+1 )
begin : gen_ALTECC_ENC
  
  altecc_enc_latency0   altecc_enc_latency0_inst
  (
     .data ( from_mcrmw_new_req_emifclk.writedata[alteccCount*ALTECC_DATAWORD_WIDTH +: ALTECC_DATAWORD_WIDTH] ),
     .q    (           writedata_with_ecc_encoded[alteccCount*ALTECC_CODEWORD_WIDTH +: ALTECC_CODEWORD_WIDTH] )
  );
  
end
endgenerate

// ================================================================================================
// == invert/corrupt 2 ECC parity bits in case from_mcrmw_write_poison is set
// This will lead to err_fatal being set on decoder side and hence to from_mcecc_dec_memout_read_poison_mclk bit set.
// Note cuorrupting ECC parity bits instead of data bits has benefit of keeping data as is.
// Note that it is not recommended to invert/corrupt MSB ECC parity bit as it has longest logic depth
// (depends on all data bits and all other ECC parity bits) ==
logic [ECCENC_DATA_WIDTH-1:0] writedata_with_ecc_encoded_n_poison;

generate for(genvar i=0 ; i < ddr_mc_top_common_pkg::MCTOP_ALTECC_INST_NUMBER ; i=i+1) 
begin : gen_ECC_ENC_INST

  always_comb
  begin
    writedata_with_ecc_encoded_n_poison[i*ALTECC_CODEWORD_WIDTH +: ALTECC_CODEWORD_WIDTH]
           = writedata_with_ecc_encoded[i*ALTECC_CODEWORD_WIDTH +: ALTECC_CODEWORD_WIDTH];

    if( from_mcrmw_new_req_emifclk.write_poison )
	  begin
	    writedata_with_ecc_encoded_n_poison[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-1)] = !writedata_with_ecc_encoded[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-1)];
	    writedata_with_ecc_encoded_n_poison[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)] = !writedata_with_ecc_encoded[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)];
    end
    else if( i == 0 ) //RAS injection, single error injection so always use data group0 for simplicity (e.g. i=0)
    begin
      if( from_mcrmw_new_req_emifclk.write_ras_dbe )
	    begin
	      writedata_with_ecc_encoded_n_poison[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-1)] = !writedata_with_ecc_encoded[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-1)];
	      writedata_with_ecc_encoded_n_poison[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)] = !writedata_with_ecc_encoded[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)];
	    end
	    else if( from_mcrmw_new_req_emifclk.write_ras_sbe ) 
	    begin
	      writedata_with_ecc_encoded_n_poison[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)] = !writedata_with_ecc_encoded[((((i+1)*ALTECC_CODEWORD_WIDTH)-1)-2)];
	    end
	  end
  end
  
end
endgenerate

// ================================================================================================
/* clock/pipeline the requests here if (MC_ECC_ENC_LATENCY == 1)
     and select between emif-avmm or emif-axi4 path for downstream FSM
*/
generate if( MC_ECC_ENC_LATENCY == 1 )
begin : gen_ECC_ENC_LATENCY_1

  logic [ddr_mc_top_common_pkg::MCTOP_EMIF_AMM_DATA_WIDTH-1:0] to_emif_avmm_writedata_comb;
  logic [ddr_mc_top_common_pkg::MCTOP_MEMCNTRL_ADDR_WIDTH-1:0] to_emif_avmm_address_comb;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0]    to_emif_avmm_wr_id_comb;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0]    to_emif_avmm_rd_id_comb;
  logic                                                        to_emif_avmm_write_valid_comb;
  logic                                                        to_emif_avmm_read_valid_comb;

  logic [ddr_mc_top_common_pkg::MCTOP_EMIF_AMM_DATA_WIDTH-1:0] to_emif_avmm_writedata_emifclk;
  logic [ddr_mc_top_common_pkg::MCTOP_MEMCNTRL_ADDR_WIDTH-1:0] to_emif_avmm_address_emifclk;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0]    to_emif_avmm_wr_id_emifclk;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0]    to_emif_avmm_rd_id_emifclk;
  logic                                                        to_emif_avmm_write_valid_emifclk;
  logic                                                        to_emif_avmm_read_valid_emifclk;

  logic [ddr_mc_top_common_pkg::MCTOP_MC_HA_DP_DATA_WIDTH-1:0] to_emif_axi4_writedata_comb;
  logic [ddr_mc_top_common_pkg::MCTOP_MEMCNTRL_ADDR_WIDTH-1:0] to_emif_axi4_address_comb;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0]    to_emif_axi4_wr_id_comb;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0]    to_emif_axi4_rd_id_comb;
  logic                                                        to_emif_axi4_write_valid_comb;
  logic                                                        to_emif_axi4_read_valid_comb;
  hdm_axi_if_pkg::t_hdm_axi_wuser                              to_emif_axi4_wuser_ecc_comb;

  logic [ddr_mc_top_common_pkg::MCTOP_MC_HA_DP_DATA_WIDTH-1:0] to_emif_axi4_writedata_emifclk;
  logic [ddr_mc_top_common_pkg::MCTOP_MEMCNTRL_ADDR_WIDTH-1:0] to_emif_axi4_address_emifclk;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_WAC_ID_BW-1:0]    to_emif_axi4_wr_id_emifclk;
  logic [ddr_mc_top_common_pkg::MC_LOCAL_AXI_RAC_ID_BW-1:0]    to_emif_axi4_rd_id_emifclk;
  logic                                                        to_emif_axi4_write_valid_emifclk;
  logic                                                        to_emif_axi4_read_valid_emifclk;
  hdm_axi_if_pkg::t_hdm_axi_wuser                              to_emif_axi4_wuser_ecc_emifclk;

  logic to_fsm_axi4_reqfifo_empty_comb;

  // reqfifo empty to emif-axi-fsm, but not needed for emif-avmm-fsm
  assign to_fsm_axi4_reqfifo_empty_comb = emif_avmm_1_axi_0
                                          ? 1'b1
                                          : from_fsm_axi4_cntrl_emifclk.mem_ready
                                            ? from_mcrmw_reqfifo_empty_emifclk
                                            : to_fsm_axi4_reqfifo_empty_emifclk;
											
  assign to_emif_axi4_read_valid_comb = emif_avmm_1_axi_0
                                        ? 1'b0
                                        : (from_fsm_axi4_cntrl_emifclk.mem_ready & from_mcrmw_new_req_emifclk.read )
                                          ? 1'b1
                                          : from_fsm_axi4_cntrl_emifclk.clear_read_valid
                                            ? 1'b0
                                            : to_emif_axi4_read_valid_emifclk;
											
  assign to_emif_avmm_read_valid_comb = ~emif_avmm_1_axi_0
                                        ? 1'b0
                                        : (from_fsm_avmm_cntrl_emifclk.mem_ready & from_mcrmw_new_req_emifclk.read)
                                          ? 1'b1
                                          : from_fsm_avmm_cntrl_emifclk.clear_read_valid
                                            ? 1'b0
                                            : to_emif_avmm_read_valid_emifclk;
											
  assign to_emif_axi4_write_valid_comb = emif_avmm_1_axi_0
                                         ? 1'b0
                                         : (from_fsm_axi4_cntrl_emifclk.mem_ready & from_mcrmw_new_req_emifclk.write)
                                           ? 1'b1
                                           : from_fsm_axi4_cntrl_emifclk.clear_write_valid
                                             ? 1'b0
                                             : to_emif_axi4_write_valid_emifclk;

  assign to_emif_avmm_write_valid_comb = ~emif_avmm_1_axi_0
                                         ? 1'b0
                                         : (from_fsm_avmm_cntrl_emifclk.mem_ready & from_mcrmw_new_req_emifclk.write)
                                           ? 1'b1
                                           : from_fsm_avmm_cntrl_emifclk.clear_write_valid
                                             ? 1'b0
                                             : to_emif_avmm_write_valid_emifclk;									  

  assign to_emif_axi4_wr_id_comb = emif_avmm_1_axi_0
                                   ? '0
                                   : from_fsm_axi4_cntrl_emifclk.mem_ready
                                     ? from_mcrmw_new_req_emifclk.wr_id
                                     : to_emif_axi4_wr_id_emifclk;

  assign to_emif_avmm_wr_id_comb = ~emif_avmm_1_axi_0
                                   ? '0
                                   : from_fsm_avmm_cntrl_emifclk.mem_ready
                                     ? from_mcrmw_new_req_emifclk.wr_id
                                     : to_emif_avmm_wr_id_emifclk;
									 
  assign to_emif_axi4_rd_id_comb = emif_avmm_1_axi_0
                                   ? '0
                                   : from_fsm_axi4_cntrl_emifclk.mem_ready
                                     ? from_mcrmw_new_req_emifclk.rd_id
                                     : to_emif_axi4_rd_id_emifclk;
										  
  assign to_emif_avmm_rd_id_comb = ~emif_avmm_1_axi_0
                                   ? '0
                                   : from_fsm_avmm_cntrl_emifclk.mem_ready
                                     ? from_mcrmw_new_req_emifclk.rd_id
                                     : to_emif_avmm_rd_id_emifclk;
									 
  assign to_emif_axi4_address_comb = emif_avmm_1_axi_0
                                     ? '0
                                     : from_fsm_axi4_cntrl_emifclk.mem_ready
                                       ? from_mcrmw_new_req_emifclk.address
                                       : to_emif_axi4_address_emifclk;

  assign to_emif_avmm_address_comb = ~emif_avmm_1_axi_0
                                     ? '0
                                     : from_fsm_avmm_cntrl_emifclk.mem_ready
                                       ? from_mcrmw_new_req_emifclk.address
                                       : to_emif_avmm_address_emifclk;
									 
  // keep data and ecc encoded together for avmm
  assign to_emif_avmm_writedata_comb = ~emif_avmm_1_axi_0
                                       ? '0
									   : from_fsm_avmm_cntrl_emifclk.mem_ready
									     ? writedata_with_ecc_encoded_n_poison
									     : to_emif_avmm_writedata_emifclk;
									 
  // unswivel the ecc and data for AXI								 
  assign to_emif_axi4_writedata_comb = emif_avmm_1_axi_0
                                       ? '0
                                       : from_fsm_axi4_cntrl_emifclk.mem_ready
                                         ? {writedata_with_ecc_encoded_n_poison[567:504],
                                            writedata_with_ecc_encoded_n_poison[495:432],
                                            writedata_with_ecc_encoded_n_poison[423:360],
                                            writedata_with_ecc_encoded_n_poison[351:288],
		                                    writedata_with_ecc_encoded_n_poison[279:216],
		                                    writedata_with_ecc_encoded_n_poison[207:144],
		                                    writedata_with_ecc_encoded_n_poison[135:72],
		                                    writedata_with_ecc_encoded_n_poison[63:0]}
                                         : to_emif_axi4_writedata_emifclk;

  // unswivel the ecc and data for AXI	
  assign to_emif_axi4_wuser_ecc_comb = emif_avmm_1_axi_0
                                       ? '0
                                       : from_fsm_axi4_cntrl_emifclk.mem_ready
                                         ? {writedata_with_ecc_encoded_n_poison[575:568],
		                                    writedata_with_ecc_encoded_n_poison[503:496],
		                                    writedata_with_ecc_encoded_n_poison[431:424],
		                                    writedata_with_ecc_encoded_n_poison[359:352],
		                                    writedata_with_ecc_encoded_n_poison[287:280],
		                                    writedata_with_ecc_encoded_n_poison[215:208],
		                                    writedata_with_ecc_encoded_n_poison[143:136],
		                                    writedata_with_ecc_encoded_n_poison[71:64]}
									     : to_emif_axi4_wuser_ecc_emifclk;

  always_ff @( posedge emifclk )
  begin
    to_fsm_axi4_reqfifo_empty_emifclk <= ~emifresetn ? 1'b0 : to_fsm_axi4_reqfifo_empty_comb;  
    to_emif_axi4_read_valid_emifclk   <= ~emifresetn ? 1'b0 : to_emif_axi4_read_valid_comb;
    to_emif_axi4_write_valid_emifclk  <= ~emifresetn ? 1'b0 : to_emif_axi4_write_valid_comb;	
	
	to_emif_axi4_wr_id_emifclk     <= to_emif_axi4_wr_id_comb;
	to_emif_axi4_rd_id_emifclk     <= to_emif_axi4_rd_id_comb;									  
	to_emif_axi4_address_emifclk   <= to_emif_axi4_address_comb;	
	to_emif_axi4_writedata_emifclk <= to_emif_axi4_writedata_comb;
    to_emif_axi4_wuser_ecc_emifclk <= to_emif_axi4_wuser_ecc_comb;

    to_emif_avmm_read_valid_emifclk  <= ~emifresetn ? 1'b0 : to_emif_avmm_read_valid_comb;
    to_emif_avmm_write_valid_emifclk <= ~emifresetn ? 1'b0 : to_emif_avmm_write_valid_comb;	
	
	to_emif_avmm_wr_id_emifclk     <= to_emif_avmm_wr_id_comb;
	to_emif_avmm_rd_id_emifclk     <= to_emif_avmm_rd_id_comb;
	to_emif_avmm_address_emifclk   <= to_emif_avmm_address_comb;	
	to_emif_avmm_writedata_emifclk <= to_emif_avmm_writedata_comb;
  end

  always_comb
  begin
    to_fsm_axi4_new_req_emifclk.write      = to_emif_axi4_write_valid_emifclk;
    to_fsm_axi4_new_req_emifclk.read       = to_emif_axi4_read_valid_emifclk;
    to_fsm_axi4_new_req_emifclk.wr_id      = to_emif_axi4_wr_id_emifclk;
    to_fsm_axi4_new_req_emifclk.rd_id      = to_emif_axi4_rd_id_emifclk;
    to_fsm_axi4_new_req_emifclk.address    = to_emif_axi4_address_emifclk;
    to_fsm_axi4_new_req_emifclk.writedata  = to_emif_axi4_writedata_emifclk;
    to_fsm_axi4_new_req_emifclk.wuser_ecc  = to_emif_axi4_wuser_ecc_emifclk;
    
    to_fsm_avmm_new_req_emifclk.write      = to_emif_avmm_write_valid_emifclk;
    to_fsm_avmm_new_req_emifclk.read       = to_emif_avmm_read_valid_emifclk;
    to_fsm_avmm_new_req_emifclk.wr_id      = to_emif_avmm_wr_id_emifclk;
    to_fsm_avmm_new_req_emifclk.rd_id      = to_emif_avmm_rd_id_emifclk;
    to_fsm_avmm_new_req_emifclk.address    = to_emif_avmm_address_emifclk;
    to_fsm_avmm_new_req_emifclk.writedata  = to_emif_avmm_writedata_emifclk;
  end

end  // gen_ECC_ENC_LATENCY_1
else if( MC_ECC_ENC_LATENCY == 0 )
begin : gen_ECC_ENC_LATENCY_0

  always_comb
  begin
    to_fsm_axi4_reqfifo_empty_emifclk = emif_avmm_1_axi_0 | from_mcrmw_reqfifo_empty_emifclk;
  
    to_fsm_axi4_new_req_emifclk.read = ~emif_avmm_1_axi_0 & from_mcrmw_new_req_emifclk.read;

    to_fsm_avmm_new_req_emifclk.read = emif_avmm_1_axi_0 & from_mcrmw_new_req_emifclk.read;
	
    to_fsm_axi4_new_req_emifclk.write = ~emif_avmm_1_axi_0 & from_mcrmw_new_req_emifclk.write;

    to_fsm_avmm_new_req_emifclk.write = emif_avmm_1_axi_0 & from_mcrmw_new_req_emifclk.write;
	
    to_fsm_axi4_new_req_emifclk.wr_id = emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.wr_id;
  
    to_fsm_avmm_new_req_emifclk.wr_id = ~emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.wr_id;

    to_fsm_axi4_new_req_emifclk.rd_id = emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.rd_id;
  
    to_fsm_avmm_new_req_emifclk.rd_id = ~emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.rd_id;
										  
    to_fsm_axi4_new_req_emifclk.address = emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.address;

	to_fsm_avmm_new_req_emifclk.address = ~emif_avmm_1_axi_0 ? '0 : from_mcrmw_new_req_emifclk.address;

    // keep data and ecc encoded together for avmm
	to_fsm_avmm_new_req_emifclk.writedata = ~emif_avmm_1_axi_0 ? '0 : writedata_with_ecc_encoded_n_poison;

    // unswivel the ecc and data for AXI
    to_fsm_axi4_new_req_emifclk.writedata = emif_avmm_1_axi_0
                                            ? '0
                                            : {writedata_with_ecc_encoded_n_poison[567:504],
                                               writedata_with_ecc_encoded_n_poison[495:432],
                                               writedata_with_ecc_encoded_n_poison[423:360],
                                               writedata_with_ecc_encoded_n_poison[351:288],
		                                       writedata_with_ecc_encoded_n_poison[279:216],
		                                       writedata_with_ecc_encoded_n_poison[207:144],
		                                       writedata_with_ecc_encoded_n_poison[135:72],
		                                       writedata_with_ecc_encoded_n_poison[63:0]};
											   
    // unswivel the ecc and data for AXI
    to_fsm_axi4_new_req_emifclk.wuser_ecc = emif_avmm_1_axi_0
                                            ? '0
                                            : {writedata_with_ecc_encoded_n_poison[575:568],
		                                       writedata_with_ecc_encoded_n_poison[503:496],
		                                       writedata_with_ecc_encoded_n_poison[431:424],
		                                       writedata_with_ecc_encoded_n_poison[359:352],
		                                       writedata_with_ecc_encoded_n_poison[287:280],
		                                       writedata_with_ecc_encoded_n_poison[215:208],
		                                       writedata_with_ecc_encoded_n_poison[143:136],
		                                       writedata_with_ecc_encoded_n_poison[71:64]};								 
  end

end  // gen_ECC_ENC_LATENCY_0
endgenerate

// ================================================================================================
assign to_mcrmw_mem_ready_emifclk = emif_avmm_1_axi_0
                                    ? from_fsm_avmm_cntrl_emifclk.mem_ready
                                    : from_fsm_axi4_cntrl_emifclk.mem_ready;

// ================================================================================================
endmodule
`ifdef QUESTA_INTEL_OEM
`pragma questa_oem_00 "zFoclWmBU4DKrbcZZsxtFXF1BluyLAv4WUQRAT7gmHCYU4EZvnvJ6ji3/MfL7BGsV/UbCHb+25EujB9EeNxwKr5oXBZWWiKPhJSAb6hqd4xyTI8hO5gtk5RwkDy3h61FCkCK21MlJEDsDIiHGWFX1aZv3UGfO4w79WI0WP6yioAZ55cpv/rNMpDA0UPxBg7lZUAfuAl5LY6m/fhCRwgZILoSpRXoMf5b+k4Zo8nnQ5LAhRHulqTMejIswGkrbLjAh8PJpd9oXAx5qKFdJ4ukOQwhKrn8nP8nhfX0BEKsw9RShgtuluD40r5moGV9hu1xYXJLKv2REASBba0AQMdfCXh2+ftClZTnNJSjKVIos52C3h9+3E4RRlTl/STywMMtQvIo18nxbctMQ5rZHp7UP4wmgRK+AjJleHTNL6xur+0J50I4cKLXpB80m+zMa9Zgcfo1Pvft34oOGn3p7SUFyr6ofIvJdrkk6+mLDxNc8LdDaBjtxkDaMkXr3y8fCq6h8/syyerXa9YI0z2j8U4IbBVeU3G2wNQJDWG4chsV91Mqbu0ci6+OtDZoBMnKhpHZWUCAQNckglVIaDjg73aoTSwatoS41gz8bdjFyFLB/MmVyGirp350y2A7w1r73lj9SGxuYKBRkMZYYoDGTf47ZOOTCoRfu879oOwumizTMVh3yO45SZ/k/hAR9K1ht2Kn/DmY5MsaYQEGKzhzM0MUS3cTAEAkHz3v/HiNEpbyiRKaWBCmeyrfU9Ori/7M0Wu0NNDVcrkt5xRIc6sWOK/zxfPAM0olwdyCXI6ZYcgMCk9LxlejwCMtfLL4IPGz5nwej/kLXxnOHPE5zX4mSg1wcySi/mmQ+bT20yNWlPQFM7SVyAPtklonyskZX4HmWJ+Btajdh4bteMDenekwKnUBvaMu8QgebBS6IU1qDTjzc0ibdNFJXJDVQenNe5Ppdq8GW5SAgV2t3xgwGvFwpreCl5VO+CtR7sPeo6cPqj3cM+rxtzZtIOy8XJ8K1bhXsGND"
`endif