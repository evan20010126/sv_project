onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TestBench
add wave -noupdate /tb_spi/clk
add wave -noupdate /tb_spi/reset
add wave -noupdate /tb_spi/cmd_mosi
add wave -noupdate /tb_spi/cmd_sclk
add wave -noupdate /tb_spi/cmd_ssn
add wave -noupdate /tb_spi/cmd_miso
add wave -noupdate -radix hexadecimal /tb_spi/data_debug
add wave -noupdate -divider DE0_CV
add wave -noupdate /tb_spi/DE0_CV1/CLK_100MHz
add wave -noupdate /tb_spi/DE0_CV1/RESET_N
add wave -noupdate /tb_spi/DE0_CV1/mosi
add wave -noupdate /tb_spi/DE0_CV1/miso
add wave -noupdate /tb_spi/DE0_CV1/ssn
add wave -noupdate -divider SPI
add wave -noupdate -radix hexadecimal /tb_spi/DE0_CV1/SPI/shift_register
add wave -noupdate -divider SPI_rx
add wave -noupdate -divider SPI_tx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10661277 ps} 0} {{Cursor 2} {12982041980 ps} 0}
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
WaveRestoreZoom {0 ps} {20370 ns}
