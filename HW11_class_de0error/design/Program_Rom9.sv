module Program_Rom(
	output [13:0] Rom_data_out, 
	input [10:0] Rom_addr_in
);
//---------
    
    logic [13:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				11'h0:	data = 14'h01A5;
				11'h1:	data = 14'h0103;
				11'h2:	data = 14'h3007;
				11'h3:	data = 14'h07A5;
				11'h4:	data = 14'h3005;
				11'h5:	data = 14'h0AA5;
				11'h6:	data = 14'h04A5;
				11'h7:	data = 14'h00A4;
				11'h8:	data = 14'h0225;
				11'h9:	data = 14'h0825;
				11'ha:	data = 14'h06A4;
				11'hb:	data = 14'h3400;
				11'hc:	data = 14'h3400;
				default:data = 14'h0;
            endcase
        end
     assign Rom_data_out = data;

endmodule