onerror {resume}
quietly WaveActivateNextPane {} 0

#add wave -noupdate -divider {TOP LEVEL INPUTS}

#add wave -noupdate -format Logic /testbench/clk
#add wave -noupdate -format Logic /testbench/rst



# ------ALU_seven_seg_decoder-------
add wave -noupdate -divider {ALU_seven_seg_decoder}

add wave -noupdate -format Literal -radix Hexadecimal /testbench/ALU_seven_seg_decoder_test/a

add wave -noupdate -format Literal -radix Hexadecimal /testbench/ALU_seven_seg_decoder_test/b

add wave -noupdate -format Literal -radix Binary /testbench/ALU_seven_seg_decoder_test/op

add wave -noupdate -format Literal -radix Binary /testbench/ALU_seven_seg_decoder_test/seg

########################################################################################################
# ------ALU_4bit-------
# add wave -noupdate -divider {ALU_4bit}

# add wave -noupdate -format Literal -radix Hexadecimal /testbench/ALU_4bit_test/a

# add wave -noupdate -format Literal -radix Hexadecimal /testbench/ALU_4bit_test/b

# add wave -noupdate -format Literal -radix Binary /testbench/ALU_4bit_test/op

# add wave -noupdate -format Literal -radix Hexadecimal /testbench/ALU_4bit_test/s

# ------seven_seg_decoder-------
# add wave -noupdate -divider {seven_seg_decoder}

# add wave -noupdate -format Literal -radix Hexadecimal /testbench/seven_seg_decoder_test/a

# add wave -noupdate -format Literal -radix Binary /testbench/seven_seg_decoder_test/y
 

# ------mux-------
# add wave -noupdate -divider {mux}
# add wave -noupdate -format Literal -radix Unsigned 		/testbench/mux8to1_test/a
# add wave -noupdate -format Literal -radix Unsigned 		/testbench/mux8to1_test/sel
# add wave -noupdate -format Literal -radix Unsigned 		/testbench/mux8to1_test/y


# -------Example------
# add wave -noupdate -format Literal -radix Hexadecimal 	/testbench/adder1/b
# add wave -noupdate -format Literal -radix decimal 		/testbench/adder1/s
# add wave -noupdate -format logic				 		/testbench/b\[6\]
# add wave -noupdate -format logic				 		/testbench/b\[5\]
