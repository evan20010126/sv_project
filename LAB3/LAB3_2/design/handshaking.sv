module handshaking (
    input rst,
    input clk,
    output logic [3:0] c1,
    output logic [3:0] c2
);

logic cp1, cp2, trigger_1, trigger_2;

typedef enum { START, PLUS_CNT1, PLUS_CNT2, TRG1, TRG2, WAIT_TRG1, WAIT_TRG2 } fsm_state;

fsm_state fsm1_ps, fsm1_ns, fsm2_ns, fsm2_ps;

always_ff @ (posedge clk) begin
    if (rst) fsm1_ps <= START;
    else fsm1_ps <= fsm1_ns;
end

always_comb
begin
    fsm1_ns = fsm1_ps;
    cp1 = 0;
    trigger_2 = 0;

    case (fsm1_ps)
        START: begin
            fsm1_ns = PLUS_CNT1;
        end
        PLUS_CNT1: begin
            if (c1 == 5) fsm1_ns = TRG2;
            else cp1 = 1;
        end
        TRG2: begin
            trigger_2 = 1;
            fsm1_ns = WAIT_TRG1;
        end
        WAIT_TRG1: begin
            if (trigger_1 == 1) begin
                cp1 = 1; // let counter1 countinue;
                fsm1_ns = PLUS_CNT1;
            end
        end
    endcase
end

always_ff @ (posedge clk) begin
    if (rst) fsm2_ps <= START;
    else fsm2_ps <= fsm2_ns;
end

always_comb
begin
    fsm2_ns = fsm2_ps;
    cp2 = 0;
    trigger_1 = 0;
    
    case (fsm2_ps)
        START: begin
            fsm2_ns = WAIT_TRG2;
        end
        WAIT_TRG2: begin
            if (trigger_2 == 1) begin
                cp2 = 1; // let counter2 countinue;
                fsm2_ns = PLUS_CNT2;
            end
        end
        PLUS_CNT2: begin
            if (c2 == 6) fsm2_ns = TRG1;
            else cp2 = 1;
        end
        TRG1: begin
            trigger_1 = 1;
            fsm2_ns = WAIT_TRG2;
        end
    endcase
end

always_ff @ (posedge clk) begin
    if (rst) c1 <= 0;
    else if (cp1) c1 <= c1 + 1;
end

always_ff @ (posedge clk) begin
    if (rst) c2 <= 0;
    else if (cp2) c2 <= c2 + 1;
end


endmodule