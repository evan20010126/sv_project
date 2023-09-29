#vlib work



# ------------------------------------------------------------
vlog -sv ../tb/tb_spi.sv
vlog -sv  ../../pll.v
vlog -sv  ../../fifo.v
vlog -sv  ../../pll/pll_0002.v
vlog -sv  ../../design/DE0_CV.sv
vlog -sv  ../../design/SPI.sv
vlog -sv  ../../design/SPI_rx.sv
vlog -sv  ../../design/SPI_tx.sv
#vlog -sv  ../../design/SPI_tx.sv
vlog -sv  ../../design/edge_detector.sv
vlog -sv  ../../design/edge_detector_pos.sv

# ------------------------------------------------------------

   
