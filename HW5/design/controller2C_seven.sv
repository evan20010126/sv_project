`timescale 1ns/10ps

module controller2C_seven(

    input clk,
    input reset,
    
    output [6:0] seg,
    output [6:0] seg_ten
    
);

logic cnt;
logic load_w;
logic [5:0] w;
logic [5:0] b;
logic [5:0] s;
logic [4:0] ps;
logic [4:0] ns;

controller2C controller2A_test(
	.clk(CLK),
	.reset(BTN),
	.w_out(w),
	.cnt_out(cnt),
	.load_w_out(load_w),
	.b_out(b),
	.s_out(s),
	.ps_out(ps),
	.ns_out(ns)
);

always_comb
begin
    case(w[3:0])
        4'h0 : seg =  7'b100_0000;
        4'h1 : seg =  7'b111_1001;
        4'h2 : seg =  7'b010_0100;
        4'h3 : seg =  7'b011_0000;
        4'h4 : seg =  7'b001_1001;
        4'h5 : seg =  7'b001_0010;
        4'h6 : seg =  7'b000_0010;
        4'h7 : seg =  7'b111_1000;
        4'h8 : seg =  7'b000_0000;
        4'h9 : seg =  7'b001_0000;
        4'ha : seg =  7'b000_1000;
        4'hb : seg =  7'b000_0011;
        4'hc : seg =  7'b100_0110;
        4'hd : seg =  7'b010_0001;
        4'he : seg =  7'b000_0110;
        4'hf : seg =  7'b000_1110;
    endcase

    case(w[5:4])
        4'h0 : seg_ten =  7'b100_0000;
        4'h1 : seg_ten =  7'b111_1001;
        4'h2 : seg_ten =  7'b010_0100;
        4'h3 : seg_ten =  7'b011_0000;
        4'h4 : seg_ten =  7'b001_1001;
        4'h5 : seg_ten =  7'b001_0010;
        4'h6 : seg_ten =  7'b000_0010;
        4'h7 : seg_ten =  7'b111_1000;
        4'h8 : seg_ten =  7'b000_0000;
        4'h9 : seg_ten =  7'b001_0000;
        4'ha : seg_ten =  7'b000_1000;
        4'hb : seg_ten =  7'b000_0011;
        4'hc : seg_ten =  7'b100_0110;
        4'hd : seg_ten =  7'b010_0001;
        4'he : seg_ten =  7'b000_0110;
        4'hf : seg_ten =  7'b000_1110;
    endcase
end

endmodule

