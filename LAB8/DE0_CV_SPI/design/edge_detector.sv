module edge_detector(
	input logic rst,
    input logic clk,
    input logic enc_filter,
	output logic enc_pos
);
    logic s_signal, d_signal;
    // posedge of Encoder
    always_ff @(posedge clk)
    begin
        if (rst) begin
            s_signal <= 1'b1;
            d_signal <= 1'b1;
            enc_pos <= 1'b0;
        end else begin
            {d_signal, s_signal} <= {s_signal, enc_filter}; // enc_filter 是low pass過的信號(i.e 最新的信號)
            enc_pos <= s_signal & ~d_signal;
        end
    end
endmodule