module Program_Rom_class8(
	output [13:0] Rom_data_out, 
	input [10:0] Rom_addr_in
);
//---------
    
    logic [13:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				11'h0:	data = 14'h01A5;		//MOVLW
				11'h1:	data = 14'h0103;		//ADDLW
				11'h2:	data = 14'h3007;		//IORLW
				11'h3:	data = 14'h07A5;		//ANDLW
				11'h4:	data = 14'h0725;		//SUBLW
				11'h5:	data = 14'h2805;		//XORLW
				11'h6:	data = 14'h3400;		//ADDLW
				11'h7:	data = 14'h3400;		//ADDLW
				default:data = 14'h0;
            endcase
        end
     assign Rom_data_out = data;

endmodule