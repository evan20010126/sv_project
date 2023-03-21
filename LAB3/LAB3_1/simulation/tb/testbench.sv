`timescale 1ns/10ps
module testbench;
	
	logic clk;
	logic rst;

	logic outclk_0;
	logic outclk_1;
	logic locked;
	pll pl_test (
		.refclk(clk),
		.rst(rst), // .rst(KEY[0]),
		.outclk_0(outclk_0),
		.outclk_1(outclk_1),
		.locked(locked)
	);

	always #10 clk = ~clk;
	initial begin
		rst = 1; clk = 0;
		#15 rst = 0;
		#1000 $stop;
	end
endmodule