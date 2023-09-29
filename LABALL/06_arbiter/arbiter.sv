module lab3_3 (
    input clk,
    input rst,
    input A,
    input B,
    input C,
    output logic A_out,
    output logic B_out,
    output logic C_out
);

typedef enum { T0, T1, T2, T3, T4, T5, T6 } fsm1_state_enum;

fsm1_state_enum fsm1_ns, fsm1_ps;

always_ff @(posedge clk) begin
    if (rst)
        fsm1_ps <= T0;
    else
        fsm1_ps <= fsm1_ns;
end

always_comb begin
    fsm1_ns = fsm1_ps;
    A_out = 0;
    B_out = 0;
    C_out = 0;
    case (fsm1_ps)
        /*
        T0 ~ T3 are different priorities.
        T0: A > B > C;
        T1: B > C > A;
        T2: C > A > B;
        */
        T0: begin
            if (A) begin
                A_out = 1;
                fsm1_ns = T1;
            end else if (B) begin
                B_out = 1;
                fsm1_ns = T2;
            end else if (C) begin
                C_out = 1;
                fsm1_ns = T0;
            end
        end

        T1: begin
            if (B) begin
                B_out = 1;
                fsm1_ns = T2;
            end else if (C) begin
                C_out = 1;
                fsm1_ns = T0;
            end else if (A) begin
                A_out = 1;
                fsm1_ns = T1;
            end
        end
        T2: begin
            if (C) begin
                C_out = 1;
                fsm1_ns = T0;
            end else if (A) begin
                A_out = 1;
                fsm1_ns = T1;
            end else if (B) begin
                B_out = 1;
                fsm1_ns = T2;
            end
        end

    endcase
end
    
endmodule