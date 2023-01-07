module midterm_test;
  reg clk,reset;
  wire [7:0] out;
  midterm_top m1(
  .clk(clk),
  .reset(reset),
  .out(out)
);

  always #5 clk = ~clk;
  initial begin 
    clk = 0; reset = 1;
    #10 reset = 0;
    #2000 $stop;
  end
endmodule


