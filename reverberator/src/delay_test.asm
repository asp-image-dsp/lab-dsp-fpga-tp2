; -----------------------------------------------------------------
;	file					delay_test.asm
;	author				    Facundo D. Farall
;	date					20210830
;	description		        Testing delay macro
; -----------------------------------------------------------------	

; -----------------------------------------------------------------
; Macro Definitions
; -----------------------------------------------------------------	
DELAY_LEN		EQU			5
INPUT_LEN		EQU			10
			INCLUDE			'delay.asm'

; -----------------------------------------------------------------
; X Data Memory
; -----------------------------------------------------------------		
				ORG			X:$0000
				DC 			0.5
delay_start		DSM			DELAY_LEN

input			DC			1
				DC			2
				DC			3
				DC			4
				DC			5
				DC			6
				DC			7
				DC			8
				DC			9
				DC			10

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
main			EQU			*
				; Initialization of accumulators and registers
				MOVE		#DELAY_LEN-1,M0
				MOVE		#delay_start,R0
				MOVE		#input,R1
				MOVE		#output,R4

				; Main code
				DO			#INPUT_LEN,delay_loop
				MOVE		X:(R1)+,A
				DELAY		A
				MOVE		A,Y:(R4)+
delay_loop
				END			main