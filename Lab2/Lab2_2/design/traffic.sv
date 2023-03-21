module handshaking(
	input logic clk,
    input logic rst,
	output logic [1:0]r,
	output logic [1:0]y,
	output logic [1:0]g
	);
	
    logic [3:0] ps, ns;
    
    always_comb
    begin
        ns = ps + 1;
    end

    always_ff @(posedge clk) 
    begin
        if (rst) begin
            ps <= 0;   
        end else begin
            ps <= ns;
        end
    end

	always_comb
	begin
        case (ps)
            0,1,2,3,4,5: begin
                r[0] = 1;
                y[0] = 0;
                g[0] = 0;
                r[1] = 0;
                y[1] = 0;
                g[1] = 1;
            end
            6,7: begin
                r[0] = 1;
                y[0] = 0;
                g[0] = 0;
                r[1] = 0;
                y[1] = 1;
                g[1] = 0;
            end
            8,9,10,11,12,13: begin
                r[0] = 0;
                y[0] = 0;
                g[0] = 1;
                r[1] = 1;
                y[1] = 0;
                g[1] = 0;
            end
            14,15: begin
                r[0] = 0;
                y[0] = 1;
                g[0] = 0;
                r[1] = 1;
                y[1] = 0;
                g[1] = 0;
            end
            default: begin 
            end
        endcase
	end
	
endmodule