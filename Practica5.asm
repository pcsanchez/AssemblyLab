   

   RADIX	DEC		; SET DECIMAL AS DEFAULT BASE
    PROCESSOR	18F45K50	; SET PROCESSOR TYPE
    #INCLUDE	<p18f45k50.inc>
    
;;	***ONLY NEEDED FOR SOFTWARE SIMULATION***
;
   ORG	0			; RESET VECTOR
   GOTO	0X1000
;
   ORG	0X08			; HIGH INTERRUPT VECTOR
   GOTO	0X1008
;
   ORG	0X18			; LOW INTERRUPT VECTOR
   GOTO	0X1018
   
   
   AUX	    EQU	    0
    
   


MAIN:
    MOVLB   15
    CLRF    ANSELB, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    ANSELC, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    TRISB		; SET PORTB AS OUTPUT
    SETF    TRISC
    CLRF    LATB
    BSF	    TRISC, 1
    BSF	    LATB, 0
 
LOOP:
    BTFSS   PORTC, 0 ;GRAY
    BRA	    RUTINA_A
    CALL    DELAY
    BTFSS   PORTC, 1 ;IMPAR
    BRA	    RUTINA_B
    CALL    DELAY
    BTFSS   PORTC, 2 ;PAR
    BRA	    RUTINA_C
    
RURINA_A: ;RUTINA GRAY
    BTFSC   PORTC, 3
    CALL    B4
    BTFSC   PORTC, 4
    CALL    B5
    
RUTINA_B:;IMPAR
    BTFSC   PORTC, 3
    CALL    B4
    BTFSC   PORTC, 4
    CALL    B5
    CLRF    LATB
    BTFSC   AUX, 0
    MOVFF   AUX, LATB
    BTFSC   PORTC, 1
    BRA	    RUTINA_A
    BTFSC   PORTC, 2
    BRA	    LOOP
    BTFSC   PORTC, 3
    BRA	    RUTINA_C
    BRA	    RUTINA_B
    
RUTINA_C:;PAR
    BTFSC   PORTC, 3
    CALL    B4
    BTFSC   PORTC, 4
    CALL    B5
    CLRF    LATB
    BTFSS   AUX, 0
    MOVFF   AUX, LATB
    BTFSC   PORTC, 1
    BRA	    RUTINA_A
    BTFSC   PORTC, 2
    BRA	    RUTINA_B
    BTFSC   PORTC, 3
    BRA	    LOOP
    BRA	    RUTINA_C
    
B4: ; MÁS (AUMENTAR +1)
    INCF    AUX, 1
    CALL    DELAY
    RETURN
B5: ; MENOS (RESTAR -1)
    DECF    AUX, 1 
    CALL    DELAY
    RETURN

        
DELAY:
    MOVLW   0xFF
    MOVWF   VARIABLE1
    MOVWF   VARIABLE2
    RETURN
