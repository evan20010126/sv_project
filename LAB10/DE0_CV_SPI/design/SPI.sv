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
logic data_rdy2;
logic [7:0] addr;
logic r_w;
logic [6:0] dontcare;
logic [15:0] data;

always_ff @(posedge clk) begin
	// if (reset) data_debug <= 0;
	// else if (data_rdy) data_debug <= shift_register;
	if (reset) {addr, r_w, dontcare} <= 0;
	else if (data_rdy) {addr, r_w, dontcare} <= shift_register;
end

always_ff @(posedge clk) begin
	if (reset) data <= 0;
	else if (data_rdy2) data <= shift_register;
end


/*FSM*/
typedef enum { T0, T1, T2, T3, T4, T5 } fsm_state_enum;
fsm_state_enum ps, ns;

always_ff @(posedge clk) begin
	if (reset) ps <= T0;
	else ps <= ns;
end

logic write_en;
logic read_en;
logic [15:0] prepare_data;
logic [15:0] reg_file [127:0];

logic write_en_fifo;
logic write_en_fifo_neg;
logic [15:0] data_neg;
logic rdreq;
logic [15:0] q;
logic rdreq_neg;
logic ack;

always_ff @(posedge clk)
begin
	if (reset) prepare_data <= 0;
	else if(write_en)
		reg_file[addr] <= data;
	else if(read_en)
		prepare_data <= reg_file[addr];
	else if(addr[7] != 0)
		prepare_data <= q;
end

logic req;
SPI_tx SPI_tx_test(
	.miso(miso),
	.ack(ack),
	.prepare_data(prepare_data),
	.sclk_palse(sclk_palse),
	.clk(clk),		
	.reset(rst),		
	.req(req)
);


always_ff @(negedge clk)
begin
	if (rst) begin
		rdreq_neg <= 0;
		write_en_fifo_neg <= 0;
		data_neg <= 0;
	end
	else begin
		rdreq_neg <= rdreq; 
		write_en_fifo_neg <= write_en_fifo;
		data_neg <= data;
  end
end

fifo fifo1(
	.clock(clk),
	.data(data_neg),
	.rdreq(rdreq_neg),
	.sclr(rst),
	.wrreq(write_en_fifo_neg),
	.almost_empty(),
	.empty(),
	.full(),
	.q(q),
	.usedw()
);

always_comb
begin
	ns = ps;
	shift_en = 0;
	cnt_en = 0;
	data_rdy = 0;
	data_rdy2 = 0;
	rst_cnt = 0;
	write_en = 0;
	read_en = 0;
	req = 0;
	write_en_fifo = 0;
	rdreq = 0;
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
				rst_cnt = 1;
				data_rdy = 1;
				if (shift_register[7] == 1'b0)
					begin
						// 寫入暫存器
						rst_cnt = 1;
						ns = T4;
					end
				else
					begin
						// 從暫存器讀出
						// read_en = 1;
						req = 1;
						ns = T3;
						// 還要讀data
					end
			end
			else if (sclk_palse) begin
				shift_en = 1;
				cnt_en = 1;
			end
		end

		T3: begin
			// wait ssn neg
			// if (ssn_palse) begin
			ns = T4;
			if (addr[7] == 0)
				read_en = 1;
			else
				rdreq = 1;
			rst_cnt = 1;
			// end 
		end

		T4: begin
			// data 16bits
			if (cnt >= 16) begin
				ns = T5;
				rst_cnt = 1;
				data_rdy2 = 1;
				
			end
			else if (sclk_palse) begin
				shift_en = 1;
				cnt_en = 1;
			end
		end

		T5: begin
			if (r_w == 1'b0) 
			begin
				if (addr[7] == 0) write_en = 1;
				else write_en_fifo = 1;
			end
			ns = T1;
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



