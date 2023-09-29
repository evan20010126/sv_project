
// round-robin arbiter

module arbiter(
	input logic clk, rst,
	input logic a, b, c,
	output logic trg_a, 
	output logic trg_b, 
	output logic trg_c
);
	
	
	 
parameter STATE_IDLE = 0;
parameter STATE_A = 1;
parameter STLL = 4;
parameter STLL1 = 5;
parameter STATE_B = 2;
parameter STATE_C = 3;


logic [1:0] ps, ns;
always_ff @(posedge clk or negedge rst)
begin
    if (rst)
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
            // ns = STLL;
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
	