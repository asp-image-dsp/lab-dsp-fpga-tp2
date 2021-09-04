; -----------------------------------------------------------------
;	file					fir_test.asm
;	author				    Facundo D. Farall
;	date					20210816
;	description		        Testing impulse response of a FIR filter
; -----------------------------------------------------------------	

; -----------------------------------------------------------------
; Macro Definitions
; -----------------------------------------------------------------	
SAMPLES			EQU			0
INPUT			EQU			$100
OUTPUT			EQU			$100
COEFS			EQU			0
N_S				EQU			8
N_C				EQU			4
ADC				EQU			$50
DAC				EQU			$51

; -----------------------------------------------------------------
; X Data Memory
; -----------------------------------------------------------------		
				ORG			X:SAMPLES
				DC			0
				DC			0
				DC			0
				DC			0
				
				ORG			X:INPUT
				DC			0.5
				DC			0
				DC			0
				DC			0
				DC			0
				DC			0
				DC			0
				DC			0

; -----------------------------------------------------------------
; Y Data Memory
; -----------------------------------------------------------------		
				ORG			Y:COEFS
				DC			0.5
				DC			0.25
				DC			0.125
				DC			0.0625
				
				ORG			Y:OUTPUT
				DC			0.5
				DC			0.5
				DC			0.5
				DC			0.5
				DC			0.5
				DC			0.5
				DC			0.5
				DC			0.5

; -----------------------------------------------------------------
; Program Memory
; -----------------------------------------------------------------
				ORG			P:$E100
fir_iter		EQU			*
				MOVE		Y:ADC,X0
				CLR			A			X0,X:(R0)+		Y:(R4)+,Y0
				REP			#N_C-1
				MAC			X0,Y0,A		X:(R0)+,X0		Y:(R4)+,Y0
				MAC			X0,Y0,A		(R0)-
				MOVE		A,Y:DAC
				RTS


				ORG			P:$E000
main			EQU			*
				; Initialization of accumulators and registers
				MOVE		#SAMPLES,R0
				MOVE		#COEFS,R4
				MOVE 		#N_C-1,M0
				MOVE		#N_C-1,M4
				MOVE		#INPUT,R1
				MOVE		#OUTPUT,R5

				; Main code
				DO			#N_S,FILTER_LOOP
				MOVE		X:(R1)+,X0
				MOVE		X0,Y:ADC
				JSR			fir_iter
				MOVE		Y:DAC,X0
				MOVE		X0,Y:(R5)+
FILTER_LOOP
				END			main