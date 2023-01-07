`timescale 1ns/100ps
module testbench;

    logic clk;
   	logic reset;
	logic [3:0] a;
    logic [3:0] b;
	logic [3:0] W;
 
	counter_wait4and9_plus counter_wait4and9_plus_test(
		.clk(clk),
		.reset(reset),
		.a(a),
		.b(b),
		.W(W)
	);
	
	always #10 clk = ~clk;
	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#1000 $stop;
	end;
	
endmodule