module SPI (
    input  logic clk,
    input  logic rst,
    input  logic mosi,
    input  logic sclk,
    input  logic ssn,
    output logic miso
);

  logic miso_req;
  logic [15:0] spi_data;

  SPI_MOSI mosi_tx (
      .clk(clk),
      .rst(rst),
      .mosi(mosi),
      .sclk(sclk),
      .ssn(ssn),
      .miso_req(miso_req),
      .spi_data(spi_data)
  );

  SPI_MISO miso_rx (
      .clk(clk),
      .rst(rst),
      .sclk(sclk),
      .miso_req(miso_req),
      .spi_data(spi_data),
      .miso(miso)
  );



endmodule
