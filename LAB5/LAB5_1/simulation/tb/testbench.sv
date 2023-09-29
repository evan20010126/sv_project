`timescale 1ns/100ps
module testbench;
	logic [15:0]	a;
	logic [6:0]		HEX0;
    logic [6:0]		HEX1;
    logic [6:0]		HEX2;
    logic [6:0]		HEX3;
    logic [6:0]		HEX4;
    logic [6:0]		HEX5;
	logic [3:0]		KEY;
	logic [9:0]		SW;
	logic [9:0]		LEDR;
	
	logic CLOCK_50;
	logic rst_n;

DE0_CV de0_cv1(
	// .a(a),
	//////////// CLOCK //////////
	.CLOCK_50	(CLOCK_50),
	.CLOCK2_50	(),
	.CLOCK3_50	(),
	.CLOCK4_50	(),

	//////////// SEG7 //////////
	.HEX0(),
	.HEX1(),
	.HEX2(),
	.HEX3(),
	.HEX4(),
	.HEX5(),

	//////////// KEY //////////
	.KEY		(KEY),
	.RESET_N	(rst_n),

	//////////// LED //////////
	.LEDR		(LEDR),

	
	//////////// SW //////////
	.SW			(SW)
);

	//assign KEY[0] = rst_n;
	logic enc;
	
	logic [15:0]r_distance;
	
	always #10 CLOCK_50 = ~CLOCK_50;
	
	always begin
		//3128//	
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#10000 	enc = 0;	// signal
		
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#10000 	enc = 1;	// signal
		
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#20000 	enc = 0;	// signal
		
		#100 	enc = 1;	//noise
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		
		#20000 	enc = 1;
		//3128//
		
		//3613//
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#10000 	enc = 0;	// signal
		
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#9000 	enc = 1;	// signal
		
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#10100 	enc = 0;	// signal
		
		#100 	enc = 0;	//noise
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		
		#20000 	enc = 0;	// signal
		
		#100 	enc = 1;	//noise
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		#100 	enc = 1;
		#100 	enc = 0;
		
		#20000 	enc = 1;
		//3613//
		
	end
	
	assign SW[0] = enc;
	
	assign a = r_distance;
	
	initial begin
		CLOCK_50 = 0; 
		rst_n = 0;
		enc = 0;
		r_distance = 170;
		#20 rst_n = 1;;
		#500000 $stop;
	end
	
	
endmodule