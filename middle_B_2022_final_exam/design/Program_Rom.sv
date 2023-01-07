module Program_Rom(
	output logic [13:0] Rom_data_out, 
	input [10:0] Rom_addr_in
);

    logic [13:0] data;
    always_comb
        begin
            case (Rom_addr_in)
				11'h0  : data = 14'h3004;		//MOVLW W<=4
                11'h1  : data = 14'h008e;		//MOVWF portc=4
				11'h2  : data = 14'h3000;		//MOVLW W<=0
				11'h3  : data = 14'h00A5;		//ram[37]<=0 
				11'h4  : data = 14'h0725;		//addwf w<=w+ram[37]
				11'h5  : data = 14'h3425;		//incfeqcsz
                11'h6  : data = 14'h2804;		//goto pc=4
                11'h7  : data = 14'h3001;		//MOVLW W<=1
                11'h8  : data = 14'h3002;		//MOVLW W<=2
				11'h9  : data = 14'h3004;		//MOVLW W<=4
                11'hA  : data = 14'h00A5;		//MOVWF ram[37]<=4
                11'hB  : data = 14'h0825;		//MOVF W<=4
                11'hC  : data = 14'h008D;		//PORTB<=4
                11'hD  : data = 14'h3003;		//MOVLW W<=3
                11'hE  : data = 14'h0725;		//ADDWF W<=7
                11'hF  : data = 14'h008E;		//MOVWF PORTC<=7
				11'h10 : data = 14'h0003;		//PORTBCSZ
                11'h11 : data = 14'h3006;		//MOVLW W<=6
				11'h12 : data = 14'h008e;		//MOVWF PORTC<=6
                11'h13 : data = 14'h3008;		//MOVLW W<=8
				11'h14 : data = 14'h008e;		//MOVWF PORTC<=8
				11'h15 : data = 14'h0000;		//nop
				11'h16 : data = 14'h0003;		//PORTBCSZ
				11'h17 : data = 14'h3001;		//MOVLW W<=1
				11'h18 : data = 14'h3002;		//MOVLW W<=2
				11'h19 : data = 14'h3003;		//MOVLW W<=3		
				11'h1A : data = 14'h2819;		//goto $
                11'h1B : data = 14'h3400;		
                11'h1C : data = 14'h3400;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
