module testbench;

    logic clk;
   	logic rst;
	logic [3:0] a;
    logic [3:0] b;
	logic [3:0] W;
 
	counter_wait_plus counter_wait_plus_test(
		.clk(clk),
		.reset(rst),
		.a(a),
		.b(b),
		.W(W)
	);
	
	always #10 clk = ~clk;
	initial begin
		rst = 1; clk = 0;
		#15 rst = 0;
		#1000 $stop;
	end;
	
endmodule