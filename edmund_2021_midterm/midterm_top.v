module midterm_top(
  input clk,
  input reset,
  output [7:0]out
);
  wire [7:0] PC_next;
  reg [7:0] PC_q;
  reg [7:0] result;
  //wire [13:0] ir_in;
  reg load_pc, sel_mult, load_ad, load_bc, load_out, load_reg;
  wire [15:0]Rom_out;
  reg [7:0] ad_q, bc_q;
  wire [7:0]x, y;
  reg [3:0] a_q, c_q, d_q, b_q;
  //reg [2:0] op;
  //wire [5:0] MOVLW, ADDLW, SUBLW, ANDLW, XORLW, IORLW;
  reg [3:0] ps, ns;
  assign PC_next = PC_q + 1;
  reg [7:0] counter;
  always @(posedge clk)//pc counter
  begin
    if(reset) counter <= 0;
    else counter = counter + 1;
  end
  always @(posedge clk)//pc counter
  begin
    if(reset) PC_q <= 0;
    else if(load_pc)  PC_q <= PC_next;
  end
  
  /*if(sel_mult) begin
	assign y = b_q;
	assign x = c_q;
  end
  else begin
	assign y = d_q;
	assign x = a_q;
  end*/

  assign x = a_q * d_q;
  assign y = b_q * c_q;
  always @(posedge clk)//X
  begin
    if(load_ad)
		ad_q = x;
	if(load_bc)
		bc_q = y;
  end
  
  
  always @(posedge clk)//rom reg
  begin
    if(load_reg) begin 
		a_q <= Rom_out[3:0];
		c_q <= Rom_out[7:4];
		d_q <= Rom_out[11:8];
		b_q <= Rom_out[15:12];
	end
  end
  midterm_Rom r1( //ROM
    .Rom_adr_in(PC_q),
    .Rom_data_out(Rom_out)
  );
  
  always @(posedge clk) //IR
  begin
    if(load_out)  result <= ad_q - bc_q;
  end
  assign out = result;
  
  always @(posedge clk)//ps ns
  begin
    if(reset) ps = 1;
    else  ps <= ns;
  end
  parameter T1 = 1, T2 = 2, T3 = 3, T4 = 4;
  
  always@(*)// controller
  begin
    ns = 1; load_pc = 0; load_reg = 0; load_ad = 0; load_bc = 0; load_out = 0;
    case(ps)
      T1:
      begin
        ns = T2; load_reg = 1; load_pc = 1;
      end
      T2:
      begin
        ns = T3;  load_ad = 1; sel_mult = 0;
      end
      T3:
      begin
        ns = T4; load_bc = 1; sel_mult = 1;
      end
      T4:
      begin
        ns = T2; load_out = 1; load_reg = 1; load_pc = 1;
      end
    endcase
  end
  
endmodule

