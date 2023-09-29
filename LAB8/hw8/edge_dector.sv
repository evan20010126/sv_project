module detect_postive_edge_signal (
    output logic postive,
    input  logic signal,
    input  logic clk,
    input  logic reset
);

  logic s_signal, d_signal;
  always_ff @(posedge clk) begin
    if (reset) begin
      s_signal <= 1;
      d_signal <= 1;
      postive  <= 0;
    end else begin
      {d_signal, s_signal} = {s_signal, signal};
      postive <= ~s_signal & d_signal;
    end
  end

endmodule
