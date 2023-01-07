`timescale 1ns/10ps

module cpu (
    input clk,
    input reset,
    // output [13:0] IR
    output logic [7:0] w_q
);
    logic [10:0] pc_next, pc_q;
    logic [10:0] mar_q;
    logic load_pc, load_mar;
    logic [13:0] rom_out;
    logic [3:0] ps, ns;
    logic reset_IR, load_IR;
    logic [13:0] ir_q;
    logic [3:0] op;
    logic load_w;

    logic sel_pc;


    /* pc */
    assign pc_next = pc_q + 1;

    always_ff @(posedge clk) begin
        if (reset)
            pc_q <= #1 0;
        else if(load_pc)
            if (sel_pc)
                pc_q <= #1 ir_q[10:0];
            else
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
    Program_Rom ROM_unit(
        .Rom_data_out(rom_out),
        .Rom_addr_in(mar_q)
    );

    /* IR */
    always_ff @(posedge clk) begin
        if (reset_IR)
            ir_q <= #1 0;
        else if(load_IR)
            ir_q <= #1 rom_out;
    end

    /* SRAM */
    logic ram_en;
    logic [7:0] ram_out;
    logic [7:0] alu_q;
    assign d = ir_q[7];

    single_port_ram_128x8 RAM_unit(
        .data(alu_q),
        .addr(ir_q[6:0]),
        .ram_en(ram_en),
        .clk(clk),
        .q(ram_out) // check
    );

    /* sel_alu */
    logic sel_alu;
    logic [7:0] mux1_out;
    always_comb
    begin
        if (sel_alu)
            mux1_out = ram_out[7:0];
        else
            mux1_out = ir_q[7:0];
    end

    /* ALU */
    // logic [7:0] w_q; output
    always_comb
    begin
        case(op)
            // 
            0: alu_q = mux1_out[7:0] + w_q;
            1: alu_q = mux1_out[7:0] - w_q;
            2: alu_q = mux1_out[7:0] & w_q;
            3: alu_q = mux1_out[7:0] | w_q;
            4: alu_q = mux1_out[7:0] ^ w_q;
            5: alu_q = mux1_out[7:0];
            //
            6: alu_q = mux1_out[7:0] + 1;
            7: alu_q = mux1_out[7:0] - 1;
            8: alu_q = 0;
            9: alu_q = ~mux1_out[7:0];
            default: alu_q = mux1_out[7:0] + w_q;
        endcase
    end

    /* w register */
    always_ff @(posedge clk)
    begin
        if (reset)
            w_q <= #1 0;
        else if(load_w)
            w_q <= #1 alu_q;
    end

    /* decoder */
    assign movlw = (ir_q[13:8] == 6'h30);
    assign addlw = (ir_q[13:8] == 6'h3E);
    assign sublw = (ir_q[13:8] == 6'h3C);
    assign andlw = (ir_q[13:8] == 6'h39);
    assign iorlw = (ir_q[13:8] == 6'h38);
    assign xorlw = (ir_q[13:8] == 6'h3A);
    //
    assign addwf = (ir_q[13:8] == 6'h07);
    assign andwf = (ir_q[13:8] == 6'h05);
    assign clrf = (ir_q[13:7] == 7'b00_0001_1);
    assign clrw = (ir_q[13:2] == 12'b00_0001_0000_00);
    assign comf = (ir_q[13:8] == 6'h09);
    assign decf = (ir_q[13:8] == 6'h03);
    assign goto = (ir_q[13:11] == 3'b101);

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
    parameter T4 = 4;
    parameter T5 = 5;
    parameter T6 = 6;

    always_comb begin
        load_mar = 0;
        load_pc = 0;
        reset_IR = 0;
        load_IR = 0;
        ns = T0;
        load_w = 0;
        op = 0;

        sel_pc = 0;
        sel_alu = 0;
        ram_en = 0;

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
                ns = T4;
            end
            T4:
            begin
                if (movlw) 
                    begin
                        op = 5;
                        load_w = 1; 
                    end
                else if (addlw) 
                    begin 
                        op = 0;
                        load_w = 1;
                    end
                else if (sublw)
                    begin 
                        op = 1;
                        load_w = 1;
                    end
                else if (andlw)
                    begin 
                        op = 2;
                        load_w = 1;
                    end
                else if (iorlw) 
                    begin
                        op = 3;
                        load_w = 1;
                    end
                else if (xorlw) 
                    begin 
                        op = 4;
                        load_w = 1;
                    end
                else if (addwf) 
                    begin 
                        op = 0;
                        sel_alu = 1;
                        if (d == 0)
                            load_w = 1;
                        else
                            ram_en = 1;
                    end
                else if (andwf) 
                    begin
                        op = 2;
                        sel_alu = 1;
                        if (d == 0)
                            load_w = 1;
                        else
                            ram_en = 1;
                    end
                else if (clrf) 
                    begin
                        op = 8;
                        ram_en = 1;
                    end
                else if (clrw) 
                    begin
                        op = 8;
                        load_w = 1;                        
                    end
                else if (comf) 
                    begin 
                        op = 9;
                        sel_alu = 1;
                        ram_en =1;
                    end
                else if (decf) 
                    begin
                        op = 7;
                        sel_alu = 1;
                        ram_en = 1;
                    end
                else if (goto) 
                    begin 
                        sel_pc = 1;
                        load_pc = 1;
                    end
                ns = T5;
            end
            T5:
            begin
                ns = T6;
            end
            T6:
            begin
                ns = T1;
            end
        endcase
    end

endmodule