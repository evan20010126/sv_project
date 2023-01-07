`timescale 1ns/100ps
module testbench;

    logic clk;
    logic reset;
    logic [1:0]R;
    logic [1:0]Y;
    logic [1:0]G;
	logic [3:0]count;
 
	traffic_light2 traffic_light2_test(
		.clk(clk),
		.reset(reset),
		.R(R),
		.Y(Y),
		.G(G),
		.count(count)
	);
	
	always #10 clk = ~clk;
	initial begin
		reset = 1; clk = 0;
		#15 reset = 0;
		#1000 $stop;
	end;
	
endmodule