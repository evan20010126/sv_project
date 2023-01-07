module testbench;


	logic [7:0][2:0] test_a;
	logic [2:0] test_sel;
	logic [2:0] test_y;
 
	mux8to1 mux8to1_test(
		.a(test_a),
		.sel(test_sel),
		.y(test_y)
	);

	
	initial begin

		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd0;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd1;

		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd2;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd3;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd4;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd5;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd6;
		
		#10 test_a[0] = 3'd0;	test_a[1] = 3'd1;	test_a[2] = 3'd2;	test_a[3] = 3'd3;	test_a[4] = 3'd4;	test_a[5] = 3'd5;	test_a[6] = 3'd6;	test_a[7] = 3'd7; test_sel = 3'd7;



		#1000 $stop;
	end;
endmodule