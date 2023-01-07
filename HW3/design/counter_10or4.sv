`timescale 1ns/10ps

module counter_10or4 (
    input reset,
    input clk,
    input carry_in,
    input carry_in2,
    input control,
    output logic [3:0] q,
    output logic carry_out
);
    


    always_ff @( posedge clk )
    begin
        if (reset) 
            begin
                q<= #1 4'd0;
                carry_out = 1'b0;
            end
        else if (carry_in && carry_in2)
            begin
                case (control)
                    1'b1:
                        begin
                            carry_out = (q == 4'd2)? 1'b1: 1'b0;
                            if  (q == 4'd3)
                                begin
                                    q <= #1 4'd0;
                                end
                            else
                                begin
                                    q <= #1 q + 1;
                                end
                        end
                    1'b0:
                        begin
                            carry_out = (q == 4'd8)? 1'b1: 1'b0;
                            if  (q == 4'd9)
                                begin
                                    q <= #1 4'd0;
                                end
                            else
                                begin
                                    q <= #1 q + 1;
                                end
                        end
                endcase
            end
        // else carry_out = 1'b0; /*下個數才不會一直進位*/
    end
endmodule