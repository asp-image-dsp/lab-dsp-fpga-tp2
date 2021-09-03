;******************************************************************************
                nolist
                INCLUDE 'ioequ.asm'
                INCLUDE 'intequ.asm'
                INCLUDE 'ada_equ.asm'
                INCLUDE 'vectors.asm'
                list
;******************************************************************************
		OPT	CEX			 
Left_ch	        EQU	0
CTRL_WD_12      EQU     MIN_LEFT_ATTN+MIN_RIGHT_ATTN+LIN2+RIN2
CTRL_WD_34      EQU     MIN_LEFT_GAIN+MIN_RIGHT_GAIN
;******************************************************************************
datin           EQU     $FFFF           ; Location in Y memory of input file
datout          EQU     $FFFE           ; Location in Y memory of output file
;******************************************************************************
                ORG     X:$0000
bits		DS	1
N	        EQU     4096
;******************************************************************************	
	        ORG     X:$1000
E1		DC	0.4
E2		DC	0.4
buffer	        DSM	N
;******************************************************************************
                ORG     P:$100
START
main
                MOVEP   #$040006,x:M_PCTL       ; PLL 7 X 12.288 = 86.016MHz
                ORI     #3,mr                   ; Mask interrupts
                MOVEC   #0,sp                   ; Clear hardware stack pointer
                MOVE    #0,omr                  ; Operating mode 0
;******************************************************************************
                MOVE    #0,X0
                MOVE    X0,X:bits
inifil	        MOVE    #buffer,R0              ; Pointer to the delay buffer
                MOVE    #N-1,M0                 ; Size of the delay buffer
                MOVE    #E1,R1               ; Pointer to the E1 coefficient
                MOVE    #E2,R2               ; Pointer to the E2 coefficient
;******************************************************************************
	        MOVEP	#$0001,X:M_HPCR 	; Port B I/O mode select
	        MOVEP	#$0001,X:M_HDDR 	; PB0 out
;******************************************************************************
                JSR     ada_init                ; Initialize codec
		JMP     *	
                INCLUDE 'reverb.asm'								  ;take a nap
                INCLUDE 'ada_init.asm'		; Used to include codec initialization routines
                END