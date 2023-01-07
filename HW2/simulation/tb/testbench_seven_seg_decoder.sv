module testbench;


	logic [3:0] test_a;
	logic [6:0] test_y;
 
	// mux8to1 mux8to1_test(
	// 	.a(test_a),
	// 	.sel(test_sel),
	// 	.y(test_y)
	// );
	
	seven_seg_decoder seven_seg_decoder_test(
		.a(test_a),
		.y(test_y)
	);

	
	initial begin

		#10 test_a = 4'h0;
		#10 test_a = 4'h1;
		#10 test_a = 4'h2;
		#10 test_a = 4'h3;
		#10 test_a = 4'h4;
		#10 test_a = 4'h5;
		#10 test_a = 4'h6;
		#10 test_a = 4'h7;
		#10 test_a = 4'h8;
		#10 test_a = 4'h9;
		#10 test_a = 4'hA;
		#10 test_a = 4'hB;
		#10 test_a = 4'hC;
		#10 test_a = 4'hD;
		#10 test_a = 4'hE;
		#10 test_a = 4'hF;

		#1000 $stop;
	end;
endmodule