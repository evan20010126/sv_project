transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/LAB5/LAB5_1/design {D:/code/sv_project/LAB5/LAB5_1/design/Low_Pass_Filter_4ENC.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB5/LAB5_1/design {D:/code/sv_project/LAB5/LAB5_1/design/gen_step_col.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB5/LAB5_1/design {D:/code/sv_project/LAB5/LAB5_1/design/Encoder.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB5/LAB5_1/design {D:/code/sv_project/LAB5/LAB5_1/design/edge_detector.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB5/LAB5_1/design {D:/code/sv_project/LAB5/LAB5_1/design/DE0_CV.sv}

