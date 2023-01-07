module testbench;

	logic [3:0] test_a;
	logic [3:0] test_b;
	logic test_op;
	logic [6:0] test_seg;
 
	ALU_seven_seg_decoder ALU_seven_seg_decoder_test(
		.a(test_a),
		.b(test_b),
		.op(test_op),
		.seg(test_seg)
	);

	
	initial begin

		#10 test_a = 4'h5;	test_b = 4'hB;	test_op = 1'b0;
		
		#10 test_a = 4'hC;	test_b = 4'h2;	test_op = 1'b0;
		
		#10 test_a = 4'h9;	test_b = 4'h4;	test_op = 1'b1;

		#10 test_a = 4'h3;	test_b = 4'hB;	test_op = 1'b1;
		
		#10 test_a = 4'hD;	test_b = 4'h7;	test_op = 1'b1;

		#1000 $stop;
	
	end;
	
endmodule