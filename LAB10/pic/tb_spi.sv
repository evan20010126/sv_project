`timescale 1ns / 1ps

module tb_spi ();


  //=======================================================
  //  declarations
  //=======================================================


  //系統
  logic        clk;  //系統clk(50MHz)
  logic        reset;  //系統reset

  //DE_CV
  wire  [35:0] GPIO;

  //SPI
  logic [15:0] get_data;
  logic        cmd_miso;
  logic        cmd_mosi;
  logic        cmd_ssn;
  logic        cmd_sclk;  //10MHz
  parameter WRITE = 0;
  parameter READ = 1;
  parameter DIGITS = 16;  //傳輸位元數
  parameter SPI_T = 50;  //控制ssn的傳輸速度


  //=======================================================
  //  Structural coding
  //=======================================================


  assign GPIO[0]  = cmd_mosi;
  assign GPIO[1]  = cmd_sclk;
  assign GPIO[2]  = cmd_ssn;
  assign cmd_miso = GPIO[3];

  DE0_CV DE0_CV1 (
      //////////// CLOCK //////////
      .CLOCK_50 (clk),
      .CLOCK2_50(),
      .CLOCK3_50(),
      .CLOCK4_50(),
      //////////// SEG7 //////////
      .HEX0     (),
      .HEX1     (),
      .HEX2     (),
      .HEX3     (),
      .HEX4     (),
      .HEX5     (),
      //////////// KEY //////////
      .KEY      (),
      .RESET_N  (~reset),  //RESET_N=0時，系統重製
      //////////// LED //////////
      .LEDR     (),
      //////////// microSD Card //////////
      .SD_CLK   (),
      .SD_CMD   (),
      .SD_DATA  (),
      //////////// SW //////////
      .SW       (),
      //////////// GPIO_0, GPIO_0 connect to
      .GPIO_0   (GPIO),
      //////////// GPIO_1, GPIO_1 connect to
      .GPIO_1   ()
  );

  task write(
      //前16 bits寫入address+command
      //後16 bits寫入data
      input logic [7:0] write_address,
      input logic command, input logic [15:0] data);

    //declarations
    logic [15:0]   shift_register;
    integer    i;

    //開始傳輸
    cmd_ssn = 1;
    #100 shift_register = {write_address, command, 7'b0};
    #200;
    cmd_ssn = 0;

    for (i = 0; i < DIGITS; i = i + 1) begin
      cmd_mosi = shift_register[15];
      shift_register = shift_register << 1;
      #SPI_T cmd_sclk = 1;
      #SPI_T cmd_sclk = 0;
    end

    shift_register = data;
    #200;

    for (i = 0; i < DIGITS; i = i + 1) begin
      cmd_mosi = shift_register[15];
      shift_register = shift_register << 1;
      #SPI_T cmd_sclk = 1;
      #SPI_T cmd_sclk = 0;
    end

    //傳輸結束復位
    cmd_mosi = 0;
    cmd_sclk = 0;
    #200;
    cmd_ssn = 1;
  endtask

  task read(
      //前16 bits寫入address+command
      //後16 bits讀取data
      input logic [7:0] read_address,
      input logic command, output logic [15:0] data);

    logic [15:0]   shift_register;
    integer    i;

    //開始傳輸  
    cmd_ssn = 1;
    #100;
    shift_register = {read_address, command, 7'b0};
    #200;
    cmd_ssn = 0;
    for (i = 0; i < DIGITS; i = i + 1) begin
      cmd_mosi = shift_register[15];
      shift_register = shift_register << 1;
      #SPI_T cmd_sclk = 1;
      #SPI_T cmd_sclk = 0;
    end

    cmd_mosi = 0;
    #200;

    //接收回傳
    for (i = 0; i < DIGITS; i = i + 1) begin
      #SPI_T cmd_sclk = 1;
      data = {data[15:0], cmd_miso};
      #SPI_T cmd_sclk = 0;
    end

    //傳輸結束復位
    #200;
    cmd_sclk = 0;
    #200;
    cmd_ssn = 1;
  endtask

  always begin
    #10 clk = ~clk;
  end

  initial begin
    clk = 0;
    cmd_ssn = 1;
    cmd_mosi = 0;
    cmd_sclk = 0;

    //RESET 
    reset = 1;
    #1000 reset = 0;

    //傳輸
    write(8'h00, WRITE, 16'h0000);
    write(8'ha5, WRITE, 16'haa55);
    write(8'h5a, WRITE, 16'h5678);
    write(8'hff, WRITE, 16'hffff);

    read(8'hff, READ, get_data);
    read(8'h5a, READ, get_data);
    read(8'ha5, READ, get_data);
    read(8'h00, READ, get_data);

    #10000 $stop;

  end


endmodule
