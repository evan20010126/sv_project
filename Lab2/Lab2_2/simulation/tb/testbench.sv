module testbench;

	logic clk;
	logic rst;
	logic [1:0] r,y,g;	


	traffic t1(
	.clk(clk),
    .rst(rst),
	.r(r),
	.y(y),
	.g(g)
	);
	
	always #10 clk = ~clk;

	initial begin
		rst = 1; clk = 0;
		#15 rst = 0;
		#1000 $stop;
	end
endmodule