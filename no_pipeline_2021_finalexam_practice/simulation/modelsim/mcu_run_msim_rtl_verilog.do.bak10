transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/Program_sv/HW11_class2/design {D:/code/Program_sv/HW11_class2/design/single_port_ram_128x8.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW11_class2/design {D:/code/Program_sv/HW11_class2/design/Program_Rom.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW11_class2/design {D:/code/Program_sv/HW11_class2/design/cpu.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW11_class2/design {D:/code/Program_sv/HW11_class2/design/mcu.sv}

