`timescale 1ns/10ps
module testbench;

	logic reset_test;
	logic clk_test;
	logic [2:0] q_test;

	logic [3:0] num;

	counter_8 counter_8_test(
    	.reset(reset_test),
		.clk(clk_test),
    	.q(q_test)
	);
	
	student_num student_num_test(
		.a(q_test),
		.q(num)
	);

	always #10 clk_test = ~clk_test;
	
	initial begin
		reset_test = 1; clk_test = 0;
		#15 reset_test = 0;
		#1000 $stop;
	end;
	
endmodule