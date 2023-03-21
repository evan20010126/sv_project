module testbench;

	logic rst;
    logic clk;
    logic [3:0] c1;
    logic [3:0] c2;

	handshaking u1 (
		.rst(rst),
		.clk(clk),
		.c1(c1),
		.c2(c2)
	);
	
	always #10 clk = ~clk;

	initial begin
		rst = 1; clk = 0;
		#15 rst = 0;
		#2000 $stop;
	end
endmodule