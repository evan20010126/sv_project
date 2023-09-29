transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/LAB6/LAB6_2/design {D:/code/sv_project/LAB6/LAB6_2/design/bit_trans.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB6/LAB6_2/design {D:/code/sv_project/LAB6/LAB6_2/design/edge_detector.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB6/LAB6_2/design {D:/code/sv_project/LAB6/LAB6_2/design/DE0_CV.sv}

