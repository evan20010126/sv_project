`timescale 1ns/10ps
module testbench;

	logic clk;
	logic reset;
	logic [2:0][3:0] q;
	logic [2:0] out;

	cas_counter_10 cas_counter_10(
		.reset(reset),
		.carry_in(clk),
		.q(q[0]),
		.carry_out(out[0])
	);

	cas_counter_10 cas_counter_10_1(
		.reset(reset),
		.carry_in(out[0]),
		.q(q[1]),
		.carry_out(out[1])
	);
	
	cas_counter_10 cas_counter_10_2(
		.reset(reset),
		.carry_in(out[1]),
		.q(q[2]),
		.carry_out(out[2])
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