`timescale 1ns/10ps
module testbench;

	logic reset_test;
	logic clk_test;
	logic [3:0] q_digit0;
	logic [3:0] q_digit1; /*[2:0] 但因為七段顯示器 宣告成[3:0]*/
	logic [3:0] q_digit2;
	logic [3:0] q_digit3; /*[1:0] 但因為七段顯示器 宣告成[3:0]*/

	logic digit0_carry_out;
	logic digit1_carry_out;
	logic digit2_carry_out;
	logic control;

	logic [6:0]y_digit0;
	logic [6:0]y_digit1;
	logic [6:0]y_digit2;
	logic [6:0]y_digit3;
	
	
	counter_10 digit0(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(1'b1),
		.q(q_digit0),
		.carry_out(digit0_carry_out)
	);

	seven_seg_decoder seven_seg_decoder_digit0(
		.a(q_digit0),
		.y(y_digit0)
	);

	counter_6 digit1(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(digit0_carry_out),
		.q(q_digit1),
		.carry_out(digit1_carry_out)
	);

	seven_seg_decoder seven_seg_decoder_digit1(
		.a(q_digit1),
		.y(y_digit1)
	);

	counter_10or4 digit2(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(digit1_carry_out),
		.carry_in2(digit0_carry_out),
		.control(control),
		.q(q_digit2),
		.carry_out(digit2_carry_out)
	);

	seven_seg_decoder seven_seg_decoder_digit2(
		.a(q_digit2),
		.y(y_digit2)
	);

	counter_3 digit3(
		.reset(reset_test),
		.clk(clk_test),
		.carry_in(digit2_carry_out),
		.carry_in2(digit1_carry_out),
		.carry_in3(digit0_carry_out),
		.q(q_digit3),
		.carry_out(control)
	);

	seven_seg_decoder seven_seg_decoder_digit3(
		.a(q_digit3),
		.y(y_digit3)
	);

	// seven_seg_decoder seven_seg_decoder_ten(
	// 	.a(q_ten),
	// 	.y(coverted_7_decoder_ten)
	// );

	always #10 clk_test = ~clk_test;
	
	initial begin
		reset_test = 1; clk_test = 0;
		#15 reset_test = 0;
		#100000 $stop;
	end;
	
endmodule