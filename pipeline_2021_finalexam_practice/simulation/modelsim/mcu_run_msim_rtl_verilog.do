transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/Stack.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/single_port_ram_128x8.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/seven_seg_decoder.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/Program_Rom.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/cpu.sv}
vlog -sv -work work +incdir+D:/code/Program_sv/pipeline_2021_finalexam_practice/design {D:/code/Program_sv/pipeline_2021_finalexam_practice/design/mcu.sv}

