onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP LEVEL INPUTS}
add wave -noupdate -divider cpu
add wave -noupdate /testbench/test/rst
add wave -noupdate /testbench/test/clk
add wave -noupdate /testbench/test/enc
add wave -noupdate /testbench/test/enc_filter
add wave -noupdate /testbench/test/enc_pos
add wave -noupdate /testbench/test/cnt
add wave -noupdate /testbench/test/cnt_meas
add wave -noupdate /testbench/test/enable
add wave -noupdate /testbench/test/load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8403 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
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
WaveRestoreZoom {6307 ps} {17861 ps}
