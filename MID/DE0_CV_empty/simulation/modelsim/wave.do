onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP LEVEL INPUTS}
add wave -noupdate -divider top
add wave -noupdate /testbench/top1/arbiter_u1/clk
add wave -noupdate /testbench/top1/arbiter_u1/rst
add wave -noupdate /testbench/top1/arbiter_u1/a
add wave -noupdate /testbench/top1/arbiter_u1/b
add wave -noupdate /testbench/top1/arbiter_u1/c
add wave -noupdate /testbench/top1/arbiter_u1/trg_a
add wave -noupdate /testbench/top1/arbiter_u1/trg_b
add wave -noupdate /testbench/top1/arbiter_u1/trg_c
add wave -noupdate -divider FSM_A
add wave -noupdate -radix unsigned /testbench/top1/mod_a_u1/count_a
add wave -noupdate -divider FSM_B
add wave -noupdate -divider FSM_C
add wave -noupdate /testbench/top1/mod_c_u1/road_light
add wave -noupdate /testbench/top1/mod_c_u1/crosswalk_light
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {2531 ps}
