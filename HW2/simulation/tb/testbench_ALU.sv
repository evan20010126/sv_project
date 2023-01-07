module testbench;


	logic [3:0] test_a;
	logic [3:0] test_b;
	logic test_op;
	logic [3:0] test_s;
 
	ALU_4bit ALU_4bit_test(
		.a(test_a),
		.b(test_b),
		.op(test_op),
		.s(test_s)
	);

	
	initial begin

		#10 test_a = 4'h5;	test_b = 4'hB;	test_op = 1'b0;

		#10 test_a = 4'hD;	test_b = 4'h7;	test_op = 1'b1;

		#1000 $stop;
	
	end;
	
endmodule