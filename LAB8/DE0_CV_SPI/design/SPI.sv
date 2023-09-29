//SPI slave
//mode: 0 (閒置時sclk為0，在第一個edge取值)

module SPI(
	//------output--------------------------------
	output logic 		miso,
	output logic [15:0] data_debug,
	
	//------input---------------------------------	
	input 		 		mosi,
	input 		 		sclk,			//傳輸速度: 10MHz
	input 		 		ssn,		
	input 		 		clk,			//系統 clk: 100MHz
	input 		 		reset			//系統 reset

	);


/*edge_detector*/
logic ssn_palse;
edge_detector_pos edge_detector_pos(
	.rst(reset),
    .clk(clk),
    .enc_filter(ssn),
	.enc_pos(ssn_palse)
);

logic sclk_palse;
edge_detector edge_detector_neg2(
	.rst(reset),
    .clk(clk),
    .enc_filter(sclk),
	.enc_pos(sclk_palse)
);

/* shift_register */
logic shift_en;
logic [15:0] shift_register;
always_ff @(posedge clk) begin
	if (reset) begin
		shift_register <= 0;
	end
	else if (shift_en) begin
		shift_register <= {shift_register[14:0], mosi};
	end
end

logic [5:0] cnt;
logic rst_cnt;
logic cnt_en;
always_ff @(posedge clk) begin
	if (rst_cnt || reset) cnt <= 0;
	else if (cnt_en) cnt <= cnt + 1;
	else cnt <= cnt;
end

logic data_rdy;
always_ff @(posedge clk) begin
	if (reset) data_debug <= 0;
	else if (data_rdy) data_debug <= shift_register;
end


/*FSM*/
typedef enum { T0, T1, T2, T3, T4, T5 } fsm_state_enum;
fsm_state_enum ps, ns;

always_ff @(posedge clk) begin
	if (reset) ps <= T0;
	else ps <= ns;
end

always_comb
begin
	ns = ps;
	shift_en = 0;
	cnt_en = 0;
	data_rdy = 0;
	rst_cnt = 0;
	unique case (ps)
		T0: ns = T1;

		T1: begin
			// wait ssn neg
			if (ssn_palse) begin
				ns = T2;
				rst_cnt = 1;
			end 
		end 

		T2: begin
			// catch
			if (cnt >= 16) begin
				ns = T1;
				rst_cnt = 1;
				data_rdy = 1;
			end
			else if (sclk_palse) begin
				shift_en = 1;
				cnt_en = 1;
			end
		end

		// T2: begin
		// 	if (sclk_palse) begin
		// 		shift_en = 1;
		// 		cnt_en = 1;
		// 		ns = T3;
		// 	end
		// end

		// T3: begin
		// 	if (cnt >= 16) begin
		// 		data_rdy = 1;
		// 		rst_cnt = 1;
		// 		ns = T0;
		// 	end
		// 	else ns = T1;
	endcase	
end

endmodule



