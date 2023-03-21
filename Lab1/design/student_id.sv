module student_id(
	input clk_50M,
	input reset, //為0時重置系統
	input reset_div,
	output logic[6:0] out
	);
	
	logic clk; //除頻後的clk
	logic[2:0] count;
	logic[3:0] num;
	
	//FSM
	
	
	//除頻器(1/2)
	frequency_divider div1(
		.clk_after(clk),
		.clk(clk_50M),
		.reset_fd(reset_div)
		);
	/*
	 @(posedge clk_50M or negedge reset) begin
		if(!reset)
			clk <= 0;
		else
			clk <= ~clk;
	end
	*/
	
	//counter
	always_ff @(posedge clk or negedge reset) begin
		if(!reset)
			count <= 0;
		else if(count==3'h7)
			count<=0;
		else begin
			count <= count+1;
		end
	end
	
	//ROM
	ROM Rom1(.Rom_data_out(num), .Rom_addr_in(count));
	
	//7-seg
	seven_segment Seg1(.in(num), .out(out));
	
endmodule