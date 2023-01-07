`timescale 1ns/10ps

module counter_3 (
    input reset,
    input clk,
    input carry_in,
    input carry_in2,
    input carry_in3,
    output logic [3:0] q, /*[1:0] 但因為七段顯示器 宣告成[3:0]*/
    output logic carry_out
);
    
    always_ff @( posedge clk )
    begin
        if (reset) 
            begin
                q<= #1 2'd0;
                carry_out = 1'b0;
            end
        else if (carry_in && carry_in2 && carry_in3)
            begin
                carry_out = (q == 2'd1)? 1'b1: 1'b0;
                
                if  (q == 2'd2)
                    begin
                        q <= #1 2'd0;
                    end
                else
                    begin
                        q <= #1 q + 1;
                    end
            end
    end
endmodule