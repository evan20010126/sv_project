onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}

add wave -noupdate -format Logic /testbench/counter_portAB/clk
add wave -noupdate -format Logic /testbench/counter_portAB/reset

add wave -noupdate -divider {State}
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/ps_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/ns_out

add wave -noupdate -divider {counterB and sum}
add wave -noupdate -format Logic 		/testbench/counter_portAB/cnt_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/b_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/s_out

add wave -noupdate -divider {w register}
add wave -noupdate -format Logic 		/testbench/counter_portAB/load_w_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/w_out

add wave -noupdate -divider {portA and portB}
add wave -noupdate -format Logic 		/testbench/counter_portAB/load_A_out
add wave -noupdate -format Logic 		/testbench/counter_portAB/load_B_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/port_A_out
add wave -noupdate -format Literal -radix Unsigned 		/testbench/counter_portAB/port_B_out









# add wave -noupdate -divider {adder}

# add wave -noupdate -format Literal -radix Unsigned 		/testbench/adder1/a
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]
