`timescale 1ns/10ps
module ALU_seven_seg_decoder(
    input [3:0] a,
    input [3:0] b,
    input op,
    output logic [6:0] seg
);

logic [3:0] temp;

ALU_4bit step1(
    .a(a),
    .b(b),
    .op(op),
    .s(temp)
);

seven_seg_decoder step2(
    .a(temp),
    .y(seg)
);

endmodule