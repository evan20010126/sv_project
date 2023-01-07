`timescale 1ns/100ps
module testbench;
	logic clk;
	logic reset;
	logic [2:0] a;
	logic [2:0] b;
	logic [2:0] c;
 
	counter_abc counter_abc_test(
		.clk(clk),
		.reset(reset),
		.a(a),
		.b(b),
		.c(c)
	);

	always #10 clk = ~clk;
	
	initial begin
		clk = 0; reset = 1;
		#15 reset = 0;
		#500 $stop;
	
	end;
	
endmodule