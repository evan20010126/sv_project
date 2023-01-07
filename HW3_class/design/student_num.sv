`timescale 1ns/10ps

module student_num (
    input [2:0] a,
    output logic [3:0] q
);
    
    always_comb
    begin
        case (a)
            3'd0: q = 4'd0;
            3'd1: q = 4'd0;
            3'd2: q = 4'd9;
            3'd3: q = 4'd5;
            3'd4: q = 4'd7;
            3'd5: q = 4'd2;
            3'd6: q = 4'd0;
            3'd7: q = 4'd2;
        endcase
    end

endmodule