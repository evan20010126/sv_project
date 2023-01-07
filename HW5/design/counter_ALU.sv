`timescale 1ns/10ps

module counter_ALU(

    input clk,

    input reset,

    output [3:0] w_out,
    output cnt_out,
    output load_w_out,
    output [3:0] b_out,
    output [3:0] s_out,
    output [3:0] ps_out,
    output [3:0] ns_out,
    output [2:0] op_out
    
);

logic [3:0] w;
assign w_out = w;

logic cnt;
assign cnt_out = cnt;

logic load_w;
assign load_w_out = load_w;

logic [3:0] b;
assign b_out = b;

logic [3:0] s;
assign s_out = s;

logic [3:0] ps;
assign ps_out = ps;

logic [3:0] ns;
assign ns_out = ns;

logic [2:0] op;
assign op_out = op;

always_ff @(posedge clk)
begin
    if (reset) b <= #1 4'b0;
    else if (cnt) b <= #1 b + 1;
end

always_comb
begin
    case(op)
        0: s = w + b;
        1: s = w - b;
        2: s = w * b;
        3: s = w / b;
        4: s = w & b;
        5: s = w | b;
        6: s = w ^ b;
    endcase
end

always_ff @(posedge clk)
begin
    if (reset) w <= #1 4'b0;
    else if (load_w) w <= #1 s;
end

always_ff @(posedge clk)
begin 
    if (reset) ps <= 3'b0;
    else ps <= #1 ns;
end

parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2;
parameter T3 = 3;
parameter T4 = 4;
parameter T5 = 5;
parameter T6 = 6;
parameter T7 = 7;
parameter T8 = 8;
parameter T9 = 9;
parameter T10 = 10;
parameter T11 = 11;


always_comb
begin
    ns = 0;
    cnt = 0;
    load_w = 0;
    op = 0;
    case (ps)
        T0:
        begin
            cnt = 1;
            load_w = 1;
            ns = T1;
        end
        T1:
        begin
            cnt = 1; // next round: 2
            load_w = 1; // load 0
            op = 3'b000; // 0 + 1(this round b)
            ns = T2;
        end
        T2:
        begin
            cnt = 1; // next round: 3
            load_w = 1; // load 1(上一次加好的load進來w)
            op = 3'b101; // 1 + 2(this round b)
            ns = T3;
        end
        T3:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b010;
            ns = T4;
        end
        T4:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b001;
            ns = T5;
        end
        T5:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b011;
            
            ns = T6;
        end
        T6:
        begin
            cnt = 1;
            load_w = 1;
            
            op = 3'b000;
            ns = T7;
        end
        T7:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b000;
            
            ns = T8;
        end
        T8:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b110;
            
            ns = T9;
        end
        T9:
        begin
            cnt = 1;
            load_w = 1;
            op = 3'b000;
            ns = T10;
        end
        T10:
        begin
            load_w = 1;
            op = 3'b100;
            ns = T11;
        end
        T11:
        begin
            ns = T11;
        end
    endcase
end

endmodule
        