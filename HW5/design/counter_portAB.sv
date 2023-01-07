// 1.	counter數到20做累加運算，counter加到10的時候將值傳到port_A，加到20的時候傳到port_B
// 2.	輸入：clk, reset
// 3.	輸出：port_A[7:0]、port_B[7:0]

`timescale 1ns/10ps

module counter_portAB(

    input clk,
    input reset,

    output [7:0] w_out,

    output cnt_out,
    output load_w_out,
    output load_A_out,
    output load_B_out,
    output [4:0] b_out,
    output [7:0] s_out,
    output [4:0] ps_out,
    output [4:0] ns_out,
    output [7:0] port_A_out,
    output [7:0] port_B_out

);

logic [7:0] w;
assign w_out = w;

logic cnt;
assign cnt_out = cnt;

logic load_w;
assign load_w_out = load_w;

logic load_A;
assign load_A_out = load_A;

logic load_B;
assign load_B_out = load_B;

logic [4:0] b;
assign b_out = b;

logic [7:0] s;
assign s_out = s;

logic [4:0] ps;
assign ps_out = ps;

logic [4:0] ns;
assign ns_out = ns;

logic [7:0] port_A;
assign port_A_out = port_A;

logic [7:0] port_B;
assign port_B_out = port_B;

/*B counter*/
always_ff @(posedge clk)
begin
    if (reset) b <= #1 5'b0;
    else if (cnt) b <= #1 b + 1;
end

/*adder combination*/
assign s = w + b;

/*w register*/
always_ff @(posedge clk)
begin
    if (reset) w <= #1 8'b0;
    else if (load_w) w <= #1 s;
end

/*A register*/
always_ff @(posedge clk)
begin
    if (reset) port_A <= #1 8'b0;
    else if (load_A) port_A <= #1 w;
end

/*B register*/
always_ff @(posedge clk)
begin
    if (reset) port_B <= #1 8'b0;
    else if (load_B) port_B <= #1 w;
end

/*state change*/
always_ff @(posedge clk)
begin 
    if (reset) ps <= 0;
    else ps <= ns;
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
parameter T12 = 12;
parameter T13 = 13;
parameter T14 = 14;
parameter T15 = 15;
parameter T16 = 16;
parameter T17 = 17;
parameter T18 = 18;
parameter T19 = 19;
parameter T20 = 20;
parameter T21 = 21;
parameter T22 = 22;



always_comb
begin
    ns = 0;
    cnt = 0;
    load_w = 0;
    load_A = 0;
    load_B = 0;
    case (ps)
        T0:
        begin
            cnt = 1;
            load_w = 1;
            ns = T1;
        end
        T1:
        begin
            cnt = 1;
            load_w = 1;
            ns = T2;
        end
        T2:
        begin
            cnt = 1;
            load_w = 1;
            ns = T3;
        end
        T3:
        begin
            cnt = 1;
            load_w = 1;
            ns = T4;
        end
        T4:
        begin
            cnt = 1;
            load_w = 1;
            ns = T5;
        end
        T5:
        begin
            cnt = 1;
            load_w = 1;
            ns = T6;
        end
        T6:
        begin
            cnt = 1;
            load_w = 1;
            ns = T7;
        end
        T7:
        begin
            cnt = 1;
            load_w = 1;
            ns = T8;
        end
        T8:
        begin
            cnt = 1;
            load_w = 1;
            ns = T9;
        end
        T9:
        begin
            cnt = 1;
            load_w = 1;
            ns = T10;
        end
        T10:
        begin
            cnt = 1;
            load_w = 1;
            ns = T11;
        end
        T11:
        begin
            cnt = 1;
            load_w = 1;
            load_A = 1;
            ns = T12;
        end
        T12:
        begin
            cnt = 1;
            load_w = 1;
            ns = T13;
        end
        T13:
        begin
            cnt = 1;
            load_w = 1;
            ns = T14;
        end
        T14:
        begin
            cnt = 1;
            load_w = 1;
            ns = T15;
        end
        T15:
        begin
            cnt = 1;
            load_w = 1;
            ns = T16;
        end
        T16:
        begin
            cnt = 1;
            load_w = 1;
            ns = T17;
        end
        T17:
        begin
            cnt = 1;
            load_w = 1;
            ns = T18;
        end
        T18:
        begin
            cnt = 1;
            load_w = 1;
            ns = T19;
        end
        T19:
        begin
            cnt = 1;
            load_w = 1;
            ns = T20;
        end
        T20:
        begin
            load_w = 1;
            ns = T21;
        end
        T21:
        begin
            load_B = 1;
            ns = T22;
        end
        T22:
        begin
            ns = T22;
        end
    endcase
end

endmodule
        