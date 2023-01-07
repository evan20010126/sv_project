`timescale 1ns/10ps

module cpu (
    input clk,
    input reset,
    output [13:0] IR
);
    logic [10:0] pc_next, pc_q;
    logic [10:0] mar_q;
    logic load_pc, load_mar;
    logic [13:0] rom_out;
    logic [3:0] ps, ns;
    logic reset_IR, load_IR;
    logic [13:0] IR_out;

    /* pc */
    assign pc_next = pc_q + 1;

    always_ff @(posedge clk) begin
        if (reset)
            pc_q <= #1 0;
        else if(load_pc)
            pc_q <= #1 pc_next;
    end
    
    /* mar */
    always_ff @(posedge clk) begin
        if (reset)
            mar_q <= #1 0;
        else if(load_mar)
            mar_q <= #1 pc_q;
    end

    /* rom */
    ROM ROM_unit(
        .Rom_data_out(rom_out),
        .Rom_addr_in(mar_q)
    );

    /* IR */
    always_ff @(posedge clk) begin
        if (reset_IR)
            IR_out <= #1 0;
        else if(load_IR)
            IR_out <= #1 rom_out;
    end

    assign IR = IR_out;  

    /* state */
    always_ff @(posedge clk) begin
        if (reset)
            ps <= #1 0;
        else
            ps <= #1 ns;
    end
    

    /* controller */
    parameter T0 = 0;
    parameter T1 = 1;
    parameter T2 = 2;
    parameter T3 = 3;

    always_comb begin
        load_mar = 0;
        load_pc = 0;
        reset_IR = 0;
        load_IR = 0;
        ns = T0;

        case (ps)
            T0: 
            begin
                load_mar = 0;
                load_pc = 0;
                reset_IR = 1;
                ns = T1;
            end
            T1:
            begin
                load_mar = 1;
                ns = T2;
            end 
            T2:
            begin
                load_pc = 1;
                ns = T3;
            end
            T3:
            begin
                load_IR = 1;
                ns = T1;
            end
        endcase
    end

endmodule