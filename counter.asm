; counter.asm
;
; Kevin Chen ECE 109
;
; Date Submitted: Mar. 29, 2023
;
; Program 2 Spring 2023 - Displays "0000" on graphic and takes user input to increment, decrement, reset, or print the value on the screen. 
; Program quits when user presses char 'q'. 

        .ORIG   x3000

                AND R0, R0, #0
                AND R1, R1, #0
                AND R2, R2, #0
                AND R3, R3, #0
                AND R4, R4, #0
                AND R5, R5, #0
                AND R6, R6, #0
                AND R7, R7, #0


                ADD R1, R1, #4      ; get digit placement
      

; get digit position
DIGITLOOP       LD R2, Thousdigit
                LD R6, DigA         ; load thousands digit location in R6
                ADD R0, R1, #-4
                BRz CHECKVAL  
                LD R2, Hunsdigit  
                LD R6, DigB         ; load hundreds digit location in R6 
                ADD R0, R1, #-3
                BRz CHECKVAL   
                LD R2, Tensdigit 
                LD R6, DigC         ; load tens digit location in R6 
                ADD R0, R1, #-2
                BRz CHECKVAL
                LD R2, Onesdigit     
                LD R6, DigD         ; load ones digit location in R6 

; check digit value
CHECKVAL        LD R5, Dig0         ; load dig '0' in R5
                LD R0, Dig0off
                ADD R3, R2, R0      ; check if value = 0
                BRz COLORCHECK
                LD R5, Dig1         ; load dig '1' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 1
                BRz COLORCHECK
                LD R5, Dig2         ; load dig '2' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 2
                BRz COLORCHECK
                LD R5, Dig3         ; load dig '3' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 3
                BRz COLORCHECK
                LD R5, Dig4         ; load dig '4' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 4
                BRz COLORCHECK
                LD R5, Dig5         ; load dig '5' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 5
                BRz COLORCHECK
                LD R5, Dig6         ; load dig '6' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 6
                BRz COLORCHECK
                LD R5, Dig7         ; load dig '7' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 7
                BRz COLORCHECK
                LD R5, Dig8         ; load dig '8' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0     ; check if value = 8
                BRz COLORCHECK
                LD R5, Dig9         ; load dig '9' in R5
                ADD R0, R0, #-1
                ADD R3, R2, R0      ; check if value = 9

; print number
COLORCHECK      LD R3, FORTY        ; load 40 in R3 for outer loop
                LD R4, TWOFIVE      ; load 25 in R4 for inner loop
COLORCHANGE     LDR R0, R5, #0
                BRnz GONEXT
                LD R2, white        ; load color white 
                STR R2, R6, #0      ; put color in thousands digit place

GONEXT          ADD R5, R5, #1      ; go to next memory location in digits  
                ADD R6, R6, #1      ; go to next memory location in thousands place
                ADD R4, R4, #-1     ; inner loop
                BRp COLORCHANGE
                LD R2, Add103
                ADD R6, R6, R2
                LD R4, TWOFIVE
                ADD R3, R3, #-1     ; outer loop
                BRp COLORCHANGE
                LD R4, TWOFIVE
                LD R3, FORTY
                LD R5, Dig0
                ADD R1, R1, #-1
                BRp DIGITLOOP
                ADD R1, R1, #4
            
; user input
USERLOOP        GETC
                LD R2, Negq         ; check for 'q'
                ADD R2, R0, R2
                BRz QUIT
                LD R2, Negu         ; check for 'u'
                ADD R2, R0, R2
                BRz INCREMENT
                LD R2, Negd         ; check for 'd'
                ADD R2, R0, R2
                BRz DECREMENT   
                LD R2, Negr         ; check for 'u'
                ADD R2, R0, R2
                BRz RESET
                LD R2, Negp         ; check for 'p'
                ADD R2, R0, R2
                BRz PRINT
                BRnzp USERLOOP

; user enters 'u'
INCREMENT       JSR CLEARSCREEN
                LD R2, Onesdigit    ; load ones counter value to R2     
                ADD R2, R2, #1
                LD R0, Dig10off     ; check edge case 9 --> 10
                ADD R0, R2, R0
                BRz INCEDGEONES
                ST R2, Onesdigit    ; increment ones digit
                BRnzp DIGITLOOP

INCEDGEONES     ADD R2, R2, #-10
                ST R2, Onesdigit    ; '0' in Onesdigit
                LD R2, Tensdigit    ; load Tens digit in R2
                ADD R2, R2, #1
                LD R0, Dig10off     ; check edge case 9 --> 10
                ADD R0, R2, R0
                BRz INCEDGETENS
                ST R2, Tensdigit
                BRnzp DIGITLOOP

INCEDGETENS     ADD R2, R2, #-10
                ST R2, Tensdigit    ; '0' in Tensdigit
                LD R2, Hunsdigit    ; load Hundreds digit in R2
                ADD R2, R2, #1
                LD R0, Dig10off     ; check edge case 9 --> 10
                ADD R0, R2, R0
                BRz INCEDGEHUND
                ST R2, Hunsdigit
                BRnzp DIGITLOOP

INCEDGEHUND     ADD R2, R2, #-10
                ST R2, Hunsdigit    ; '0' in Hunsdigit
                LD R2, Thousdigit   ; load Thousdigit digit in R2
                ADD R2, R2, #1
                LD R0, Dig10off     ; check edge case 9 --> 10
                ADD R0, R2, R0
                BRz INCEDGETHOU
                ST R2, Hunsdigit
                BRnzp DIGITLOOP

INCEDGETHOU     ADD R2, R2, #-10
                ST R2, Thousdigit   ; '0' in Thousdigit
                BRnzp DIGITLOOP

; user enters 'd'
DECREMENT       JSR CLEARSCREEN
                LD R2, Onesdigit    ; load ones counter value to R2     
                ADD R2, R2, #-1
                LD R0, Decoff       ; check edge case 0 --> 9
                ADD R0, R2, R0
                BRz DECEDGEONES
                ST R2, Onesdigit    ; decrement ones digit
                BRnzp DIGITLOOP

DECEDGEONES     ADD R2, R2, #10
                ST R2, Onesdigit    ; '9' in Onesdigit
                LD R2, Tensdigit    ; load Tens digit in R2
                ADD R2, R2, #-1
                LD R0, Decoff       ; check edge case 0 --> 9
                ADD R0, R2, R0
                BRz DECEDGETENS
                ST R2, Tensdigit
                BRnzp DIGITLOOP

DECEDGETENS     ADD R2, R2, #10
                ST R2, Tensdigit    ; '9' in Tensdigit
                LD R2, Hunsdigit    ; load Hundreds digit in R2
                ADD R2, R2, #-1
                LD R0, Decoff       ; check edge case 0 --> 9
                ADD R0, R2, R0
                BRz DECEDGEHUND
                ST R2, Hunsdigit
                BRnzp DIGITLOOP

DECEDGEHUND     ADD R2, R2, #10
                ST R2, Hunsdigit    ; '9' in Hunsdigit
                LD R2, Thousdigit   ; load Thousdigit digit in R2
                ADD R2, R2, #-1
                LD R0, Decoff       ; check edge case 0 --> 9
                ADD R0, R2, R0
                BRz DECEDGETHOU
                ST R2, Thousdigit
                BRnzp DIGITLOOP

DECEDGETHOU     ADD R2, R2, #10
                ST R2, Thousdigit   ; '9' in Thousdigit
                BRnzp DIGITLOOP

; user enters 'r'
RESET           JSR CLEARSCREEN
                LD R0, FORTY8       ; load '0' decimal
                ST R0, Onesdigit
                ST R0, Tensdigit
                ST R0, Hunsdigit
                ST R0, Thousdigit
                BRnzp DIGITLOOP

; user enters 'p'
PRINT           LEA R0, Currprompt
                PUTS
                LD R0, Thousdigit
                OUT
                LD R0, Hunsdigit
                OUT
                LD R0, Tensdigit
                OUT
                LD R0, Onesdigit
                OUT
                BRnzp USERLOOP

; clear screen
CLEARSCREEN     LD R6, DigA         ; load thousands digit location in R6
LOOPOUTER       LD R4, Dig110       ; load 108 to loop
                LD R2, black        ; load color black
LOOPCLEAR       STR R2, R6, #0      ; put color in thousands digit place
                ADD R6, R6, #1      ; go to next memory location in thousands place
                ADD R4, R4, #-1     ; inner loop
                BRp LOOPCLEAR
                LD R2, Dig18        ; offset to new row
                ADD R6, R6, R2
                ADD R3, R3, #-1     ; outer loop
                BRp LOOPOUTER
                LD R4, TWOFIVE
                LD R3, FORTY
                RET 

; user enters 'q' -- quit program
QUIT        LEA R0, Quitprompt
            PUTS
            HALT

; variables
Thousdigit      .FILL	#48
Hunsdigit       .FILL	#48
Tensdigit       .FILL	#48
Onesdigit       .FILL	#48
Dig0off         .FILL	#-48
Dig0            .FILL   x5000   ; dig 0 in digits.obj
Dig1            .FILL   x53E8   ; dig 1 in digits.obj
Dig2            .FILL   x57D0   ; dig 2 in digits.obj
Dig3            .FILL   x5BB8   ; dig 3 in digits.obj
Dig4            .FILL   x5FA0   ; dig 4 in digits.obj
Dig5            .FILL   x6388   ; dig 5 in digits.obj
Dig6            .FILL   x6770   ; dig 6 in digits.obj
Dig7            .FILL   x6B58   ; dig 7 in digits.obj
Dig8            .FILL   x6F40   ; dig 8 in digits.obj
Dig9            .FILL   x7328   ; dig 9 in digits.obj
DigA            .FILL   xD508   ; top left corner of thousands digit
DigB            .FILL   xD523   ; top left corner of hundreds digit
DigC            .FILL   xD544   ; top left corner of tens digit
DigD            .FILL   xD55F   ; top left corner of ones digit
white           .FILL   x7FFF   ; hex color white
black           .FILL   #0   ; hex color black
FORTY           .FILL   #40     ; num rows
TWOFIVE         .FILL   #25     ; num columns
Dig110          .FILL   #110    ; clear screen value
Dig18           .FILL   #18     ; clear screen new row offset
Add103          .FILL   #103    ; new row offset
Negp            .FILL   #-112   ; 'p' decimal value
Negq            .FILL   #-113   ; 'q' decimal value
Negu            .FILL   #-117   ; 'u' decimal value
Negd            .FILL   #-100   ; 'd' decimal value
Negr            .FILL   #-114   ; 'r' decimal value
Quitprompt      .STRINGZ	"\n\nLater Yall!!\n"
Currprompt      .STRINGZ	"\nThe current value is: "
FORTY8          .FILL	#48
Decoff          .FILL	#-47
Dig10off        .FILL	#-58

        .END
