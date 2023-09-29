`timescale 1ns/100ps

module bit_trans (
    input logic clk,
    input logic rst,
    input logic r_LPF_threshold,
    input logic rx,
    input logic tx,
    output logic rx_finish,
    output logic [7:0] shift_register
);


logic rx_palse;
edge_detector edge_detector_1( // negedge
	.rst(rst),
    .clk(clk),
    .enc_filter(rx),
	.enc_pos(rx_palse)
);

/* COUNTER */
logic rst_cnt;
logic [14:0] cnt;
logic enable;
always_ff @(posedge clk)
begin
    if (rst | rst_cnt) cnt <= 0;
    else if (enable) cnt <= cnt + 1;
end

/* shift_register */
logic shift_signal;
always_ff @(posedge clk)
begin
	if (rst) shift_register <= 0;
    else if (shift_signal)
        shift_register <= {rx, shift_register[7:1]};
    else
        shift_register <= shift_register;
end

/* FSM */

typedef enum { START, T1, T2, T3, T4, T5, T6, T7, T8, T9 } fsm_state_enum;
fsm_state_enum ps, ns;

always_ff @(posedge clk)
begin
    if (rst) 
    begin
        ps <= START;
    end
    else ps <= ns;
end


logic [3:0] bit_count;
logic bit_count_signal;
logic rst_bit_count;
always_ff @(posedge clk)
begin
    if (rst | rst_bit_count) bit_count <= 0;
    else if (bit_count_signal) bit_count <= bit_count + 1;
end

always_comb
begin
    ns = ps;
    rst_cnt = 0;
    shift_signal = 0;
    rx_finish = 0;
	enable = 0;
    bit_count_signal = 0;
    rst_bit_count = 0;

    unique case (ps)
        START: 
        begin
            if (rx_palse) 
            begin
                rst_cnt = 1;
                ns = T1;
            end
			else enable = 1;
        end
        
        T1:
        begin
            if (cnt > 1953) begin
                // 1302 * 3/2
                rst_cnt = 1;
                shift_signal = 1;
                bit_count_signal = 1;
                ns = T2;
            end
			else enable = 1;
        end

        T2:
        begin
            if (cnt > 1302) begin
                rst_cnt = 1;
                shift_signal = 1;
                bit_count_signal = 1;
                ns = T3;
            end
			else enable = 1;
        end

        T3:
        begin
            if (bit_count > 8) 
            begin
                ns = T4;
                rst_bit_count = 1;
            end
            else ns = T2;
        end
        
        T4:
        begin
            ns = START;
            rx_finish = 1;
        end

    endcase 
end


endmodule