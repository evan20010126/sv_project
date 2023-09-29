module Encoder(
	input logic rst,
    input logic clk,
    input logic enc // signal
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
        .r_LPF_threshold_enc(14'd200),  //	Unit : 0.08us  /// 2^3 = 8,  r_LPF_threshold_enc=0 => By Pass
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
    always_comb
    begin
        if (~rst) cnt <= 0;
        else if (enable) cnt <= cnt + 1;
    end

    // DFF
    always_ff @( posedge clk )
    begin
        if (~rst) cnt_meas <= 0;
        else if (load) cnt_meas <= cnt;
    end



    // FSM
    // typedef enum { T0, T1, T2, T3, T4, T5, T6 } fsm_state_enum;
    // fsm_state_enum ns, ps;

    // always_ff @(posedge clk) begin
    //     if (~rst)
    //         ps <= T0;
    //     else
    //         ps <= ns;
    // end
    
    always_comb
    // begin
    //     enable = 0;
    //     load = 0;
    //     case (ps)
    //         T0: begin
    //             ns = T1;
    //         end

    //         T1: begin
    if (enc_pos == 1) begin
        enable = 1;
    end else begin
        load = 1;
    end
    // ns = T1;
    //     end
    // endcase
    // end
	
endmodule