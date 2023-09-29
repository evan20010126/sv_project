module arbiter_polling(
    input logic clk, rst,
    input logic a,b,c,
    output logic trg_a,
    output logic trg_b,
    output logic trg_c
);

localparam [1:0]
    STATE_IDLE = 2'd0;
    STATE_A = STATE_IDLE + 2'd1;
    STATE_B = STATE_IDLE + 2'd2;
    STATE_C = STATE_IDLE + 2'd3;

logic [1:0] ps, ns;
always_ff @(posedge clk or negedge rst)
begin
    if (!rst)
        ps <= STATE_IDLE;
    else
        ps <= ns;
end

always_comb
begin
    ns = ps;
    trg_a = 0;
    trg_b = 0;
    trg_c = 0;
    
    case (ps)
        STATE_IDLE:
            ns = STATE_A;
        
        STATE_A: begin
            if (a) trg_a = 1;
            ns = STATE_B;
        end

        STATE_B: begin
            if (b) trg_b = 1;
            ns = STATE_C;
        end

        STATE_C: begin
            if (c) trg_c = 1;
            ns = STATE_A;
        end
    endcase
end

endmodule