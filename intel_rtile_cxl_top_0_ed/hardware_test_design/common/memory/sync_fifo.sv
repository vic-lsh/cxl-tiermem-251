`timescale 1 ns / 1 ps

////////////////////////////////////////////////
// Generic Synchronous FIFO
////////////////////////////////////////////////

module sync_fifo
#(
    parameter LOG_DEPTH       = 10,
    parameter WIDTH           = 32,
    parameter ALMOSTFULL_VAL  = 2**LOG_DEPTH - 3,
    parameter ALMOSTEMPTY_VAL = 3,
    parameter USE_LUTRAM      = 0,
    parameter USE_OUTREG      = 0,
    parameter SHOW_AHEAD      = 0
)
(
    input                 rst,
    input                 clk,
    
    input                 wrreq,
    input [WIDTH-1:0]     data,
    
    input                 rdreq,
    output [WIDTH-1:0]    q,
    
    output                full,
    output                almostfull,
    output                empty,
    output                almostempty,
    output                overflow,
    output [LOG_DEPTH:0]  usedw
);

    logic overflow_tmp;
    logic overflow_reg;

    always_ff @ (posedge clk) begin
        if (rst) begin
            overflow_tmp <= 1'b0;
        end else begin
            if (full && wrreq) begin 
                overflow_tmp <= 1'b1;
            end
        end
        overflow_reg <= overflow_tmp;
    end

    scfifo  scfifo_component (
                .clock (clk),
                .data (data),
                .rdreq (rdreq),
                .wrreq (wrreq),
                .almost_empty (almostempty),
                .almost_full (almostfull),
                .empty (empty),
                .full (full),
                .q (q),
                .usedw (usedw[LOG_DEPTH-1:0]),
                .aclr (1'b0),
                .eccstatus (),
                .sclr (rst));
    assign usedw[LOG_DEPTH] = full;
    assign overflow = overflow_reg;
    
    defparam
        scfifo_component.add_ram_output_register  = (USE_OUTREG == 1) ? "ON" : "OFF",
        scfifo_component.almost_empty_value  = ALMOSTEMPTY_VAL,
        scfifo_component.almost_full_value  = ALMOSTFULL_VAL,
        scfifo_component.lpm_hint = (USE_LUTRAM == 1) ? "RAM_BLOCK_TYPE=MLAB" : "RAM_BLOCK_TYPE=M20K",
        scfifo_component.enable_ecc  = "FALSE",
        scfifo_component.intended_device_family  = "Agilex",
        scfifo_component.lpm_numwords  = 2**LOG_DEPTH,
        scfifo_component.lpm_showahead  = (SHOW_AHEAD == 1) ? "ON" : "OFF",
        scfifo_component.lpm_type  = "scfifo",
        scfifo_component.lpm_width  = WIDTH,
        scfifo_component.lpm_widthu  = LOG_DEPTH,
        scfifo_component.overflow_checking  = "OFF",
        scfifo_component.underflow_checking  = "OFF",
        scfifo_component.use_eab  = "ON";


endmodule: sync_fifo