`timescale 1ns/10ps

module testbench;

	logic clk;

    logic reset;

    logic [3:0] w_out;
    logic cnt_out;
    logic load_w_out;
    logic [3:0] b_out;
    logic [3:0] s_out;
    logic [3:0] ps_out;
    logic [3:0] ns_out;
    logic [2:0] op_out;
 

	counter_ALU counter_ALU(
		.clk(clk),
		.reset(reset),
		.w_out(w_out),

		.cnt_out(cnt_out),
		.load_w_out(load_w_out),
		.b_out(b_out),
		.s_out(s_out),
		.ps_out(ps_out),
		.ns_out(ns_out),
		.op_out(op_out)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#3000 $stop;
	end
endmodule