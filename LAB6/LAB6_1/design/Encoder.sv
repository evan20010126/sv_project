`timescale 1ns/100ps

module Encoder(
    input logic clk,
	input logic rst,
    input logic [13:0] r_LPF_threshold,
    input logic [13:0] r_distance,
    input logic enc, // signal (有雜訊的)

    output logic step_col
	// output logic [3:0]s
	);
	
    logic enc_filter;
    logic enc_pos;
    logic [15:0] cnt;
    logic [15:0] cnt_meas;
    logic enable;
    logic load;

    Low_Pass_Filter_4ENC u1
    (
        .sig_filter(enc_filter),	
        .signal(enc),	
        .r_LPF_threshold_enc(r_LPF_threshold),  //	Unit : 0.08us  /// 2^3 = 8,  r_LPF_threshold_enc=0 => By Pass
        .clk(clk), 
        .reset(rst)
    );

    edge_detector u2(
        .rst(rst),
        .clk(clk),
        .enc_filter(enc_filter),
        .enc_pos(enc_pos) // 產生一個pulse
    );

    // counter
    logic rst_cnt;
    always_ff @( posedge clk )
    begin
        if (~rst | rst_cnt) cnt <= 0;
        else if (enable) cnt <= cnt + 1;
    end

    // DFF
    always_ff @( posedge clk )
    begin
        if (~rst) cnt_meas <= 0;
        else if (load) cnt_meas <= cnt;
    end


    logic cnt_meas_rdy;
    
    // FSM
    typedef enum { T0, T1, T2, T3, T4, T5, T6 } fsm_state_enum;
    fsm_state_enum ns, ps;

    always_ff @(posedge clk) begin
        if (~rst) begin
            ps <= T0;
            cnt_meas_rdy <= 0;
		  end
        else begin
            ps <= ns;
            cnt_meas_rdy <= load;
        end
    end
    
    always_comb
    begin
        enable = 0;
        rst_cnt = 0;
        load = 0;
        ns = ps;
        unique case (ps)
            T0: begin
                // reset
                rst_cnt = 0;
                ns = T1;
            end

            T1: begin
                if (enc_pos) ns = T2; // T2: load
                else enable = 1;
            end

            T2: begin
               load = 1;
               rst_cnt = 1;
               ns = T1;
            end
        endcase
    end

    gen_step_col gen_step_col_1(
        .clk (clk),
        .rst (rst),
        .cnt_meas_rdy (cnt_meas_rdy), // cnt_meas_rdy 通知說cnt_meas是可以用的值((因為初始化時cnt_meas是亂的
        .cnt_meas (cnt_meas), //真正的cnt值放這裡
        .r_distance (r_distance),
        .step_col(step_col) 
    );
	
endmodule