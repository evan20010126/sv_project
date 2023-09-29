module testbench;

	
	

	logic clk, rst;
	logic a,b,c;
	logic [3:0] count_a;
	logic [2:0] crosswalk_light;
	logic [2:0] road_light;
	top top1(
		.clk(clk),
		.rst(!rst),
		.a(a),
		.b(b),
		.c(c),
		.count_a(count_a),
		.crosswalk_light(crosswalk_light),
		.road_light(road_light)
	);
	always #10 clk = ~clk;

	initial begin
	clk = 0;	rst = 0; a = 0; b = 0 ; c = 0;
		#20 rst = 1;
		#20 a = 1;	b = 1;	c = 1;
		#60 a = 0;	b = 0;	c = 0;
		#600 a = 0;	b = 1;	c = 0;
		#60 a = 0;	b = 0;	c = 0;
		#600 a = 1;	b = 0;	c = 1;
		#60 a = 0;	b = 0;	c = 0;
		#1000 $stop;
	end
endmodule