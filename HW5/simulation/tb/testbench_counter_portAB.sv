`timescale 1ns/10ps

module testbench;

	logic clk;
    logic reset;

    logic  [7:0] w_out;

    logic  cnt_out;
    logic  load_w_out;
    logic  load_A_out;
    logic  load_B_out;
    logic  [4:0] b_out;
    logic  [7:0] s_out;
    logic  [4:0] ps_out;
    logic  [4:0] ns_out;
    logic  [7:0] port_A;
    logic  [7:0] port_B;
 

	counter_portAB counter_portAB(
		.clk(clk),
		.reset(reset),
		.w_out(w_out),

		.cnt_out(cnt_out),
		.load_w_out(load_w_out),
		.load_A_out(load_A_out),
		.load_B_out(load_B_out),
		.b_out(b_out),
		.s_out(s_out),
		.ps_out(ps_out),
		.ns_out(ns_out),
		.port_A_out(port_A),
		.port_B_out(port_B)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#3000 $stop;
	end
endmodule