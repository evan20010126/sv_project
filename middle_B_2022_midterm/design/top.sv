module top(
	input clk, 
	input rst, 
	output logic [7:0] W_q
);
	

/////////////////
	logic [10:0] pc_next, pc_q, cnt; // ok
	logic load_pc; // ok

	always_ff @(posedge clk)
	begin
		if (rst)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end

    logic [10:0] mar_q;
    logic load_mar;

    logic [15:0] rom_out, Rom_out; // ok
	
	logic [3:0] ps, ns; // ok
    logic reset_IR, load_reg; // load_reg ok
	logic load_w; // load_w is ok
	/*rom output 16bits ok*/
	logic [3:0] a, a_q;
	logic [3:0] b, b_q;
	logic [3:0] c, c_q;
	logic [3:0] d, d_q;

	
	/*sel_mult ok*/
	logic sel_mult0;
	logic [1:0] sel_mult1;

	logic [7:0] x, y; // ok
	logic [1:0] op;
	logic [7:0] w, s; // w is 8 bits reg

	assign W_q = w;
	
	assign a_q = a;
	assign b_q = b;
	assign c_q = c;
	assign d_q = d;
	assign Rom_out = rom_out;

    /* pc */
    assign pc_next = pc_q + 1;

    always_ff @(posedge clk) begin
        if (rst)
            pc_q <= #1 0;
        else if(load_pc)
            pc_q <= #1 pc_next;
    end
    
    /* mar */
    // always_ff @(posedge clk) begin
    //     if (rst)
    //         mar_q <= #1 0;
    //     else if(load_mar)
    //         mar_q <= #1 pc_q;
    // end
	always_comb 
	begin
		if (rst)
		mar_q <= 0;
		else
		mar_q <= pc_q;
	end
    /* rom */
    Program_Rom ROM_unit(
        .Rom_data_out(rom_out),
        .Rom_addr_in(mar_q)
    );

    /* reg a b c d */
    always_ff @(posedge clk) begin
        if (reset_IR) begin
            a <= #1 0;
            b <= #1 0;
            c <= #1 0;
            d <= #1 0;
		end
        else if(load_reg) begin
            a <= #1 rom_out[3:0];
            b <= #1 rom_out[7:4];
            c <= #1 rom_out[11:8];
            d <= #1 rom_out[15:12];
		end
    end

	/* sel_mult */
	always_comb begin
		case (sel_mult0)
			1'b0: x = w;
			1'b1: x = {4'h0, a};
		endcase
	end

	always_comb begin
		case (sel_mult1)
			2'b00: y = b;
			2'b01: y = c;
			2'b10: y = d;
		endcase
	end


	/* ALU */
	always_comb begin
		case (op)
			2'b00 : s = x + y; 
			2'b01 : s = x - y;
			2'b10 : s = x * y;
			2'b11 : s = s;
		endcase
	end

	/* w reg */
	always_ff @(posedge clk) begin
		if (load_w)
			w <= #1 s;
	end

    /* state */
    always_ff @(posedge clk) begin
        if (rst)
            ps <= #1 1;
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

    always_comb begin
        load_mar = 0;
        load_pc = 0;
        reset_IR = 0;
 
		load_reg = 0;
        ns = T0;
		sel_mult0 = 0;
		sel_mult1 = 1;
		op = 0;
		load_w = 0;

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
				load_reg = 1;
				load_pc = 1;
                // load_mar = 1;
                ns = T2;
            end 
            T2:
            begin
				sel_mult0 = 1; // a
				sel_mult1 = 2; // d
				op = 0; // +
				load_w = 1;
                ns = T3;
            end
            T3:
            begin
                sel_mult0 = 0; // w
				sel_mult1 = 0; // b
				op = 2; // *
				load_w = 1;
                ns = T4;
            end
			T4:
			begin
				sel_mult0 = 0; // w
				sel_mult1 = 1; // c
				op = 1; // -
				load_w = 1;
				load_reg = 1;
				load_pc = 1;
                ns = T2;
			end
        endcase
    end
/////////////////

endmodule