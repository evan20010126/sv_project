onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}

add wave -noupdate -format Logic /testbench/counter_ALU/clk
add wave -noupdate -format Logic /testbench/counter_ALU/reset

add wave -noupdate -divider {State}
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/ps_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/ns_out

add wave -noupdate -divider {counterB and sum}
add wave -noupdate -format Logic 		/testbench/counter_ALU/cnt_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/b_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/s_out

add wave -noupdate -divider {w register}
add wave -noupdate -format Logic 		/testbench/counter_ALU/load_w_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/w_out

add wave -noupdate -divider {op}
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_ALU/op_out









# add wave -noupdate -divider {adder}

# add wave -noupdate -format Literal -radix Unsigned 		/testbench/adder1/a
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]
