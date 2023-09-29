module SPI (
    input logic clk,
    input logic rst,
    input logic mosi,
    input logic sclk,
    input logic ssn,
    output logic miso,
    output logic [15:0] data_debug
);

  logic [5:0] counter;
  logic rst_cnt;
  logic cp;
  logic [15:0] shift_reg;
  logic shift_en;
  logic ssn_perse;
  logic sclk_perse;
  logic output_en;

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
    if (rst) data_debug <= 0;
    else if (output_en) data_debug = shift_reg;
    else data_debug <= data_debug;
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
        if (counter >= 16) begin
          output_en = 1;  //output data
          rst_cnt = 1;
          ns = reset;
        end
        ns = start;
      end

    endcase


  end




endmodule
