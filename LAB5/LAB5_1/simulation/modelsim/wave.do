onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /testbench/de0_cv1/ens_sys/gen_step_col_1/cnt_meas
add wave -noupdate -radix unsigned /testbench/de0_cv1/ens_sys/gen_step_col_1/r_distance
add wave -noupdate -radix unsigned /testbench/de0_cv1/ens_sys/gen_step_col_1/cnt
add wave -noupdate -radix unsigned /testbench/de0_cv1/ens_sys/gen_step_col_1/mul_result
add wave -noupdate /testbench/de0_cv1/ens_sys/gen_step_col_1/step_col
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {89004900 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 320
configure wave -valuecolwidth 38
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
configure wave -timelineunits ps
update
WaveRestoreZoom {88972700 ps} {89570100 ps}
