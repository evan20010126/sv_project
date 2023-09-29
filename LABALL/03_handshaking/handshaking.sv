module handshaking (
    input clk,
    input rst,
    output logic [3:0] c1,
    output logic [3:0] c2,
);
logic cp1, cp2, trigger_1, trigger_2;

typedef enum { START, PLUS_CNT1, PLUS_CNT2, TRG1, TRG2, WAIT_TRG1, WAIT_TRG2 } fsm_state_enum;

fsm_state_enum fsm1_ps, fsm2_ps, fsm1_ns, fsm2_ns;

//fsm1
always_ff @ (posedge clk or negedge rst) begin
    if(!rst)
        fsm1_ps <= START;
    else
        fsm1_ps <= fsm1_ns;
end

always_comb begin
    cp1 = 0;
    trigger_2 = 0;
    fsm1_ns = fsm1_ps;
    unique case(fsm1_ps)
        START: begin
            fsm1_ns = PLUS_CNT1;
        end
        PLUS_CNT1: begin
            if (c1 == 5)
                fsm1_ns = TRG2;
            else begin
                cp1 = 1;
                fsm1_ns = PLUS_CNT1;
            end
        end
        TRG2: begin
            trigger_2 = 1;
            fsm1_ns = WAIT_TRG1;
        end
        WAIT_TRG1: begin
            if (trigger_1 == 1) begin
                cp1 = 1; // Otherwise, c1 is still 5 in the next round. 
                fsm1_ns = PLUS_CNT1;
            end
            else
                fsm1_ns = WAIT_TRG1;
        end

    endcase
end

//fsm2
always_ff @ (posedge clk or negedge rst) begin
    if(!rst)
        fsm2_ps <= START;
    else
        fsm2_ps <= fsm2_ns;
end

always_comb begin
    cp2 = 0;
    trigger_1 = 0;
    fsm2_ns = fsm2_ps;
    unique case(fsm2_ps)
        START: begin
            fsm2_ns = WAIT_TRG2
        end
        WAIT_TRG2: begin
            if (trigger_2 == 1) begin
                cp2 = 1;
                fsm2_ns = PLUS_CNT2;
            end
            else
                fsm2_ns = WAIT_TRG2;
        end
        PLUS_CNT2: begin
            if (c2 == 6)
                fsm2_ns = TRG1;
            else begin
                cp2 = 1;
                fsm2_ns = PLUS_CNT2;
            end
        end
        TRG1: begin
            trigger_1 = 1;
            fsm2_ns = WAIT_TRG2;
        end
    endcase
end

always_ff @(posedge clk or negedge rst) begin 
    if(!rst) c1 <= 4'b0;
    else if(cp1) c1 <= c1+1'b1;
end

always_ff @(posedge clk or negedge rst) begin
    if(!rst) c2 <= 4'b0;
    else if(cp2) c2 <= c2+1'b1;
end

    
endmodule

