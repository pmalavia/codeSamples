@Print all even Fibonacci numbers up to 10946 (inclusive)
@Print the sum of the even numbers outputed     

@Written by: Priya Malavia 
      
       .equ SWI_PrStr, 0x69    @ Write a null-ending string 
       .equ SWI_PrInt,0x6b     @ Write an Integer
       .equ Stdout, 1          @ Set output mode to be Output View
       .equ SWI_Exit, 0x11     @ Stop execution
       .global _start
       .text
_start:
       MOV R0, #Stdout        
       LDR R1, =TITLE
       SWI SWI_PrStr
       LDR R1, =NL
       SWI SWI_PrStr
       
       MOV R3, #1
       MOV R4, #1
       LDR R7, =10946
       
LOOP:  CMP R3, R7             @Test if number is larger than 10946       
       BGT EXITLOOP              
       AND R2, R3, #1         @Test if number is even or odd
       CMP R2, #1
       BEQ ODD
       MOV R0, #Stdout        @Print number if even
       MOV R1, R3
       SWI SWI_PrInt
       LDR R1, =NL
       SWI SWI_PrStr
       ADD R6, R3, R6         @Adding even fibonacci numbers together
ODD:   BL FIB          
       MOV R4, R3
       MOV R3, R5
       B LOOP
   
EXITLOOP:
       MOV R0, #Stdout        @Print sum of even fibonacci numbers
       LDR R1, =SUM
       SWI SWI_PrStr
       MOV R1, R6
       SWI SWI_PrInt
       LDR R1, =NL
       SWI SWI_PrStr

       SWI SWI_Exit
       
FIB:                          @Calculate next number in sequence
       ADD R5, R3, R4
       MOV PC, LR
.data
TITLE:   .asciz "EVEN FIBONACCI NUMBERS:"
NL:      .asciz "\n"
SUM:     .asciz "SUM OF NUMBERS: "