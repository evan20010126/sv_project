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


vlog "D:/code/sv_project/LAB3/LAB3_1/pll_sim/pll.vo"

vlog -sv -work work +incdir+D:/code/sv_project/LAB3/LAB3_1/design {D:/code/sv_project/LAB3/LAB3_1/design/handshaking.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB3/LAB3_1/design {D:/code/sv_project/LAB3/LAB3_1/design/DE0_CV.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB3/LAB3_1/design {D:/code/sv_project/LAB3/LAB3_1/design/sub_4bit.sv}
