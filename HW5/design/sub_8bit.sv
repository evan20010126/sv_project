module sub_8bit(
	input [7:0] a,
	input [7:0] b,
	output logic [8:0] s
);


	assign s = a - b;

endmodule

