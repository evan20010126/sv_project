`timescale 1ns/100ps

module gen_step_col(
    input logic clk,
    input logic rst,
    input logic cnt_meas_rdy, // cnt_meas_rdy 通知說cnt_meas是可以用的值((因為初始化時cnt_meas是亂的
    input logic [15:0] cnt_meas, //真正的cnt值放這裡
    input logic [13:0] r_distance,
    output logic step_col
);
    logic [31:0] mul_result;
    logic [31:0] cnt;
    logic cp1;
    logic load_cnt_1;
    
    always_ff @(posedge clk) begin
        if (!rst)
            mul_result <= 'b0;
        else
            mul_result <= cnt_meas * r_distance / 4233;
    end

    // cnt1
    always_ff @(posedge clk) begin
        if (load_cnt_1)
            cnt <= mul_result;
        else if (cnt)
            cnt <= cnt - 1'b1;
    end

    typedef enum { START, CHK_MEAS_RDY_1, CHK_MEAS_RDY_2, LOAD_CNT, GEN_STEP_C } fsm_state_enum;
    fsm_state_enum ps, ns;

    // FSM1
    always_ff @(posedge clk) begin
        if (!rst)
            ps <= START;
        else
            ps <= ns;
    end
    
    always_comb begin
        cp1 = 0;
        load_cnt_1 = 0;
        step_col = 0;
        ns = ps;
        unique case(ps)
            START: begin
                load_cnt_1 = 1;
                ns = CHK_MEAS_RDY_1;
            end

            CHK_MEAS_RDY_1: begin
                if (cnt_meas_rdy)
                    ns = CHK_MEAS_RDY_2;
            end

            CHK_MEAS_RDY_2: begin
                if (cnt_meas_rdy)
                    ns = LOAD_CNT;
            end

            LOAD_CNT: begin
                load_cnt_1 = 1;
                ns = GEN_STEP_C;
            end

            GEN_STEP_C: begin
                if (~|cnt) begin
                    load_cnt_1  = 1;
                    step_col = 1;
                end
                ns = GEN_STEP_C;
            end
        endcase
    end
endmodule