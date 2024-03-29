   
AUX		EQU    0
   VARIABLE1	EQU    1
   VARIABLE2	EQU    2
   


MAIN:
    MOVLB   15
    CLRF    ANSELB, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    ANSELC, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    TRISB		; SET PORTB AS OUTPUT
    SETF    TRISC
    CLRF    LATB
 
LOOP:
    BTFSS   PORTC, 0 ;GRAY
    BRA	    RUTINA_A
    BTFSS   PORTC, 1 ;IMPAR
    BRA	    RUTINA_B
    BTFSS   PORTC, 2 ;PAR
    BRA	    RUTINA_C
    BRA	    LOOP
    
RURINA_A: ;RUTINA GRAY
    CLRF    AUX, 1
RA_LOOP:
    BTFSS   PORTC, 3
    INCF    AUX, 1
    BTFSS   PORTC, 4
    DECF    AUX, 1
    BRA	    RA_LOOP
    
RUTINA_B:;IMPAR
    CLRF    AUX, 1
    BSF	    AUX, 0
RB_LOOP:
    MOVF    PORTB, 0
    BTFSS   PORTC, 3
    ADDLW   2
    MOVWF   AUX, 1
    BTFSS   PORTC, 4
    SUBLW   2
    MOVWF   AUX, 1
    BTFSC   AUX, 0
    MOVFF   AUX, LATB
    BTFSS   AUX, 0
    CLRF    LATB
    CALL    DELAY
    BTFSS   PORTC, 1
    BRA	    RUTINA_A
    BTFSS   PORTC, 2
    BRA	    LOOP
    BTFSS   PORTC, 3
    BRA	    RUTINA_C
    BRA	    RB_LOOP
    
RUTINA_C:;PAR
    CLRF    AUX, 1
RC_LOOP:
    MOVF    PORTB, 0
    BTFSS   PORTC, 3
    ADDLW   2
    MOVWF   AUX, 1
    BTFSS   PORTC, 4
    SUBLW   2
    MOVWF   AUX, 1
    BTFSS   AUX, 0
    MOVFF   AUX, LATB
    BTFSC   AUX, 0
    CLRF    LATB
    CALL    DELAY
    BTFSS   PORTC, 1
    BRA	    RUTINA_A
    BTFSS   PORTC, 2
    BRA	    RUTINA_B
    BTFSS   PORTC, 3
    BRA	    LOOP
    BRA	    RC_LOOP
    
    
        
DELAY:
    MOVLW   0xFF
    MOVWF   VARIABLE1
    MOVWF   VARIABLE2
    
LOOP1:
    DECFSZ  VARIABLE2
    GOTO    LOOP1
    DECFSZ  VARIABLE1
    GOTO    LOOP1
    RETURN


