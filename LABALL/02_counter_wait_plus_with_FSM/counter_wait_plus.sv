module counter_wait_plus1(
    input clk,
    input reset,
    output logic [3:0] a,
    output logic [3:0] b,
    output logic [3:0] W
);

logic cp1;
logic cp2;
logic [1:0] load_w;

// cnt_1
always_ff @(posedge clk) begin
    if (reset) a <= #1 0;
    else if (cp1) a <= #1 a + 1;
end

// cnt_2
always_ff @(posedge clk) begin
    if (reset) b <= #1 0;
    else if (cp2) b <= #1 b + 1;
end

assign S = a + b;
always_comb
begin
    if (load_w[1] && load_w[0]) W <= #1 S;
end


// FSM(controller)
parameter T0 = 0; // keep going
parameter T1 = 1; // stop
always_ff @(posedge clk) begin
    if (reset) begin
        a_ps <= #1 T0;
        b_ps <= #1 T0;
    end
    else begin
        a_ps <= #1 a_ns;
        b_ps <= #1 b_ps;
    end
end

always_comb
begin
    cp1 = 0;
    cp2 = 0;
    a_ns = a_ps;
    b_ns = b_ps;
    load_w = 0;

    unique case(a_ps)
        T0: begin
            cp1 = 1;
            if (a == 2 || a == 4) a_ns = T1; // next round stop
            else a_ns = T0;
        end
        T1: begin
            a_ns = T1;
            load_w = 1;
        end
    endcase

    unique case(b_ps)
        T0: begin
            cp2 = 1;
            if (b == 3 || b == 6) b_ns = T1;
            else b_ns = T0;
        end
        T1: begin
            load_w = 1;
            if (b == 7) b_ns =T1;
            else begin
                a_ns = T0;
                b_ns = T0;
            end
        end
    endcase
end

endmodule


