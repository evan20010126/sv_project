module seven_segment(
	input [3:0] in, 
	output logic [6:0] out
);

	always_comb 
	begin
		case(in)
		4'h0: out = 7'hc0;
		4'h1: out = 7'hf9;
		4'h2: out = 7'ha4;
		4'h3: out = 7'hb0;
		4'h4: out = 7'h99;
		4'h5: out = 7'h92;
		4'h6: out = 7'h82;
		4'h7: out = 7'hf8;
		4'h8: out = 7'h80;
		4'h9: out = 7'h90;
		4'hA: out = 7'h88;
		4'hB: out = 7'h83;
		4'hC: out = 7'hc6;
		4'hD: out = 7'ha1;
		4'hE: out = 7'h86;
		4'hF: out = 7'h8e;
		endcase
	end
endmodule	