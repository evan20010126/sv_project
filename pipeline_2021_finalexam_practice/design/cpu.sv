`timescale 1ns/10ps

module cpu (
    input clk,
    input reset,
    // output [13:0] IR
    output logic [7:0] w_q,
    output logic [7:0] my_led
    // output logic [3:0] ps_test
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


    /* stack */
    logic pop;
    logic push;
    logic [10:0] stack_q;
    Stack stack_unit(
        .stack_out(stack_q),// output logic [10:0] stack_out,
        .stack_in(pc_q),// input [10:0] stack_in,
        .push(push),
        .pop(pop),
        .reset(reset),
        .clk(clk)
    );

    /* w_change k_change */
    logic [10:0] w_change;
    logic [10:0] k_change;
    assign w_change = {3'b0, w_q} - 1;
    assign k_change = {ir_q[8], ir_q[8], ir_q[8:0]} - 1; // sign extension

    /* pc / sel_pc */
    logic [2:0] sel_pc;
    // assign pc_next = pc_q + 1;
    always_comb
    begin
        case (sel_pc)
            3'd0 : pc_next = pc_q + 1;
            3'd1 : pc_next = ir_q[10:0];
            3'd2 : pc_next = stack_q[10:0];
            3'd3 : pc_next = pc_q + k_change;
            3'd4 : pc_next = pc_q + w_change;
            // 2021
            3'd5 : pc_next = pc_q + 1;
            3'd6 : pc_next = pc_q + 2;
        endcase
    end

    always_ff @(posedge clk) begin
        if (reset)
            pc_q <= #1 0;
        else if(load_pc)
            pc_q <= #1 pc_next;
            // if (sel_pc)
            //     pc_q <= #1 ir_q[10:0];
            // else
            //     pc_q <= #1 pc_next;
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
    logic sel_bus;
    logic [7:0] databus;

    single_port_ram_128x8 RAM_unit(
        .data(databus),
        .addr(ir_q[6:0]),
        .ram_en(ram_en),
        .reset(reset),
        .clk(clk),
        .q(ram_out) // check
    );

    /* bcf_mux bsf_mux */
    logic [2:0] sel_bit;
    logic [7:0] bcf_mux;
    logic [7:0] bsf_mux;
    
    always_comb
    begin
        case (sel_bit)
            3'b000: bcf_mux = ram_out & 8'b1111_1110;
            3'b001: bcf_mux = ram_out & 8'b1111_1101;
            3'b010: bcf_mux = ram_out & 8'b1111_1011;
            3'b011: bcf_mux = ram_out & 8'b1111_0111;
            3'b100: bcf_mux = ram_out & 8'b1110_1111;
            3'b101: bcf_mux = ram_out & 8'b1101_1111;
            3'b110: bcf_mux = ram_out & 8'b1011_1111;
            3'b111: bcf_mux = ram_out & 8'b0111_1111;
        endcase
    end

    always_comb
    begin
        case (sel_bit)
            3'b000: bsf_mux = ram_out | 8'b0000_0001;
            3'b001: bsf_mux = ram_out | 8'b0000_0010;
            3'b010: bsf_mux = ram_out | 8'b0000_0100;
            3'b011: bsf_mux = ram_out | 8'b0000_1000;
            3'b100: bsf_mux = ram_out | 8'b0001_0000;
            3'b101: bsf_mux = ram_out | 8'b0010_0000;
            3'b110: bsf_mux = ram_out | 8'b0100_0000;
            3'b111: bsf_mux = ram_out | 8'b1000_0000;
        endcase
    end

    

    /* ram mux */
    logic [1:0] sel_RAM_mux;
    logic [7:0] RAM_mux;
    
    assign sel_bit = ir_q[9:7];
    always_comb
    begin
        case (sel_RAM_mux)
            0: RAM_mux = ram_out;
            1: RAM_mux = bcf_mux;
            2: RAM_mux = bsf_mux;
        endcase
    end

    /* decfsz incfsz */
    assign aluout_zero = (alu_q == 0)? 1'b1: 1'b0;


    /* sel_alu */
    logic sel_alu;
    logic [7:0] mux1_out;
    always_comb
    begin
        if (sel_alu)
            mux1_out = RAM_mux[7:0];
        else
            mux1_out = ir_q[7:0];
    end

    /* ALU */
    // logic [7:0] w_q; output
    always_comb
    begin
        case(op)
            // 
            4'h0: alu_q = mux1_out[7:0] + w_q;
            4'h1: alu_q = mux1_out[7:0] - w_q;
            4'h2: alu_q = mux1_out[7:0] & w_q;
            4'h3: alu_q = mux1_out[7:0] | w_q;
            4'h4: alu_q = mux1_out[7:0] ^ w_q;
            4'h5: alu_q = mux1_out[7:0];
            //
            4'h6: alu_q = mux1_out[7:0] + 1;
            4'h7: alu_q = mux1_out[7:0] - 1;
            4'h8: alu_q = 0;
            4'h9: alu_q = ~mux1_out[7:0];
            //
            4'hA: alu_q = {mux1_out[7], mux1_out[7:1]};
            4'hB: alu_q = {mux1_out[6:0], 1'b0};
            4'hC: alu_q = {1'b0, mux1_out[7:1]};
            4'hD: alu_q = {mux1_out[6:0], mux1_out[7]};
            4'hE: alu_q = {mux1_out[0], mux1_out[7:1]};
            4'hF: alu_q = {mux1_out[3:0], mux1_out[7:4]};

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

    /* sel_bus */
    
    always_comb
    begin
        if (~sel_bus)
            databus <= alu_q;
        else
            databus <= w_q;
    end

    /* Port_b */
    logic [7:0] port_b_out;
    logic load_port_b;
    always_ff @(posedge clk)
        if (reset) port_b_out <= 0;
        else if(load_port_b) port_b_out <= databus;

    assign addr_port_b = (ir_q[6:0] == 7'h0d);

    assign my_led = port_b_out;

    /* Port_c */
    logic [7:0] port_c_out;
    logic load_port_c;
    always_ff @(posedge clk)
        if (reset) port_c_out <= 0;
        else if(load_port_c) port_c_out <= databus;

    assign addr_port_c = (ir_q[6:0] == 7'h0e);

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
    // f 記憶體的內容 // d=0 存到w d=1存到記憶體
    assign incf = (ir_q[13:8] == 6'h0A);
    assign iorwf = (ir_q[13:8] == 6'h04);
    assign subwf = (ir_q[13:8] == 6'h02);
    assign xorwf = (ir_q[13:8] == 6'h06);
    assign movf = (ir_q[13:8] == 6'h08);
    assign movwf = (ir_q[13:7] == 7'b00_0000_1);
    // 
    assign bcf = (ir_q[13:10] == 4'b0100);
    assign bsf = (ir_q[13:10] == 4'b0101);
    assign btfsc = (ir_q[13:10] == 4'b0110);
    assign btfss = (ir_q[13:10] == 4'b0111);
    assign decfsz = (ir_q[13:8] == 6'h0B);
    assign incfsz = (ir_q[13:8] == 6'h0F);
    //
    assign asrf = (ir_q[13:8] == 6'h37);
    assign lslf = (ir_q[13:8] == 6'h35);
    assign lsrf = (ir_q[13:8] == 6'h36);
    assign rlf = (ir_q[13:8] == 6'h0D);
    assign rrf = (ir_q[13:8] == 6'h0C);
    assign swapf = (ir_q[13:8] == 6'h0E);
    //
    assign call = (ir_q[13:11] == 3'b100);
    assign RETURN = (ir_q[13:0] == 14'h0008);
    //
    assign bra = (ir_q[13:9] == 5'b11_001);
    assign brw = (ir_q[13:0] == 14'b00_0000_0000_1011);
    assign nop = (ir_q[13:0] == 14'h0000);
    // 2021
    assign addweqcsz = (ir_q[13:7] == 7'b11_0100_0);
    assign portcxwsz = (ir_q[13:0] == 14'b00_0000_0000_0011);

    /* btfsc btfss skip condition */
    assign btfsc_skip_bit = RAM_mux[ir_q[9:7]] == 0;
    assign btfss_skip_bit = RAM_mux[ir_q[9:7]] == 1;
    assign btfsc_btfss_skip_bit = (btfsc & btfsc_skip_bit) | (btfss & btfss_skip_bit);

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
        //
        sel_pc = 0;
        sel_alu = 0;
        ram_en = 0;
        sel_bus = 0;
        //
        sel_RAM_mux = 0;
        //
        load_port_b = 0;
        load_port_c = 0;
        //
        push = 0;
        pop = 0;
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
                sel_pc = 0; // new pc = pc + 1
                load_pc = 1; // new
                ns = T2;
            end 
            T2:
            begin
                // load_pc = 1; // new
                ns = T3;
            end
            T3:
            begin
                load_IR = 1;
                ns = T4;
            end
            T4:
            begin
                load_mar = 1;
                sel_pc = 0; // new pc = pc + 1
                load_pc = 1; // new
                if (movlw) begin
                    op = 5;
                    load_w = 1; 
                end else if (addlw) begin 
                    op = 0;
                    load_w = 1;
                end else if (sublw) begin 
                    op = 1;
                    load_w = 1;
                end else if (andlw) begin 
                    op = 2;
                    load_w = 1;
                end else if (iorlw) begin
                    op = 3;
                    load_w = 1;
                end else if (xorlw) begin 
                    op = 4;
                    load_w = 1;
                end else if (addwf) begin 
                    op = 0;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else ram_en = 1;
                end else if (andwf) begin
                    op = 2;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else ram_en = 1;
                end else if (clrf) begin
                    op = 8;
                    ram_en = 1;
                end else if (clrw) begin
                    op = 8;
                    load_w = 1;                        
                end else if (comf) begin 
                    op = 9;
                    sel_alu = 1;
                    ram_en =1;
                end else if (decf) begin
                    op = 7;
                    sel_alu = 1;
                    ram_en = 1;
                end else if (incf) begin 
                    op = 6;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else begin
                        ram_en = 1;
                        sel_bus = 0;
                    end
                end else if (iorwf) begin
                    op = 3;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else begin
                        ram_en = 1;
                        sel_bus = 0;
                    end
                end else if (subwf) begin
                    op = 1;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else begin
                        ram_en = 1;
                        sel_bus = 0;
                    end
                end else if (xorwf) begin
                    op = 4;
                    sel_alu = 1;
                    if (d == 0) load_w = 1;
                    else begin
                        ram_en = 1;
                        sel_bus = 0;
                    end
                end else if (movf) begin
                    op = 5;
                    sel_alu = 1;
                    if (d==0) load_w = 1;
                    else begin
                        ram_en = 1;
                        sel_bus = 0;
                    end
                end else if (movwf) begin
                    sel_bus = 1;
                    if (addr_port_b == 1) load_port_b = 1;
                    else if (addr_port_c == 1) load_port_c = 1;
                    else ram_en = 1;
                end else if (bcf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 1;
                    op = 5;
                    sel_bus = 0;
                    ram_en = 1;
                end else if (bsf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 2;
                    op = 5;
                    sel_bus = 0;
                    ram_en = 1;
                end else if (asrf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hA;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (lslf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hB;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (lsrf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hC;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (rlf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hD;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (rrf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hE;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (swapf) begin
                    sel_alu = 1;
                    sel_RAM_mux = 0;
                    op = 4'hF;
                    if (d == 0) load_w = 1;
                    else begin
                        sel_bus = 0;
                        ram_en = 1;
                    end 
                end else if (call) begin
                    push = 1;
                end else if (nop) begin
                    // nothing
                end 
                ns = T5;
            end

            T5:
            begin
                if (goto) begin 
                    sel_pc = 1;
                    load_pc = 1;
                end else if (call) begin
                    sel_pc = 1; 
                    load_pc = 1; 
                end else if (RETURN) begin
                    pop = 1;
                    sel_pc = 2;
                    load_pc = 1;
                end else if (bra) begin
                    load_pc = 1;
                    sel_pc = 3;
                end else if (brw) begin
                    load_pc = 1;
                    sel_pc = 4;
                end

                ns = T6;
            end
            T6:
            begin
                load_IR = 1;

                if (goto) begin
                    reset_IR = 1;
                end else if (call) begin
                    reset_IR = 1;
                end else if (RETURN) begin
                    reset_IR = 1;
                end else if (decfsz) begin
                    if (d == 0) begin
                        sel_alu = 1;
                        op = 7;
                        load_w = 1;
                        if (aluout_zero == 1) reset_IR = 1;
                    end
                    else begin
                        sel_alu = 1;
                        op = 7;
                        ram_en = 1;
                        sel_bus = 0;

                        if (aluout_zero == 1) reset_IR = 1;
                    end
                end else if (incfsz) begin
                    if (d == 0) begin
                        sel_alu = 1;
                        op = 6;
                        load_w = 1;
                        if (aluout_zero == 1)  reset_IR = 1;
                    end
                    else begin
                        sel_alu = 1;
                        op = 6;
                        ram_en = 1;
                        sel_bus = 0;
                        if (aluout_zero == 1) reset_IR = 1;
                    end
                end else if (btfsc | btfss) begin
                    sel_RAM_mux = 0;
                    if (btfsc_btfss_skip_bit == 1) reset_IR = 1;
                end else if (bra) begin
                    reset_IR = 1;
                end else if (brw) begin
                    reset_IR = 1;
                end else if (addweqcsz) begin
                    sel_alu = 1;
                    op = 0; // +
                    if (alu_q == port_c_out) begin
                        load_pc = 1;
                        sel_pc = 5;
                        reset_IR = 1;
                    end                        
                end else if (portcxwsz) begin
                    if (w_q == port_c_out) begin
                        load_pc = 1;
                        sel_pc = 6;
                        reset_IR = 1;
                    end
                end
                

                ns = T4; 
            end
        endcase
    end

endmodule