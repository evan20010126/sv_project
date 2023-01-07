module ALU_4bit (
    input [3:0] a,
    input [3:0] b,
    input op,
    output logic [3:0] s
);

always_comb 
begin
    assign s = op ? (a - b) : a + b;
end

endmodule


