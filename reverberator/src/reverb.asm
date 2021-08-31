; --------------------------------------------------------------------
;	file				reverb.asm
;	author				Grupo 2
;	date				20210830
;	description			Reverberation
; --------------------------------------------------------------------

; -----------------------------------------------------------------
; Constants
; -----------------------------------------------------------------		
N		EQU			256
E1		EQU			0.5
E2		EQU			0.25

; -----------------------------------------------------------------
; X Data Memory
; -----------------------------------------------------------------		
		ORG			X:$0000
		DC			E1
		DC			E2
		
; --------------------------------------------------------------------
; Program Memory
; --------------------------------------------------------------------
			    ORG			P:$E000
          
; ====================================================================
; Given the current sample in X0, the reverberated output is returned
; in A register. The reverberation has a delay of N samples.
; 
; Registers R0 and M0 are used.
;
; @param X0 Current sample
;
; ====================================================================
        
				
		; Initialization of registers
		MOVE	#$0,A
		MOVE	X:#$0000,Y0		; Coeff E1->Y0 
		MOVE	X:#$0001,Y1		; Coeff E2->Y1
		; Read new sample
		; 

		MOVE	A,X1
		MPY		Y1,X1,A		; A = y(n)*E2
		ADD		X0,A		; A = x(n) + y(n)*E2
		; Delay -> A = A(n - M)
		MPY		Y1,X0,A		; A = Delayed output times E1
		ADD		X0,A		; A = y(n) = x(n) + delayed * E1 
		
		
		
        