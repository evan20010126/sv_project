module testbench;

	logic clk;
    logic rst;
    logic a;
    logic b;
    logic c;
    logic A_out;
    logic B_out;
    logic C_out;

	lab4_1 u1(
    	.clk(clk),
    	.rst(~rst),
    	.A(a),
    	.B(b),
    	.C(c),
    	.A_out(A_out),
    	.B_out(B_out),
    	.C_out(C_out)
	);
	
	always #10 clk = ~clk;

	initial begin
		rst = 0; clk = 0;
		#10 rst = 1;
		#20 a = 1; b = 1; c = 1;
		#60 a = 0; b = 0; c = 0;
		#60 a = 0; b = 1; c = 0;
		#20 a = 0; b = 0; c = 0;
		#60 a = 1; b = 0; c = 1;
		#40 a = 0; b = 0; c = 0;
		#1000 $stop;
	end
endmodule