// Designer Mao-Hsu Yen
// 0. 
// +FHDR------------------------------------------------------------------------
// Copyright (c) 2021 XXXXX, Inc. All rights reserved
// ANSER Confidential Proprietary
// -----------------------------------------------------------------------------
// FILE NAME : Low_Pass_Filter.v
// DEPARTMENT : CSE NTOU
// AUTHOR : Mao-Hsu Yen
// AUTHOR’S EMAIL : ymh@mail.ntou.edu.tw
// -----------------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE AUTHOR DESCRIPTION
// 1.0 2021-06-06 initial version
// 2.0
// -----------------------------------------------------------------------------
// KEYWORDS : 
// -----------------------------------------------------------------------------
// PURPOSE : 
//
// -----------------------------------------------------------------------------
// PARAMETERS
//
//	Low_Pass_Filter_4ENC 
//  r_LPF_threshold_enc[9:0]	: 
//  	1. If (r_LPF_threshold_enc[9:0] > 0)  LPF_threshold = r_LPF_threshold_enc X 0.0124 ms 
//		2. If (r_LPF_threshold_enc[9:0] = 0x000, it should be in Bypass.
//		
//
// -----------------------------------------------------------------------------
// REUSE ISSUES
// Reset Strategy : Asynchronous, active high system level reset
// Clock Domains : clk_sys(or clk)
// Critical Timing : N/A
// Test Features : N/A
// Asynchronous I/F : 
// Scan Methodology : N/A
// Instantiations : 
// Synthesizable : Y
// Other : 
// -FHDR------------------------------------------------------------------------

	
//// for encoder 
module Low_Pass_Filter_4ENC
(
	output logic sig_filter,	
	input signal,	
	input [13:0] r_LPF_threshold_enc,  //	Unit : 0.08us  /// 2^3 = 8,  r_LPF_threshold_enc=0 => By Pass
	input clk, 
	input reset
);
//// ---------------- --------------
//  counter[12:0] 	
//  clk =100MHZ 時   cycle time = 1/100M = 0.01 us
//  LPF_threshold: 
//				1. 我們使用 counter[12:0] 的 3 bits counter[2:0] 當成 單位LPF_threshold 為 0.01us x 8 = 0.08 us
//				2. 也就是說低於  LPF_threshold = r_LPF_threshold_enc X 0.08 us  的訊號變化都會被濾掉
//				3. 注意：是信號high or low 維持時間需 > LPF_threshold 才不會被濾掉。
//
//  r_LPF_threshold_enc[9:0]: 
//  	1. If (r_LPF_threshold_enc[9:0] > 0)  LPF_threshold = r_LPF_threshold_enc X 0.01024 ms 
//		2. If (r_LPF_threshold_enc[9:0] = 0x000, it should be in Bypass.
//		
//
//
//// ---------------- internal constants --------------
	parameter N = 13 ;		

	logic [N-1 : 0] counter;							// timing regs
	logic reset_counter;							
	logic LPF_threshold;
	//assign counter
	logic [4:0] q;
	always @(posedge clk)
		begin
			if(~reset)
				begin
					q 				<= 2'b0;
					sig_filter 		<= signal;
					//sig_filter 		<= 0;
					reset_counter 	<= 0;
					LPF_threshold 	<= 0;
				end
			else 
				begin
					q[4:0] 				<= {q[3:0], signal};
					if (LPF_threshold) 	sig_filter <= q[4];
					reset_counter 		<= q[1]^q[0];
					//LPF_threshold 		<= (counter[N-1: 4] >= r_LPF_threshold_enc);
					LPF_threshold 		<= (counter[N-1: 0] >= r_LPF_threshold_enc);
				end
		end
	
	always @(posedge clk)
		begin
			if(~reset | reset_counter)
				counter <= 0;
			else 
				if (~counter[N-1]) counter <= counter + 1;
		end


endmodule
