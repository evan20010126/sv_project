module rs232 (
    input logic clk,
    input logic rst,
    input logic [13:0] r_LPF_threshold;
    input logic	[1:0] buad_setting;
    input logic rx,
    // input logic 
);
    // rs232_rx rs232_rx_1(
    //     .clk(clk)
    //     .rst(rst)
    //     .buad_setting(buad_setting),
    //     .rx(rx_filter)
    // )
    
    rs232_tx rs232_tx_1(
        .clk(clk),
        .rst(rst),
        .buad_setting(buad_setting),

        .tx_req(tx_req),
        .tx_data(tx_data),

        .tx(tx),
        .tx_ack(tx_ack)
    );
endmodule