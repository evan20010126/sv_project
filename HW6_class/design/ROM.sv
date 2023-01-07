module ROM(
	output [13:0] Rom_data_out, 
	input [10:0] Rom_addr_in
);
//---------
    
    logic [13:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				11'h0:	data = 14'h3044;		//MOVLW
				11'h1:	data = 14'h3E01;		//ADDLW
				11'h2:	data = 14'h3E02;		//ADDLW
				11'h3:	data = 14'h3E03;		//ADDLW
				11'h4:	data = 14'h3E04;		//ADDLW
				11'h5:	data = 14'h3E05;		//ADDLW
				11'h6:	data = 14'h3E06;		//ADDLW
				11'h7:	data = 14'h3E07;		//ADDLW
				default:data = 14'hX;
            endcase
        end
     assign Rom_data_out = data;

endmodule