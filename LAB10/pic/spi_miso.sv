module SPI_MISO (
    input logic clk,
    input logic rst,
    input logic sclk,
    input logic miso_req,
    input logic [15:0] spi_data,
    output logic miso
);

  logic send_perse;
  logic shift_en;
  logic cp;
  logic [7:0] counter;
  logic rst_cnt;
  logic [15:0] send_data;

  detect_postive_edge_signal ssn_decter (
      .postive(send_perse),
      .signal(sclk),
      .clk(clk),
      .reset(rst)
  );

  always_ff @(posedge clk) begin
    if (rst || rst_cnt) counter <= 0;
    else if (cp) counter <= counter + 1;
    else counter <= counter;
  end

  assign miso = send_data[15];

  always_ff @(posedge clk) begin
    if (rst) send_data <= 0;
    else if (miso_req) send_data <= spi_data;
    else if (shift_en) send_data <= {send_data[14:0], 1'b0};
    else send_data <= send_data;
  end

  typedef enum {
    waiting,
    start0,
    start1,
    reset
  } fsm;

  fsm ps, ns;

  always_ff @(posedge clk) begin
    if (rst) ps <= waiting;
    else ps <= ns;
  end

  always_comb begin
    ns = ps;
    shift_en = 0;
    cp = 0;
    rst_cnt = 0;
    case (ps)
      waiting: begin
        if (miso_req) ns = start0;
      end
      start0: begin
        if (send_perse) begin
          cp = 1;
          ns = reset;
        end
      end
      start1: begin
        if (send_perse) begin
          shift_en = 1;
          cp = 1;
          ns = reset;
        end
      end
      reset: begin
        if (counter >= 17) begin
          rst_cnt = 1;
          ns = waiting;
        end else ns = start1;
      end
    endcase
  end



endmodule


