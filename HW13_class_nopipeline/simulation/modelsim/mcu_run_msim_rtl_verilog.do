transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/Stack.sv}
vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/single_port_ram_128x8.sv}
vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/seven_seg_decoder.sv}
vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/Program_Rom.sv}
vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/cpu.sv}
vlog -sv -work work +incdir+D:/code/sv_project/HW13_class_nopipeline/design {D:/code/sv_project/HW13_class_nopipeline/design/mcu.sv}

