module testbench;


	logic [3:0]a,b,s;
	

sub_4bit s1(
	.a(a),
	.b(b),
	.s(s)
	);

	
	initial begin

		#10 a = 5; 	b = 3;
		#10 a = 15; 	b = 15;
		#10 a = 12; 	b = 10;
		#10 a = 0; 		b = 0;
		#1000 $stop;
	end
endmodule