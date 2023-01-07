onerror {resume}
quietly WaveActivateNextPane {} 0


add wave -noupdate -format Logic /testbench/traffic_light2_test/clk
add wave -noupdate -format Logic /testbench/traffic_light2_test/reset

add wave -noupdate -divider {count}
add wave -noupdate -format Literal -radix unsigned /testbench/traffic_light2_test/count

add wave -noupdate -divider {out}
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/R\[0\]
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/Y\[0\]
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/G\[0\]
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/R\[1\]
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/Y\[1\]
add wave -noupdate -format Literal -radix binary	/testbench/traffic_light2_test/G\[1\]


#add wave -noupdate -divider {TOP LEVEL INPUTS}
#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/rst

# -------Example------
# <Array> : binary, decimal, Hexadecimal,
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s

# <One bit>
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]