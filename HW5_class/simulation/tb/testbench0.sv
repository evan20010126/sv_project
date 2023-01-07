`timescale 1ns/10ps

module testbench;

	logic [5:0] w;
	logic clk;
	logic reset;
	logic cnt;
	logic load_w;
	logic [5:0] b;
	logic [5:0] s;
	logic [4:0] ps;
	logic [4:0] ns;
 

	controller2A controller2A_test(
		.clk(clk),
		.reset(reset),
		.w_out(w),
		.cnt_out(cnt),
		.load_w_out(load_w),
		.b_out(b),
		.s_out(s),
		.ps_out(ps),
		.ns_out(ns)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#3000 $stop;
	end
endmodule