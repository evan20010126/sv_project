`timescale 1ns/100ps

//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE0_CV(
	//////////// CLOCK //////////
	input 		          		CLOCK_50,
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	inout 		          		CLOCK4_50,

	//////////// SDRAM //////////
	// output		    [12:0]		DRAM_ADDR,
	// output		     [1:0]		DRAM_BA,
	// output		          		DRAM_CAS_N,
	// output		          		DRAM_CKE,
	// output		          		DRAM_CLK,
	// output		          		DRAM_CS_N,
	// inout 		    [15:0]		DRAM_DQ,
	// output		          		DRAM_LDQM,
	// output		          		DRAM_RAS_N,
	// output		          		DRAM_UDQM,
	// output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// KEY //////////
	input 		     [3:0]		KEY,
	input 		          		RESET_N,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	// inout 		          		PS2_CLK,
	// inout 		          		PS2_CLK2,
	// inout 		          		PS2_DAT,
	// inout 		          		PS2_DAT2,

	// //////////// microSD Card //////////
	// output		          		SD_CLK,
	// inout 		          		SD_CMD,
	// inout 		input 		     [9:0]		SW
	//////////// SW //////////
	input 		     [9:0]		SW

	//////////// VGA //////////
	// output		     [3:0]		VGA_B,
	// output		     [3:0]		VGA_G,
	// output		          		VGA_HS,
	// output		     [3:0]		VGA_R,
	// output		          		VGA_VS,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	// inout 		    [35:0]		GPIO_0,

	//////////// GPIO_1, GPIO_1 connect to GPIO Default //////////
	// inout 		    [35:0]		GPIO_1
);



//=======================================================
//  REG/WIRE declarations
//=======================================================




//=======================================================
//  Structural coding
//=======================================================

logic [13:0] r_LPF_threshold;
logic [13:0] r_distance;
logic reset_n;

logic rx;
logic tx_data;
logic tx_end_flag;

logic step_col; // output

assign clk = CLOCK_50;
assign reset_n = RESET_N;
assign enc = SW[0]; // Actually 從GPIO進來
assign r_LPF_threshold = 14'd20;
assign r_distance = 14'd170; //1.70um (待測的距離)
// assign buad_setting = 2'b00;

Encoder ens_sys(
	.clk(clk),
	.rst(reset_n),
	.r_LPF_threshold(r_LPF_threshold), // 濾波門檻值
	.r_distance(r_distance), 
	.enc (enc),
	.step_col(step_col) // 每經過 r_distance 就通知印表機印一條線
);

	
	

endmodule
