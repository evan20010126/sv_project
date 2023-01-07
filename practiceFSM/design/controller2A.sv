`timescale 1ns/10ps
module controller2A (
    input clk,
    input reset,
    output logic [5:0] w
);

    logic cnt;
    logic [5:0] b,s;
    logic load_w;
    logic [3:0] ps, ns;

    /* register B */
    always_ff @( posedge clk ) 
    begin
        if (reset)
            b <= #1 0;
        else if (cnt)
            b <= #1 b + 1;
    end

    /* adder combination */
    assign s = b + w;

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
        case (ps)
            T0: 
            begin
                cnt = 1; // next state will add 2
                ns = T1;
            end 
            T1:
            begin
                load_w = 1;
                cnt = 1;
                ns = T2;
            end
            T2:
            begin 
                load_w = 1;
                cnt = 1;
                ns = T3;
            end
            T3:
            begin 
                load_w = 1;
                cnt = 1;
                ns = T4;
            end
            T4:
            begin
                load_w = 1;
                cnt = 1;
                ns = T5;
            end
            T5:
            begin
                load_w = 1;
                cnt = 1;
                ns = T6;
            end
            T6:
            begin
                load_w = 1;
                cnt = 1;
                ns = T7;
            end
            T7:
            begin
                load_w = 1;
                cnt = 1;
                ns = T8;
            end
            T8:
            begin
                load_w = 1;
                cnt = 1;
                ns = T9;
            end
            T9:
            begin
                load_w = 1;
                cnt = 1;
                ns = T10;
            end
            T10:
            begin
                load_w = 1;
                ns = T11;
            end
            T11:
            begin
                ns = T11;
            end
        endcase
    end
endmodule