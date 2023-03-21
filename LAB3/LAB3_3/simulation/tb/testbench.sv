module testbench;

	logic clk;
    logic rst;
    logic A;
    logic B;
    logic C;
    logic A_out;
    logic B_out;
    logic C_out;

	lab3_3 u1(
    	.clk(clk),
    	.rst(rst),
    	.A(A),
    	.B(B),
    	.C(C),
    	.A_out(A_out),
    	.B_out(B_out),
    	.C_out(C_out)
	);
	
	always #10 clk = ~clk;

	initial begin
		rst = 1; clk = 0;
		#15 rst = 0;
		#15 A = 0; B = 0; C = 0;

		#20 A = 1; B = 1; C = 1;
		#60 A = 0; B = 0; C = 0;
		#20 B = 1;
		#20 A = 1; B = 0; C = 1;
		#40 A = 1; B = 1; C = 1;
		
		A = 0; B = 0; C = 0;
		
		#1000 $stop;
	end
endmodule