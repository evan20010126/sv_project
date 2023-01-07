`timescale 1ns/10ps

module testbench;

	logic clk;
	logic reset;
	logic [7:0] w_q;

 
	cpu cpu_test (
		.clk(clk),
		.reset(reset),
		.w_q(w_q)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#90000 $stop;
	end
endmodule