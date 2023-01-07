onerror {resume}
quietly WaveActivateNextPane {} 0

#add wave -noupdate -divider {TOP LEVEL INPUTS}
#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/rst

# ~~~~~~~~~~~~~~~~~Here
add wave -noupdate -divider {reset&clk}
add wave -noupdate -format logic	/testbench/digit0/reset
add wave -noupdate -format logic	/testbench/digit0/clk

add wave -noupdate -divider {digit0}
add wave -noupdate -format Literal -radix unsigned	/testbench/digit0/q
add wave -noupdate -format Literal -radix binary	/testbench/seven_seg_decoder_digit0/y

add wave -noupdate -divider {digit1}
add wave -noupdate -format Literal -radix unsigned	/testbench/digit1/q
add wave -noupdate -format Literal -radix binary	/testbench/seven_seg_decoder_digit1/y

add wave -noupdate -divider {digit2}
add wave -noupdate -format Literal -radix unsigned	/testbench/digit2/q
add wave -noupdate -format Literal -radix binary	/testbench/seven_seg_decoder_digit2/y

add wave -noupdate -divider {digit3}
add wave -noupdate -format Literal -radix unsigned	/testbench/digit3/q
add wave -noupdate -format Literal -radix binary	/testbench/seven_seg_decoder_digit3/y
# ~~~~~~~~~~~~~~~~~

# -------Example------
# <Array> : binary, decimal, Hexadecimal,
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s

# <One bit>
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]