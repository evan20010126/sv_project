module test_student_id;

	logic clk, reset, reset_div;
	logic [6:0] seven_seg;
	
	student_id id1(
		.clk_50M(clk),
		.reset(reset), 
		.reset_div(reset_div),
		.out(seven_seg)
	);
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0; reset = 0; reset_div = 0;
		#10 	reset_div = 1; reset = 1;
		#1000 	$stop;
	end
	
endmodule
