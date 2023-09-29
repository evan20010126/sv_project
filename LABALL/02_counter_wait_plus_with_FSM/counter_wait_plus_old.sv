module counter_wait_plus (
    input clk,
    input reset,
    output logic [3:0] a,
    output logic [3:0] b,
    output logic [3:0] W
);

logic cnt_a;
logic cnt_b;

logic [1:0] load_w;

logic a_ps, a_ns;
logic b_ps, b_ns;

logic [3:0] S;
assign S = a + b;

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

always_comb
begin
    if(load_w[1] && load_w[0]) W <= #1 S;
end

always_ff @(posedge clk)
// for next state
begin
    if(reset) 
        begin
            a_ps<=#1 0;
            b_ps<=#1 0;
        end
    else 
        begin
            a_ps <= #1 a_ns;
            b_ps <= #1 b_ns;
        end
end

parameter T0 = 0; // keep going
parameter T1 = 1; // stop

always_comb 
begin
    cnt_a = 0;
    cnt_b = 0;
    a_ns = 0; 
    b_ns = 0;
    load_w = 0;
    
    case(a_ps)
        T0: 
        begin 
            cnt_a = 1; 
            if (a== 2 || a == 4) a_ns = T1;
            else a_ns = T0;
        end
        T1:
        begin
            a_ns = T1;
            load_w[0] = 1;
        end
    endcase

    case(b_ps)
        T0: 
        begin 
            cnt_b = 1; 
            if (b==3 || b == 6) b_ns = T1;
            else b_ns = T0; 
        end
        T1:
        begin
            load_w[1] = 1;
            if (b == 7) b_ns = T1;
            else begin
                a_ns = T0;
                b_ns = T0;
            end
        end
    endcase
end
    
endmodule

