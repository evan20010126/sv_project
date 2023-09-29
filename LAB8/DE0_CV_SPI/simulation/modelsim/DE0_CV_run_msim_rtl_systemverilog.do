transcript on
if ![file isdirectory DE0_CV_iputf_libs] {
	file mkdir DE0_CV_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "D:/code/sv_project/LAB8/DE0_CV_SPI/pll_sim/pll.vo"

vlog -sv -work work +incdir+D:/code/sv_project/LAB8/DE0_CV_SPI/design {D:/code/sv_project/LAB8/DE0_CV_SPI/design/edge_detector_pos.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB8/DE0_CV_SPI/design {D:/code/sv_project/LAB8/DE0_CV_SPI/design/edge_detector.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB8/DE0_CV_SPI/design {D:/code/sv_project/LAB8/DE0_CV_SPI/design/SPI.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB8/DE0_CV_SPI/design {D:/code/sv_project/LAB8/DE0_CV_SPI/design/DE0_CV.sv}
