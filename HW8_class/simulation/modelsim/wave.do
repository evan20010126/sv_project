onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset

add wave -noupdate -radix unsigned /testbench/cpu_test/ps
add wave -noupdate -radix unsigned /testbench/cpu_test/ns
add wave -noupdate /testbench/cpu_test/load_pc
add wave -noupdate -radix unsigned /testbench/cpu_test/pc_next
add wave -noupdate -radix unsigned /testbench/cpu_test/pc_q
add wave -noupdate /testbench/cpu_test/load_mar
add wave -noupdate -radix unsigned /testbench/cpu_test/mar_q
add wave -noupdate /testbench/cpu_test/load_IR
add wave -noupdate -radix unsigned /testbench/w_q
add wave -noupdate -radix unsigned /testbench/cpu_test/ram_out

# -------Example------
# <Array> : binary, decimal, Hexadecimal,
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s

# <One bit>
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]