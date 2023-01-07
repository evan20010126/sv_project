`timescale 1ns/10ps
module testbench;

	logic clk;
	logic reset;
	logic [5:0] w;
	controller2A controller2A(
		.clk(clk),
		.reset(reset),
		.w(w)
	);

	always #10 clk = ~clk;

	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#3000 $stop;
	end
	
	/*
	initial begin

		#10 test_a = 4'h5;	test_b = 4'hB;	test_op = 1'b0;
		
		#10 test_a = 4'hC;	test_b = 4'h2;	test_op = 1'b0;
		
		#10 test_a = 4'h9;	test_b = 4'h4;	test_op = 1'b1;

		#10 test_a = 4'h3;	test_b = 4'hB;	test_op = 1'b1;
		
		#10 test_a = 4'hD;	test_b = 4'h7;	test_op = 1'b1;

		#1000 $stop;
	
	end;
	*/

	
endmodule