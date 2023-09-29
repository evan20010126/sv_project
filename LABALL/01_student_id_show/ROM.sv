module ROM(
	output [3:0] Rom_data_out, 
	input [2:0] Rom_addr_in
);
//---------
    
    logic [3:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				3'h0:	data = 4'h0;
				3'h1:	data = 4'h0;
				3'h2:	data = 4'h9;
				3'h3:	data = 4'h5;
				3'h4:	data = 4'h7;
				3'h5:	data = 4'h2;
				3'h6:	data = 4'h0;
				3'h7:	data = 4'h2;
				default:data = 4'hX;
            endcase
        end
     assign Rom_data_out = data;

endmodule