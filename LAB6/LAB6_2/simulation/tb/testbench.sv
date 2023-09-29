`timescale 1ns/100ps
module testbench;


	logic			clk, rst;
	logic	[1:0]	buad_setting;  //0:9600 1:19200 2:38400
	logic			rx, tx_flag; //input
	logic 			tx_end_flag, tx_data; //output
	logic [13:0] r_LPF_threshold;
	logic [7:0] send_data;
	
	logic [7:0]data_debug;
	
	integer	i;
	integer	j;
	

	
	logic [7:0] send_package_w [0:7] = {8'h02, 8'h30, 8'h32, 8'h30, 8'h33, 8'h01, 8'hc8, 8'h03};
	logic [7:0] send_package_r [0:7] = {8'h02, 8'h30, 8'h32, 8'h00, 8'h00, 8'h00, 8'h64, 8'h03};
	//02, 30, 32, 30, 33, 01, c8, 03	c8
	//02, 30, 32, 00, 00, 00, 64, 03	64
	
	
	
	parameter BAUD_CNT_MAX_9600  = 5208	;  // = 50000000 / 9600
	parameter BAUD_CNT_MAX_19200 = 2604	;  // = 50000000 / 19200
	parameter BAUD_CNT_MAX_38400 = 1302	;  // = 50000000 / 38400 
	
	assign r_LPF_threshold	= 14'd200;


logic rx_finish;
bit_trans bit_trans_1(
		.clk					(clk					), 
		.rst               		(~rst               ),
		.r_LPF_threshold		(r_LPF_threshold		),
		// .buad_setting			(buad_setting			),
		.rx						(rx						),
		.tx						(tx						),
		.rx_finish				(rx_finish),
		.shift_register			(data_debug)
);
	// rs232 rs232_1(
	// 			.clk(clk),                          
	// 			.rst(~rst),            
	// 			.r_LPF_threshold		(r_LPF_threshold		),
	// 			.buad_setting(buad_setting),    
				
	// 			.rx		(rx),
	// 			.tx		(tx_data),
	// 			.data_debug(data_debug)
	// 		);                                                                       		
				
				
	always	#10 clk = ~clk;
	
	initial begin
		rx = 1'b1; 
		clk = 0;
		buad_setting = 2'b10; 
		tx_flag = 0; 
		rst = 0;
		
		#40 rst = 1;
		
		
		for (j=0; j<8; j=j+1) begin 
				send_data = send_package_w[j];  //start bit
				tx_task;
				#100;
		end
		
		for (j=0; j<8; j=j+1) begin 
				send_data = send_package_r[j];  //start bit
				tx_task;
				#100;
		end
		
		
		
		#(1302 * 40 * 25) $stop;
	
	end
	
	task reset_task ; begin
		#(10); rst = 0;
		#(40); rst = 1;
		end 
	endtask
	
	
	
	task tx_task; begin  //寫
			#(1302 * 20)	rx = 1'b0;  //start bit
			for (i=0; i<8; i=i+1) 
				#(1302 * 20)	rx = send_data[i];  //start bit
			
			#(1302 * 20) 	rx = 1'b1;  //end bit
		end
	endtask
	
	
	
	
	
endmodule
