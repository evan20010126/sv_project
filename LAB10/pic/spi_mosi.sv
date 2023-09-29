module SPI_MOSI (
    input logic clk,
    input logic rst,
    input logic mosi,
    input logic sclk,
    input logic ssn,
    output logic miso_req,
    output logic [15:0] spi_data
);

  logic [7:0] counter;
  logic rst_cnt;
  logic cp;
  logic [15:0] shift_reg;
  logic shift_en;
  logic ssn_perse;
  logic sclk_perse;
  logic output_en;

  logic [7:0] addr;
  logic send;
  reg [15:0] mem[0:255];
  logic get_addr;


  detect_postive_edge_signal ssn_decter (
      .postive(ssn_perse),
      .signal(ssn),
      .clk(clk),
      .reset(rst)
  );

  detect_postive_edge_signal_n sclk_decter (
      .postive(sclk_perse),
      .signal(sclk),
      .clk(clk),
      .reset(rst)
  );


  always_ff @(posedge clk) begin
    if (rst || rst_cnt) counter <= 0;
    else if (cp) counter <= counter + 1;
    else counter <= counter;
  end

  always_ff @(posedge clk) begin
    if (rst) shift_reg <= 0;
    else if (shift_en) shift_reg <= {shift_reg[14:0], mosi};
    else shift_reg <= shift_reg;
  end

  always_ff @(posedge clk) begin
    if (output_en) mem[addr] = shift_reg;
  end

  always_ff @(posedge clk) begin
    if (rst) {addr, send} <= 0;
    else if (get_addr) {addr, send} <= shift_reg[8:0];
    else {addr, send} <= {addr, send};
  end

  always @(posedge clk) begin
    if (rst) spi_data <= 0;
    else if (send) spi_data <= mem[addr];
    else spi_data <= spi_data;
  end

  typedef enum {
    reset,
    start,
    waiting
  } fsm;

  fsm ps, ns;

  always_ff @(posedge clk) begin
    if (rst) ps <= reset;
    else ps <= ns;
  end

  always_comb begin
    ns = ps;
    shift_en = 0;
    cp = 0;
    output_en = 0;
    rst_cnt = 0;
    get_addr = 0;
    miso_req = 0;
    case (ps)
      reset: begin
        if (ssn_perse) begin
          ns = start;
        end
      end
      start: begin
        if (sclk_perse) begin
          shift_en = 1;
          cp = 1;
          ns = waiting;
        end
      end
      waiting: begin
        if (counter == 9) begin
          get_addr = 1;
          ns = start;
        end else if (counter == 16 && send == 1) begin
          miso_req = 1;
          ns = start;
        end else if (counter >= 32) begin
          if (send == 0) output_en = 1;  //output data
          rst_cnt = 1;
          ns = reset;
        end else ns = start;
      end

    endcase


  end




endmodule
