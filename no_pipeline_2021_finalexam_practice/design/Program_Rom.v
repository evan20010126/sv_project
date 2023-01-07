module Program_Rom(Rom_data_out, Rom_addr_in);

//---------
    output [13:0] Rom_data_out;
    input [10:0] Rom_addr_in; 
//---------
    
    reg   [13:0] data;
    wire  [13:0] Rom_data_out;
    
    always @(Rom_addr_in)
        begin
            case (Rom_addr_in)
                11'h0 : data = 14'h3004;		//MOVLW W<=4
                11'h1 : data = 14'h00A5;		//MOVWF ram[37]<=4
                11'h2 : data = 14'h300a;		//MOVLW W<=a
                11'h3 : data = 14'h008E;		//MOVWF PORTC<=a
                11'h4 : data = 14'h3003;		//MOVLW W<=3
                11'h5 : data = 14'h3425;		//ADDWEQCSZ  不跳躍(f+w=7;c=a;)
                11'h6 : data = 14'h3001;		//MOVLW W<=1	
				11'h7 : data = 14'h3002;		//MOVLW W<=2
                11'h8 : data = 14'h3003;		//MOVLW W<=3
				11'h9 : data = 14'h3006;		//MOVLW W<=6
				11'ha : data = 14'h3425;		//ADDWEQCSZ  跳躍(f+w=a;c=a;)
				11'hb : data = 14'h3001;		//MOVLW W<=1
				11'hc : data = 14'h3002;		//MOVLW W<=2
				11'hd : data = 14'h3003;		//MOVLW W<=3
				11'he : data = 14'h3005;		//MOVLW W<=5
				11'hf : data = 14'h0003;		//PORTCXWSZ  不跳躍(c=a;w=5;)
				11'h10 : data = 14'h3001;		//MOVLW W<=1
                11'h11 : data = 14'h3002;		//MOVLW W<=2
                11'h12 : data = 14'h3003;		//MOVLW W<=3
				11'h13 : data = 14'h3004;		//MOVLW W<=4
				11'h14 : data = 14'h3008;		//MOVLW W<=8
				11'h15 : data = 14'h008E;		//MOVWF PORTC<=8
				11'h16 : data = 14'h0003;		//PORTCXWSZ   跳躍(c=8;w=8;)
				11'h17 : data = 14'h3001;		//MOVLW W<=1
				11'h18 : data = 14'h3002;		//MOVLW W<=2
				11'h19 : data = 14'h3003;		//MOVLW W<=3
				11'h1a : data = 14'h3004;		//MOVLW W<=4
				11'h1b : data = 14'h2810;		//goto $
				11'h1c : data = 14'h3400;		
				11'h1d : data = 14'h3400;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
