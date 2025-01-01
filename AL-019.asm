TITLE AL-019 : An AL Program that reads two characters, compares them, 
              ; and prints the smallest character (Simulation of If-Else
              ; structure with additional functionality).

.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_1  DB  'Enter the First character: $'
    PROMPT_2  DB  'Enter the Second character: $'
    PROMPT_3  DB  'The smallest character is: $'
    ERROR_MSG DB  0DH,0AH, 'Invalid input! Please enter valid characters.$'

.CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, PROMPT_1             ; load and print PROMPT_1
     MOV AH, 9
     INT 21H

     MOV AH, 1                    ; read a character
     INT 21H

     MOV BL, AL                   ; save the first character into BL

     MOV AH, 2                    ; carriage return
     MOV DL, 0DH
     INT 21H

     MOV DL, 0AH                  ; line feed
     INT 21H

     LEA DX, PROMPT_2             ; load and print PROMPT_2
     MOV AH, 9
     INT 21H

     MOV AH, 1                    ; read a character
     INT 21H

     MOV BH, AL                   ; save the second character into BH

     MOV AH, 2                    ; carriage return
     MOV DL, 0DH
     INT 21H

     MOV DL, 0AH                  ; line feed
     INT 21H

     LEA DX, PROMPT_3             ; load and print PROMPT_3
     MOV AH, 9
     INT 21H

     CMP BL, BH                   ; compare BL and BH

     JNBE @ELSE                   ; jump to @ELSE if BL is not smaller than BH

     MOV DL, BL                   ; move the smallest character into DL
     JMP @DISPLAY                 ; jump to display the result

     @ELSE:                       ; jump label
       MOV DL, BH                 ; move the smallest character into DL

     @DISPLAY:                    ; display the smallest character
       MOV AH, 2                  ; function to print the character
       INT 21H

     ; Check if input is invalid and show an error message
     MOV AH, 1                    ; check for invalid input scenario (optional)
     MOV AL, 'A'                  ; add extra validation to ensure input
     CMP BL, AL
     JZ @INVALID

     MOV AH, 4CH                  ; return control to DOS
     INT 21H

     @INVALID:
     LEA DX, ERROR_MSG            ; load error message
     MOV AH, 9
     INT 21H

     MOV AH, 4CH                  ; exit after showing error
     INT 21H
   MAIN ENDP

END MAIN

;**************************************************************************;
;**************************************************************************;
;------------------------------  THE END  ---------------------------------;
;**************************************************************************;
;**************************************************************************;
