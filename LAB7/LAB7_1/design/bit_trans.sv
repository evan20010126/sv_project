`timescale 1ns/100ps

module bit_trans (
    input logic clk,
    input logic rst,
    input logic r_LPF_threshold,
    input logic rx,


    output logic pkg_ready;
    

    input logic tx_ack;
    output logic tx_req;
    output logic [7:0] tx_data;
    

    output logic rx_finish,
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

/* bit counter */
logic [3:0] bit_count;
logic bit_count_signal;
logic rst_bit_count;
always_ff @(posedge clk)
begin
    if (rst | rst_bit_count) bit_count <= 0;
    else if (bit_count_signal) bit_count <= bit_count + 1;
end

/* pkg */

// logic pkg_ready;
logic shift_pkg;

logic [7:0] shift_register
logic [7:0] head;
logic [7:0] addr1;
logic [7:0] addr2;
logic [7:0] data1;
logic [7:0] data2;
logic [7:0] r_w;
logic [7:0] chk_sum;
logic [7:0] tail;
always_ff @(posedge clk)
begin
    if (rst) begin
        head <= 0;
        addr1 <= 0;
        addr2 <= 0;
        data1 <= 0;
        data2 <= 0;
        r_w <= 0;
        chk_sum <= 0;
        tail <= 0;
    end
    else if (shift_pkg)
        {head, addr1, addr2, data1, data2, r_w, chk_sum, tail} <= {addr1, addr2, data1, data2, r_w, chk_sum, tail, shift_register};
end 

logic rst_pkg_cnt;
logic [3:0] pkg_cnt;
always_ff @(posedge clk)
begin
    if (rst | rst_pkg_cnt) begin
        pkg_cnt <= 0;
    end
    else if (shift_pkg) begin
        pkg_cnt <= pkg_cnt + 1;
    end
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



always_comb
begin
    ns = ps;
    rst_cnt = 0;
    shift_signal = 0;
    rx_finish = 0;
	enable = 0;
    bit_count_signal = 0;
    rst_bit_count = 0;
    shift_pkg = 0;

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
            if (bit_count == 8) 
            begin
                ns = T4;
                rst_bit_count = 1;
                rx_finish = 1; // shift_pkg
            end
            else ns = T2;
        end

        T4:
        begin
            if (pkg_cnt > 8)
            begin
                ns = START;
                rst_pkg_cnt = 1;
            end 
            else
            begin    
                shift_pkg =1;
                ns = START;
            end
        end

    endcase 
end


endmodule