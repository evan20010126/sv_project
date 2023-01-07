module ROM_hw7(
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
				11'h2:	data = 14'h3802;		//IORLW
				11'h3:	data = 14'h39FE;		//ANDLW
				11'h4:	data = 14'h3C47;		//SUBLW
				11'h5:	data = 14'h3A55;		//XORLW
				11'h6:	data = 14'h3AAA;		//ADDLW
				default:data = 14'h0;
            endcase
        end
     assign Rom_data_out = data;

endmodule