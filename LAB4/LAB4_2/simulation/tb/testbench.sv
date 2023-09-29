module testbench;

	logic clk;
	logic rst;
	logic enc;


	Encoder test(
		.rst(rst),
		.clk(clk),
		.enc(enc)
	);
	
	
	always #10 clk = ~clk;

	initial begin
		rst = 0; clk = 0;
		#15 rst = 1;

		#100 enc = 0; // noise
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#10000 enc = 0; //signal

		#100 enc = 0; // noise
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;

		#10000 enc = 1; //signal

		#100 enc = 0; // noise
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		
		#10000 enc = 0; //signal

		#100 enc = 0; // noise
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;
		#100 enc = 0;
		#100 enc = 1;

		#10000 enc = 1; //signal



		#1000 $stop;
	end
endmodule