transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/Program_sv/HW6_class/design {D:/code/Program_sv/HW6_class/design/seven_seg_decoder.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW6_class/design {D:/code/Program_sv/HW6_class/design/ROM.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW6_class/design {D:/code/Program_sv/HW6_class/design/cpu_seven_seg.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW6_class/design {D:/code/Program_sv/HW6_class/design/cpu.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW6_class/design {D:/code/Program_sv/HW6_class/design/mcu.sv}

