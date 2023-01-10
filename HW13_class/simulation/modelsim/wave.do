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
add wave -noupdate -radix unsigned /testbench/cpu_test/RAM_unit/ram22
add wave -noupdate -radix unsigned /testbench/cpu_test/RAM_unit/ram36
add wave -noupdate -radix unsigned /testbench/cpu_test/RAM_unit/ram37
add wave -noupdate -radix unsigned /testbench/cpu_test/port_b_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {750000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 229
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {3219120 ps}
