onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}
add wave -noupdate -format Logic /testbench/clk
add wave -noupdate -format Logic /testbench/reset

# -------Example------
# <Array> : binary, decimal, Hexadecimal, unsigned
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s

# <One bit>
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]