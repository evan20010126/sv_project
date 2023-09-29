module SPI_tx(
	//------output--------------------------------
	output logic 		miso,
    output logic        ack,
	
	//------input---------------------------------	
	input [15:0] prepare_data,
    input 		 		sclk_palse,			//傳輸速度: 10MHz
    input 		 		clk,			//系統 clk: 100MHz
	input 		 		reset,			//系統 reset
    input               req

	);

logic [5:0] cnt;
logic rst_cnt;
logic cnt_en;
always_ff @(posedge clk) begin
	if (rst_cnt || reset) cnt <= 0;
	else if (cnt_en) cnt <= cnt + 1;
	else cnt <= cnt;
end

/*FSM*/
typedef enum { T0, T1, T2, T3, T4, T5 } fsm_state_enum;
fsm_state_enum ps, ns;

always_ff @(posedge clk) begin
	if (reset) ps <= T0;
	else ps <= ns;
end


logic load_prepare_data;
logic [15:0] tmp_prepare_data;
logic shift_en;
logic send;
always_ff @(posedge clk) begin
    if (send) miso <= tmp_prepare_data[15];
end

always_ff @(posedge clk) begin
    if (load_prepare_data) tmp_prepare_data <= prepare_data;
    else if (shift_en) tmp_prepare_data <= {tmp_prepare_data[14:0], 1'b0};
end


always_comb
begin
    shift_en = 0;
    send = 0;
    rst_cnt = 0;
    load_prepare_data = 0;
    ack = 0;
    shift_en = 0;
    cnt_en = 0;
    ns = ps;
    unique case(ps)
        T0: ns = T1;

        T1: begin
            if (req) begin
                ns = T2;
                load_prepare_data = 1;
                rst_cnt = 1;
            end
        end
        
        T2: begin
            ns = T3;
            load_prepare_data = 1;
        end

        T3: begin
            if (cnt >= 16) begin
				rst_cnt = 1;
                ack = 1;
                ns = T1;
			end
			else if (sclk_palse) begin
				send = 1;
                shift_en = 1;
				cnt_en = 1;
			end
        end
    endcase
end

endmodule