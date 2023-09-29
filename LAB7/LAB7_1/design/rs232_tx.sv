module rs232_tx (
    input logic clk,
    input logic rst, 
    input logic [1:0] buad_setting,

    input logic tx_req,
    input logic [7:0] tx_data,

    output logic tx,
    output logic tx_ack    
);
// rst = 1 時觸發。

parameter BAUD_CNT_MAX_9600  = 5208	;  // = 50000000 / 9600
parameter BAUD_CNT_MAX_19200 = 2604	;  // = 50000000 / 19200
parameter BAUD_CNT_MAX_38400 = 1302	;  // = 50000000 / 

logic [15:0] baud_cnt;
logic [3:0] bit_cnt;
logic [9:0] data;

logic rst_baud_cnt;
logic baud_cnt_flag;
logic bit_flag;
lgoci rst_bit_cnt;
logic load_tx_data;
logic send_tx_data;

assign BAUD_CNT_MAX = ((baud_cnt == BAUD_CNT_MAX_9600) && (buad_setting == 0)) || ((baud_cnt == BAUD_CNT_MAX_19200) && (buad_setting == 1)) || ((baud_cnt == BAUD_CNT_MAX_38400) && (buad_setting == 2));

// baud_cnt
always_ff @(clk) begin
    if (rst | rst_baud_cnt) baud_cnt <= 0;
    else if (baud_cnt_flag) baud_cnt <= baud_cnt + 1;
end

// bit_cnt for output data[9]~data[0]
always_ff @(clk) begin
    if (rst | rst_bit_cnt) bit_cnt <= 0;
    else if (bit_flag) bit_cnt <= bit_cnt + 1;
end

// data
logic shift_data_flag;
always_ff @(clk) begin
    if (rst) data <= 0;
    else if (load_tx_data) data <= {1'b1, tx_data, 1'b0};
    else if (shift_data_flag) data <= {1'b1, data[9:0]}; // lower bit output
end

// Output
// another sol: assign tx = data[0];
always_ff @(clk) begin
    if (rst | tx_ack) tx <= 1;
    else if (send_tx_data) tx <= data[0];
    else tx <= 1;
end

// FSM
typedef enum { T0, T1, T2, T3, T4, T5, T6 } fsm_state_enum;
fsm_state_enum ps, ns;
always_ff @(clk) begin
    if (rst) ps <= T0;
    else ps <= ns;
end

always_comb
begin
    case (ps)
        T0: begin
            ns = T1;
        end

        T1: begin
            if (tx_req) ns = T2;
            else ns = T1;
        end 

        T2: begin
            load_tx_data = 1;
            rst_baud_cnt = 1;
            ns = T3;
        end

        // 一個一個輸出
        T3: begin
            if (BAUD_CNT_MAX) begin
                send_tx_data = 1;
                ns = T4;
            end else begin
                ns = T3;
            end
        end

        T4: begin
            bit_flag = 1;
            shift_data_flag = 1;
            if (bit_cnt < 9) begin
                ns = T3;
                rst_baud_cnt = 1;
            end else begin
                ns = T5;
            end
        end

        T5: begin
            rst_bit_cnt = 1;
            tx_ack = 1;
            ns = T1; 
        end
    endcase
end

endmodule