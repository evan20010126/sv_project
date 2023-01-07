module midterm_Rom(
  input [3:0] Rom_adr_in,
  output [15:0] Rom_data_out
);
  reg [15:0] data;
  
  always @(*)
  begin
    case(Rom_adr_in)//data in ROM
      4'h0 : data = 16'h1234;
      4'h1 : data = 16'h2138;
      4'h2 : data = 16'h1256;
      4'h3 : data = 16'h7757;
      default : data = 14'h0;
    endcase
  end
  assign Rom_data_out = data;
endmodule


