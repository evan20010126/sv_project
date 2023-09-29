module arbiter_polling(
    input logic clk, rst,
    input logic a,b,c,
    output logic a_out,
    output logic b_out,
    output logic c_out
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
    a_out = 0;
    b_out = 0;
    c_out = 0;
    
    case (ps)
        STATE_IDLE:
            ns = STATE_A;
        
        STATE_A: begin
            if (a) a_out = 1;
            ns = STATE_B;
        end

        STATE_B: begin
            if (b) b_out = 1;
            ns = STATE_C;
        end

        STATE_C: begin
            if (c) c_out = 1;
            ns = STATE_A;
        end
    endcase
end

endmodule