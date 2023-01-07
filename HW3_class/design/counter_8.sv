`timescale 1ns/10ps

module counter_8 (
    input reset,
    input clk,
    output logic [2:0] q
);
    
    always_ff @( posedge clk )
    begin
        if (reset) q<= #1 0;
        else q <= #1 q + 1;
    end

endmodule