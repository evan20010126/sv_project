module SPI_rx(
	//------output--------------------------------
	output logic [7:0]	address,	    //8 bits address
    output logic [15:0] data,           //16 bits data
    output logic        read_en,
    output logic        write_en,
    output logic 		tx_req,
	
	//------input---------------------------------	
	input				mosi,	
	input				sclk,           //10MHz
	input				ssn,			
	input				clk,  		    //100MHz
	input				reset 		    //reset=1時，系統重製	

	);


endmodule
