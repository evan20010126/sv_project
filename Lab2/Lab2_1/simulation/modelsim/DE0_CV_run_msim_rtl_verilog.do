transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/Lab2/Lab2_1/design {D:/code/sv_project/Lab2/Lab2_1/design/DE0_CV.sv}
vlog -sv -work work +incdir+D:/code/sv_project/Lab2/Lab2_1/design {D:/code/sv_project/Lab2/Lab2_1/design/sub_4bit.sv}
