    RADIX	DEC		; SET DECIMAL AS DEFAULT BASE
    PROCESSOR	18F45K50	; SET PROCESSOR TYPE
    #INCLUDE	<p18f45k50.inc>
    
;	***ONLY NEEDED FOR SOFTWARE SIMULATION***
;
   ORG	0			; RESET VECTOR
   GOTO	0X1000
;
   ORG	0X08			; HIGH INTERRUPT VECTOR
   GOTO	0X1008
;
   ORG	0X18			; LOW INTERRUPT VECTOR
   GOTO	0X1018
;
;	***END OF CODE FOR SOFTWARE SIMULATION***
;
;   VARIABLE'S DEFINITION SECTION
;   
VARIABLE1   EQU	    0
VARIABLE2   EQU	    1

;	JUMP VECTORS
;
   ORG	0X1000			; RESET VECTOR
   GOTO	MAIN
   
MAIN:
    MOVLB   15
    CLRF    ANSELB, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    ANSELC, BANKED	; SET ALL PINS AS DIGITAL
    CLRF    TRISB		; SET PORTB AS OUTPUT
    BSF	    TRISC,  0
    CLRF    LATB
    
;
;   MAIN LOOP
;
    
LOOP:
    CLRF    LATB
    BSF	    LATB,  0
    CALL    DELAY
    BCF	    LATB,  0
    CALL    DELAY
    BTFSS   PORTC, 0
    CALL    RUTINA_A_I
    CALL    DELAY
    BRA	    LOOP
    
RUTINA_A_I:
    BSF	    LATB,  7
    CALL    DELAY
  
RUTINA_A_L:
    RRNCF   LATB,  1
    CALL    DELAY
    BTFSC   PORTC, 0
    BRA	    RUTINA_A_L
    RETURN
    
    
    
    
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

;
; CONFIGURATION BITS SETTING, THIS IS REQUIRED TO CONFITURE THE OPERATION OF THE MICROCONTROLLER
; AFTER RESET. ONCE PROGRAMMED IN THIS PRACTICA THIS IS NOT NECESARY TO INCLUDE IN FUTURE PROGRAMS
; IF THIS SETTINGS ARE NOT CHANGED. SEE SECTION 26 OF DATA SHEET. 
;   


; CONFIG1L
  CONFIG  PLLSEL = PLL4X        ; PLL Selection (4x clock multiplier)
  CONFIG  CFGPLLEN = OFF        ; PLL Enable Configuration bit (PLL Disabled (firmware controlled))
  CONFIG  CPUDIV = NOCLKDIV     ; CPU System Clock Postscaler (CPU uses system clock (no divide))
  CONFIG  LS48MHZ = SYS24X4     ; Low Speed USB mode with 48 MHz system clock (System clock at 24 MHz, USB clock divider is set to 4)

; CONFIG1H
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection (Internal oscillator)
  CONFIG  PCLKEN = ON           ; Primary Oscillator Shutdown (Primary oscillator enabled)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  nPWRTEN = OFF         ; Power-up Timer Enable (Power up timer disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable (BOR enabled in hardware (SBOREN is ignored))
  CONFIG  BORV = 190            ; Brown-out Reset Voltage (BOR set to 1.9V nominal)
  CONFIG  nLPBOR = OFF          ; Low-Power Brown-out Reset (Low-Power Brown-out Reset disabled)

; CONFIG2H
  CONFIG  WDTEN = OFF           ; Watchdog Timer Enable bits (WDT disabled in hardware (SWDTEN ignored))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscaler (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = RC1          ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<5:0> pins are configured as analog input channels on Reset)
  CONFIG  T3CMX = RC0           ; Timer3 Clock Input MUX bit (T3CKI function is on RC0)
  CONFIG  SDOMX = RB3           ; SDO Output MUX bit (SDO function is on RB3)
  CONFIG  MCLRE = ON            ; Master Clear Reset Pin Enable (MCLR pin enabled; RE3 input disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset (Stack full/underflow will cause Reset)
  CONFIG  LVP = ON              ; Single-Supply ICSP Enable bit (Single-Supply ICSP enabled if MCLRE is also 1)
  CONFIG  ICPRT = OFF           ; Dedicated In-Circuit Debug/Programming Port Enable (ICPORT disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled)
    
    END