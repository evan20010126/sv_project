
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module mcu(

	//////////// CLOCK //////////
	input CLK,

	//////////// 7-segment decoder //////////
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	
	//////////// LED /////////////
	output [9:0] LED,
	
	//////////// SWITCH //////////
	input [9:0] SW,
	
	//////////// BUTTON //////////
	input [2:0] BTN
	
);
//*******************************//

// add module here
// adder_8bit adder1(
//	.a(SW[7:0]),
//	.b(SW[7:0]),
//	.s(LED[7:0])
//);

//sub_8bit sub1(
//	.a(8'd20),
//	.b(8'd12),
//	.s()
//);

//cpu_seven_seg cpu_seven_seg_unit(
//	.clk(BTN[1]),
//	.reset(~BTN[0]),
//	.seg_0(HEX0),
//	.seg_1(HEX1),
//	.seg_2(HEX2),
//	.seg_3(HEX3)
//);

logic [7:0] tmp;

cpu cpu_test(
    .clk(CLK),
    .reset(~BTN[0]),
    // output [13:0] IR
	 .w_q(tmp),
	 .my_led(LED[7:0])
    // output logic [7:0] w_q
);


//*******************************//

endmodule