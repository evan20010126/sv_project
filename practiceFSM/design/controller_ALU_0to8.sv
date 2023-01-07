`timescale 1ns/10ps
module controller_ALU_0to8 (
    input clk,
    input reset,
    output logic [5:0] w
);

    logic cnt;
    logic [5:0] b,s;
    logic load_w;
    logic [3:0] ps, ns;
    logic [1:0] op;

    /* register B */
    always_ff @( posedge clk ) 
    begin
        if (reset)
            b <= #1 0;
        else if (cnt)
            b <= #1 b + 1;
    end

    /* ALU combination */
    always_comb
    begin
        case (op)
            0: s = w + b;
            1: s = w - b;
            2: s = w * b;
            3: s = w / b;
        endcase
    end

    /* register W */
    always_ff @( posedge clk )
    begin
        if (reset)
            w <= #1 0;
        else if(load_w)
            w <= #1 s;
    end

    /* state */
    always_ff @( posedge clk )
    begin
        if (reset)
            ps <= 0;
        else
            ps <= ns;
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

    /*controller*/
    always_comb
    begin
        cnt = 0;
        load_w = 0;
        ns = T0;
        op = 0;
        case (ps)
            T0: 
            begin
                op = 0;
                cnt = 1; // next state will be 1
                ns = T1;
            end 
            T1:
            begin
                op = 0;
                load_w = 1;
                cnt = 1;
                ns = T2;
            end
            T2:
            begin 
                op = 0;
                load_w = 1;
                cnt = 1;
                ns = T3;
            end
            T3:
            begin 
                op = 1;
                load_w = 1;
                cnt = 1;
                ns = T4;
            end
            T4:
            begin
                op = 0;
                load_w = 1;
                cnt = 1;
                ns = T5;
            end
            T5:
            begin
                op = 2;
                load_w = 1;
                cnt = 1;
                ns = T6;
            end
            T6:
            begin
                op = 1;
                load_w = 1;
                cnt = 1;
                ns = T7;
            end
            T7:
            begin
                op = 3;
                load_w = 1;
                cnt = 1;
                ns = T8;
            end
            T8:
            begin
                op = 0;
                load_w = 1;
                ns = T9;
            end
            T9:
            begin
                ns = T9;
            end
        endcase
    end
endmodule