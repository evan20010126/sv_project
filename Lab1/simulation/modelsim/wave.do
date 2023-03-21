onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider {TOP LEVEL INPUTS}

#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/reset

add wave -noupdate -format Logic /test_student_id/clk
add wave -noupdate -format Logic /test_student_id/reset
add wave -noupdate -format Literal -radix Hexadecimal /test_student_id/seven_seg

add wave -noupdate -divider {cpu}




