`timescale 1ns/10ps
module testbench;
    logic clk, rst;
    logic [7:0] port_b_out;

    cpu c1(clk, rst, port_b_out);

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1;
        #10 rst = 0;
        #2200 $stop;
    end
endmodule