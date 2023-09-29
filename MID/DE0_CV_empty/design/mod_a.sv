module mod_a(
	input logic clk,
	input logic rst,
	input logic trg_a,
	output logic [3:0] count_a,
    output logic ok
	);
	

logic cp1;
logic a_ps, a_ns;

// cnt_1
always_ff @(posedge clk) begin
    if (rst) count_a <= #1 1;
    else if (cp1) count_a <= #1 count_a + 1;
end


// FSM(controller)
parameter T0 = 0; // stop
parameter T1 = 1; // keepgoing
always_ff @(posedge clk) begin
    if (rst) begin
        a_ps <= #1 T0;
    end
    else begin
        a_ps <= #1 a_ns;
    end
end

always_comb
begin
    cp1 = 0;
    a_ns = 0;

    unique case(a_ps)
        T0: begin
			if (trg_a) a_ns = T1;
			else a_ns = T0;
        end
        T1: begin
			cp1 = 1;
            if (count_a == 4 || count_a == 7) 
            begin
				a_ns = T0; //stop
                ok = 1;
            end
			else
				a_ns = T1;
        end
    endcase
end
























endmodule