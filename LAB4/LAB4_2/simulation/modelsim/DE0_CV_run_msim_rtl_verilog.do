transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/LAB4_2/design {D:/code/sv_project/LAB4_2/design/DE0_CV.sv}
vlog -sv -work work +incdir+D:/code/sv_project/LAB4_2/design {D:/code/sv_project/LAB4_2/design/sub_4bit.sv}

