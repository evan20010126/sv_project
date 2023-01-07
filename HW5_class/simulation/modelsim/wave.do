onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}

add wave -noupdate -format Logic /testbench/controller2A_test/clk
add wave -noupdate -format Logic /testbench/controller2A_test/reset

add wave -noupdate -divider {Mine}
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/w_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/cnt_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/load_w_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/b_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/s_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/ps_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/controller2A_test/ns_out










# add wave -noupdate -divider {adder}

# add wave -noupdate -format Literal -radix Unsigned 		/testbench/adder1/a
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]
