module single_port_ram_128x8(
    input [7:0] data,
    input [6:0] addr,
    input ram_en,
    input clk,
    input reset,
    output [7:0] q
);

    logic [7:0] ram[127:0];
    // assign ram[36] = 0;
    // assign ram[37] = 0;

    always_ff @(posedge clk)
    begin
        // write
        if (ram_en)
            ram[addr] <= data;
    end

    assign q = ram[addr];

    logic [7:0] ram36;
    logic [7:0] ram37;
    assign ram36 = ram[36];
    assign ram37 = ram[37];
endmodule