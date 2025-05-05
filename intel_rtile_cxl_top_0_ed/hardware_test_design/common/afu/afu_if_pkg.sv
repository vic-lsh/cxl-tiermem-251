package afu_if_pkg;


/* AXI signals from BBS to MC
 */
  typedef struct packed {
    logic   bready;
    logic   rready;
	
	logic [7:0]  awid;
	logic [51:0] awaddr;
	logic [9:0]  awlen;
	logic [2:0]  awsize;
	logic [1:0] awburst;
	logic [2:0] awprot;
	logic [3:0] awqos;
	logic       awvalid;
	logic [3:0] awcache;
	logic [1:0] awlock;
	logic [3:0] awregion;
	logic       awuser;

    logic [511:0] wdata;
	logic [63:0] wstrb;
	logic                          wlast;
	logic                          wvalid;
	logic  wuser; 
	
	logic [7:0]                 arid;
	logic [51:0]               araddr;
	logic [9:0]               arlen;
    logic [2:0] arsize;
    logic [1:0] arburst;
    logic [2:0] arprot;
    logic [3:0] arqos;
	logic                                        arvalid;
    logic [3:0]      arcache;
    logic [1:0] arlock;
    logic [3:0]             arregion;
    logic                aruser;
  } t_to_mc_axi4;

  localparam TO_MC_AXI4_BW = $bits(t_to_mc_axi4);
  
// ================================================================================================
  typedef struct packed {
    logic awready;
    logic wready;
    logic arready;
	
	logic [7:0]           bid;
	logic [1:0]   bresp;
	logic                                  bvalid;
	logic         buser;
	
	logic [7:0]           rid;
	logic [511:0]         rdata;
	logic [1:0] rresp;
	logic                                  rvalid;
	logic                                  rlast;
	logic                          ruser;
  } t_from_mc_axi4;
  
  localparam FROM_MC_AXI4_BW = $bits(t_from_mc_axi4);

endpackage : afu_if_pkg
