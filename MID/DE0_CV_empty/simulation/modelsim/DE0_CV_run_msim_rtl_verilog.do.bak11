transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/MID/DE0_CV_empty/design {D:/code/sv_project/MID/DE0_CV_empty/design/mod_c.sv}
vlog -sv -work work +incdir+D:/code/sv_project/MID/DE0_CV_empty/design {D:/code/sv_project/MID/DE0_CV_empty/design/mod_a.sv}
vlog -sv -work work +incdir+D:/code/sv_project/MID/DE0_CV_empty/design {D:/code/sv_project/MID/DE0_CV_empty/design/top.sv}
vlog -sv -work work +incdir+D:/code/sv_project/MID/DE0_CV_empty/design {D:/code/sv_project/MID/DE0_CV_empty/design/arbiter.sv}

