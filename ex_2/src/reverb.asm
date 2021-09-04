; --------------------------------------------------------------------
;	file					reverb.asm
;	author				Grupo 2
;	date					20210830
;	description		Reverberation
; --------------------------------------------------------------------

; ====================================================================
; reverb
;
; Given the current sample in X0, the reverberated output is returned
; in the A accumulator. The reverberation has a delay of N samples.
; 
; @requires Space of memory to store past samples being pointed by R0
;						with a length or module of M0+1.
; @param 		R1 Pointer to the E1 coefficient in the X space
; @param 		R2 Pointer to the E2 coefficient in the X space
; @param 		X0 Input sample
; @return 	A Output sample
; ====================================================================
					; Compute Y(n) and save it into the accumulator
reverb		MOVE 		X:$1000,Y0				; Y0 = E1
					MOVE 		X:$1001,Y1				; Y1 = E2
					MOVE 		X:(R0),X1				; X1 = W(n-N)
					MPY 		X1,Y0,A					; A = W(n-N).E1
					ADD 		X0,A						; A = W(n-N).E1 + X(n) = Y(n)
					NOP

					; Compute W(n) and save it into the delay buffer
					MOVE 		A,X1						; X1 = Y(n)
					MPY 		X1,Y1,B					; B = Y(n).E2
					ADD 		X0,B						; B = Y(n).E2 + X(n)
					NOP
					MOVE		B,X:(R0)+				; W(n) = Y(n).E2 + X(n)
					
					RTS