`timescale 1ns/10ps

module testbench;

	logic clk;
	logic reset;
	logic [13:0] IR;

 
	cpu cpu_test (
		.clk(clk),
		.reset(reset),
		.IR(IR)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#3000 $stop;
	end
endmodule