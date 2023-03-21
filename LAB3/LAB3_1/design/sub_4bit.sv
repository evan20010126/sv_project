`timescale 1 ps / 1 ps

module sub_4bit(
	input logic [3:0]a,
	input logic [3:0]b,
	output logic [3:0]s
	);
	
	always_comb
	begin
	 s = a - b;
	end
	
endmodule