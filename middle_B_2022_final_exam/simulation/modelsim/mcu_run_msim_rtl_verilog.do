transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/User/Desktop/Program_sv/final_exam/design {C:/Users/User/Desktop/Program_sv/final_exam/design/mcu.sv}

