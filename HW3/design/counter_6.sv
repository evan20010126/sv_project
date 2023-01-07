`timescale 1ns/10ps

module counter_6 (
    input reset,
    input clk,
    input carry_in,
    output logic [3:0] q, /*[2:0] 但因為七段顯示器 宣告成[3:0]*/
    output logic carry_out
);
    
    always_ff @( posedge clk )
    begin
        if (reset) 
            begin
                q<= #1 3'd0;
                carry_out = 1'b0;
            end
        else if (carry_in)
            begin
                carry_out = (q == 3'd4)? 1'b1: 1'b0;
                if  (q == 3'd5)
                    begin
                        q <= #1 3'd0;
                    end
                else
                    begin
                        q <= #1 q + 1;
                    end
            end
        // else carry_out = 1'b0; /*下個數才不會一直進位*/
    end
endmodule