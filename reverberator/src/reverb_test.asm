; -----------------------------------------------------------------
;	file					reverb_test.asm
;	author				Lucas A. Kammann
;	date					20210830
;	description		Testing reverberation routine
; -----------------------------------------------------------------	

; -----------------------------------------------------------------
; Macro Definitions
; -----------------------------------------------------------------	
DELAY_LEN		EQU			    4
INPUT_LEN		EQU			    10

; -----------------------------------------------------------------
; X Data Memory
; -----------------------------------------------------------------		
				      ORG			X:$0000
E1			      DC			0.5
E2						DC			0.5
delay_start		DSM			DELAY_LEN

input			DC			0.1
          DC			0.0
          DC			0.0
          DC			0.0
          DC		  0.0
          DC		  0.0
          DC			0.0
          DC			0.0
          DC			0.0
          DC			0.0

; -----------------------------------------------------------------
; Y Data Memory
; -----------------------------------------------------------------	
				ORG			Y:$0000
output			DC			11
				DC			11
				DC			11
				DC			11
				DC			11
				DC			11
				DC			11
				DC			11
				DC			11
				DC			11

; -----------------------------------------------------------------
; Program Memory
; -----------------------------------------------------------------
				ORG			P:$E000
        INCLUDE	'reverb.asm'

main			EQU			*
				; Initialization of accumulators and registers
				MOVE		#DELAY_LEN-1,M0
				MOVE		#delay_start,R0
				MOVE		#input,R1
				MOVE		#output,R4

				; Main code
				DO			#INPUT_LEN,m_loop
				MOVE		X:(R1)+,X0
				JSR			reverb
				MOVE		A,Y:(R4)+
m_loop
				END			main