`timescale 1ns/10ps

module cas_counter_10 (
    input reset,
    input carry_in,
    output logic [3:0] q,
    output logic carry_out
);
    
    always_ff @( posedge carry_in, posedge reset )
    begin
        if (reset) 
            begin
                q<= #1 4'd0;
                carry_out = 1'b0;
            end
        else
            begin
                carry_out = (q == 4'd9)? 1'b1: 1'b0; /*告訴十位數字下一次要進位了*/
                if  (q == 4'd9)
                    begin
                        q <= #1 4'd0;
                    end
                else
                    begin
                        q <= #1 q + 1;
                    end
            end
    end
endmodule