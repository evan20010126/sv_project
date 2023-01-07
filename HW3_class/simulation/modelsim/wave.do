onerror {resume}
quietly WaveActivateNextPane {} 0

#add wave -noupdate -divider {TOP LEVEL INPUTS}
#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/rst

add wave -noupdate -format logic				 		/testbench/counter_8_test/reset
add wave -noupdate -format logic				 		/testbench/counter_8_test/clk
add wave -noupdate -format Literal -radix decimal 	/testbench/counter_8_test/q

add wave -noupdate -divider {student_num_test}

add wave -noupdate -format Literal -radix decimal 	/testbench/student_num_test/q

# -------Example------
# <Array> : binary, decimal, Hexadecimal,
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s

# <One bit>
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]