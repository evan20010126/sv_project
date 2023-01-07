`timescale 1ns/10ps
module testbench;

	logic reset_test;
	logic clk_test;
	logic [3:0] q_unit;
	logic [3:0] q_ten;
	logic carry_out_unit, carry_out_ten;
	logic [6:0]coverted_7_decoder_unit, coverted_7_decoder_ten;
	
	
	counter_10 unit_digit(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(1'b1),
		.q(q_unit),
		.carry_out(carry_out_unit)
	);

	seven_seg_decoder seven_seg_decoder_unit(
		.a(q_unit),
		.y(coverted_7_decoder_unit)
	);

	counter_10 ten_digit(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(carry_out_unit),
		.q(q_ten),
		.carry_out(carry_out_ten)
	);

	seven_seg_decoder seven_seg_decoder_ten(
		.a(q_ten),
		.y(coverted_7_decoder_ten)
	);

	always #10 clk_test = ~clk_test;
	
	initial begin
		reset_test = 1; clk_test = 0;
		#15 reset_test = 0;
		// #2000 $stop;
	end;
	
endmodule