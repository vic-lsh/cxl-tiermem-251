# (C) 2001-2025 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files from any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera IP License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


## 2 slice design  
setenv RTL_PATH $PWD/..;
setenv TB_PATH $PWD/typ3_tb;
sleep 3s;

### typ3 + pipe mode + RevA ###

clear ; perl $TB_PATH/scripts/vcs_execute.pl -cmd run_all_d -rundir $PWD/rundir_vcs_pipe_t3ip -r_path $RTL_PATH -t_path $TB_PATH -debug -clean -c_defines "+define+MASK_ACXL2_APPDX_BN26 +define+T3IP +define+ENABLE_2_BBS_SLICE +define+CXL_PIPE_MODE +define+SIM_MC_RAM_INIT_W_ZERO_PARTIAL_ONLY +define+QPDS_ED_B0 +define+RTILE_PIPE_MODE +define+RTILE_BYPASS_PHY" -s_pargs "+UVM_TESTNAME=cxl_base_test +CHECK_BBS_DOA +seqname=cxl_m2s_self_check_seq +TEST_MC0_MC1_INCR_ADDR +num_m2s_req=1500" -simdir_n sim_sanity_m2s;

#perl $TB_PATH/scripts/vcs_execute.pl -cmd sim_d -rundir $PWD/rundir_vcs_pipe_t3ip -r_path $RTL_PATH -t_path $TB_PATH -debug -s_pargs "+CHECK_BBS_DOA +UVM_TESTNAME=cxl_base_test +seqname=cxl_m2s_self_check_seq +TEST_MC0_MC1_INCR_ADDR +num_m2s_req=1500" -simdir_n sim_m2s &;
#perl $TB_PATH/scripts/vcs_execute.pl -cmd sim_d -rundir $PWD/rundir_vcs_pipe_t3ip -r_path $RTL_PATH -t_path $TB_PATH -debug -s_pargs "+UVM_TESTNAME=cxl_base_test +seqname=cxl_io_seq +num_io_req=1 +TEST_INCR_ADDR" -simdir_n sim_io &;








