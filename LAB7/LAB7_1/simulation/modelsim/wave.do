onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP LEVEL INPUTS}
add wave -noupdate -divider LPF
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/rs232_1/rx
add wave -noupdate /testbench/rs232_1/rx_filter
add wave -noupdate /testbench/rs232_1/Low_Pass_Filter_1/reset_counter
add wave -noupdate -radix unsigned -childformat {{{/testbench/rs232_1/Low_Pass_Filter_1/counter[13]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[12]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[11]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[10]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[9]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[8]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[7]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[6]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[5]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[4]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[3]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[2]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[1]} -radix unsigned} {{/testbench/rs232_1/Low_Pass_Filter_1/counter[0]} -radix unsigned}} -subitemconfig {{/testbench/rs232_1/Low_Pass_Filter_1/counter[13]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[12]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[11]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[10]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[9]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[8]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[7]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[6]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[5]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[4]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[3]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[2]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[1]} {-height 15 -radix unsigned} {/testbench/rs232_1/Low_Pass_Filter_1/counter[0]} {-height 15 -radix unsigned}} /testbench/rs232_1/Low_Pass_Filter_1/counter
add wave -noupdate -radix unsigned -childformat {{{/testbench/r_LPF_threshold[13]} -radix unsigned} {{/testbench/r_LPF_threshold[12]} -radix unsigned} {{/testbench/r_LPF_threshold[11]} -radix unsigned} {{/testbench/r_LPF_threshold[10]} -radix unsigned} {{/testbench/r_LPF_threshold[9]} -radix unsigned} {{/testbench/r_LPF_threshold[8]} -radix unsigned} {{/testbench/r_LPF_threshold[7]} -radix unsigned} {{/testbench/r_LPF_threshold[6]} -radix unsigned} {{/testbench/r_LPF_threshold[5]} -radix unsigned} {{/testbench/r_LPF_threshold[4]} -radix unsigned} {{/testbench/r_LPF_threshold[3]} -radix unsigned} {{/testbench/r_LPF_threshold[2]} -radix unsigned} {{/testbench/r_LPF_threshold[1]} -radix unsigned} {{/testbench/r_LPF_threshold[0]} -radix unsigned}} -subitemconfig {{/testbench/r_LPF_threshold[13]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[12]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[11]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[10]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[9]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[8]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[7]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[6]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[5]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[4]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[3]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[2]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[1]} {-height 15 -radix unsigned} {/testbench/r_LPF_threshold[0]} {-height 15 -radix unsigned}} /testbench/r_LPF_threshold
add wave -noupdate /testbench/rs232_1/Low_Pass_Filter_1/LPF_threshold
add wave -noupdate -divider RX
add wave -noupdate -radix hexadecimal /testbench/send_data
add wave -noupdate /testbench/rs232_1/rs232_rx_1/rx_finish
add wave -noupdate -divider Package
add wave -noupdate /testbench/rs232_1/rs232_rx_1/pkg_ok
add wave -noupdate /testbench/rs232_1/rs232_rx_1/pkg_ready
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/head
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/addr
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/data
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/data_r
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/r_w
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/chk_sum
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/tail
add wave -noupdate -divider TX
add wave -noupdate /testbench/rs232_1/rs232_rx_1/tx_req
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_rx_1/tx_data
add wave -noupdate /testbench/rs232_1/rs232_rx_1/tx_ack
add wave -noupdate /testbench/tx_flag
add wave -noupdate -radix hexadecimal /testbench/rs232_1/rs232_tx_1/data
add wave -noupdate /testbench/rs232_1/rs232_tx_1/send_tx_data
add wave -noupdate /testbench/rs232_1/rs232_tx_1/tx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1526464282 ps} 0} {{Cursor 2} {12982041980 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {12038071472 ps} {13926012488 ps}
