onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /testbench/c1/ps
add wave -noupdate -radix unsigned /testbench/c1/port_b_out
add wave -noupdate -radix decimal /testbench/c1/port_c_out
add wave -noupdate -radix hexadecimal /testbench/c1/RAM_unit/ram37
add wave -noupdate -radix hexadecimal /testbench/c1/w_q
add wave -noupdate /testbench/c1/portbcsz
add wave -noupdate /testbench/c1/incfeqcsz
add wave -noupdate -radix hexadecimal /testbench/c1/mux1_out
add wave -noupdate /testbench/c1/portbcsz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {71840 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
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
configure wave -timelineunits ps
update
WaveRestoreZoom {1011250 ps} {1301330 ps}
