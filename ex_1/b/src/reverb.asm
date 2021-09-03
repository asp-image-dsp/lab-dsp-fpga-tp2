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
; Registers R0 and M0 are used.
;
; @param X0 Input sample 
; @return A Output sample
; ====================================================================
			; Initialization of registers

			; Compute Y(n) and save it into the accumulator
			MOVE 		X:$1000,Y0			; Y0 = E1
			MOVE 		X:$1001,Y1			; Y1 = E2
			MOVE 		X:(R0),X1				; X1 = W(n-N)
			MPY 		X1,Y0,A					; A = W(n-N).E1
			ADD 		X0,A						; A = W(n-N).E1 + X(n) = Y(n)

			; Compute W(n) and save it into the delay buffer
			MOVE 		A,X1					; X1 = Y(n)
			MPY 		X1,Y1,B				; B = Y(n).E2
			ADD 		X0,B					; B = Y(n).E2 + X(n)
			MOVE		B,X:(R0)+			; W(n) = Y(n).E2 + X(n)