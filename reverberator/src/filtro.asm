;***************************************************************************

      nolist
      include 'ioequ.asm'
      include 'intequ.asm'
      include 'ada_equ.asm'
      include 'vectors.asm'  
      include 'fir'		;macro que realiza el filtrado en si
	list
  
;******************************************************************************

		OPT	CEX			;Expand DC 


Left_ch	equ	0


CTRL_WD_12      equ     MIN_LEFT_ATTN+MIN_RIGHT_ATTN+LIN2+RIN2
CTRL_WD_34      equ     MIN_LEFT_GAIN+MIN_RIGHT_GAIN

;===========================================================

  

datin   equ     $ffff           ;location in Y memory of input file
datout  equ     $fffe           ;location in Y memory of output file




;========data===========================


        org     y:0

	include 'coef.txt'	;este archivo contiene los coeficientes

        org     x:0
        
bits		ds			1
states  dsm     ntaps           ;filter states



endtap	equ	*

; -----------------------------------------------------------------
; Constants
; -----------------------------------------------------------------		
N	EQU			4096

; -----------------------------------------------------------------
; X Data Memory
; -----------------------------------------------------------------		
	ORG			X:$1000
E1			DC			0.7
E2			DC			0.4
delay_start		DSM			N


        org     p:$100
START
main
        movep   #$040006,x:M_PCTL  ; PLL 7 X 12.288 = 86.016MHz
        ori     #3,mr              ; mask interrupts
        movec   #0,sp              ; clear hardware stack pointer
        move    #0,omr             ; operating mode 0

;==================

				move    #0,X0
				move    X0,x:bits


inifil	move    #delay_start,r0      ;point to filter states
        move    #N-1,m0     ;mod(ntaps)
        move    #coef,r4        ;point to filter coefficients
        move    #ntaps-1,m4     ;mod(ntaps), nro. de coeficientes
	
;========================================


;=====================================
;      Inicializo port b for test
;=====================================

	movep	#$0001,X:M_HPCR 	;Port B I/O mode select
	movep	#$0001,X:M_HDDR 	;PB0 out
       
  

;========================================
 
        jsr     ada_init            ;initialize codec
  
				jmp     *									  ;take a nap

        include 'ada_init.asm'			;used to include codec initialization routines

        end

 