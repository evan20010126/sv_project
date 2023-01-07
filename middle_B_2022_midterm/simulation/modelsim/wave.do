onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate -radix unsigned /testbench/W_q
add wave -noupdate -radix unsigned /testbench/top1/ps
add wave -noupdate -radix hexadecimal /testbench/top1/Rom_out
add wave -noupdate -radix unsigned /testbench/top1/a_q
add wave -noupdate -radix unsigned /testbench/top1/b_q
add wave -noupdate -radix unsigned /testbench/top1/c_q
add wave -noupdate -radix unsigned /testbench/top1/d_q
add wave -noupdate -radix unsigned /testbench/top1/x
add wave -noupdate -radix unsigned /testbench/top1/y
add wave -noupdate -radix unsigned /testbench/top1/s
add wave -noupdate -radix unsigned /testbench/top1/cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {250 ps}
