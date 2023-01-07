`timescale 1ns/100ps
module counter_abc (
    input clk,
    input reset,
    output logic [2:0] a,
    output logic [2:0] b,
    output logic [2:0] c
);
logic cnt_a;
logic cnt_b;
logic cnt_c;
logic load_w;
logic [3:0] ps,ns;

always_ff @(posedge clk)
begin
    if(reset) a<=#1 0;
    else if(cnt_a) a <= #1 a+1;
end

always_ff @(posedge clk)
begin
    if(reset) b<=#1 0;
    else if(cnt_b) b <= #1 b+1;
end

always_ff @(posedge clk)
begin
    if(reset) c<=#1 0;
    else if(cnt_c) c <= #1 c+1;
end

always_ff @(posedge clk)
begin
    if(reset) ps<=#1 2'b00;
    else ps <= #1 ns;
end

parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2;
parameter T3 = 3;

always_comb 
begin
    cnt_a = 0;
    cnt_b = 0;
    cnt_c = 0;
    ns = 0;
    
    case(ps)
        T0: 
        begin 
            cnt_a = 1; 
            if (a==4) ns = T1;
            else ns = T0; 
        end
        T1:
        begin
            cnt_b = 1;
            if (b==5) ns = T2;
            else ns = T1;
        end
        T2:
        begin
            cnt_c = 1;
            if (c==6) ns = T3;
            else ns = T2;
        end
        T3:
        begin
        ns = T3;
        end
    endcase
end
    
endmodule

