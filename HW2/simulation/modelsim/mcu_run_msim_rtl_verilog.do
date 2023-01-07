transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/Program_sv/HW2/design {D:/code/Program_sv/HW2/design/sub_8bit.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW2/design {D:/code/Program_sv/HW2/design/mcu.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/HW2/design {D:/code/Program_sv/HW2/design/adder_8bit.sv}

