.ORIG x3000

MAINFUNCTION
    LEA R0, OPENING_MSG             ;DISPLAY OPENING MEESSAGE
    PUTS

    LEA R0, DISK_PROMPT             ;PROMPT USER FOR NUMBER OF DISKS
    PUTS

    GETC                            ;GET USER INPUT AND ECHO IT BACK TO THE SCREEN
    OUT
    
    LD R1, INT_CONVERSION           ;CONVERT ASCII USER INPUT TO DECIMAL AND STORE IT FOR LATER
    NOT R1, R1
    ADD R1, R1, #1          
    ADD R0, R0, R1          

    
    LD R5, STACK_START             ;INTIALIZE R5 TO x5000 (START OF STACK)
    STR R0, R5, #0                 ;STORE USER'S INPUT INTO THE STACK

    
    LD R1, INT_CONVERSION          ;CONVERT USER'S DECIMAL BACK INTO THE ASCII TO PUT IT INSIDE THE INSTRCUTION HEADER
    ADD R0, R0, R1

    
    LEA R1, INSTRUCTIONS_START     ;REPLACE THE "n" IN THE INSTRUCTION HEADER WITH THE USER'S INPUTTED DISK NUMBER
    ADD R1, R1, #10
    ADD R1, R1, #10
    ADD R1, R1, #5          
    STR R0, R1, #0

    LEA R0, INSTRUCTIONS_START     ;PRINT THE REFORMATTED INSTRUCTION HEADER
    PUTS

    
    LD R5, STACK_START            ;INTILIAZE R6 STACK POINTER
    LD R6, STACK_POINTER

    
    LD R1, FIRST_POST              ;LOAD THE POST VALUES INTO R1,R2, AND R3
    LD R2, LAST_POST
    LD R3, MIDDLE_POST

    
    ADD R6, R6, #-1                ;PUSH THE POST VALUES ONTO THE STACK 
    STR R3, R6, #0
    ADD R6, R6, #-1
    STR R2, R6, #0
    ADD R6, R6, #-1
    STR R1, R6, #0

    
    LDR R0, R5, #0                 ;PUSH THE USER'S DISK NUMBER ONTO THE STACK
    ADD R6, R6, #-1
    STR R0, R6, #0

    JSR MOVEDISK                   ;CALL MOVEDISK FUNCTION
    HALT

;STACK ACTIVATION RECORD RIGHT NOW:
    ;R6 = USER'S DISK NUMBER
    ;R6+1 = FIRST_POST (1)
    ;R6+2 = LAST_POST (3)
    ;R6+3 = MIDDLE_POST (2)

MOVEDISK
    ADD R6, R6, #-1                ;PUSH RETURN ADRESS TO STACK
    STR R7, R6, #0                 

    LDR R3, R6, #4                 ;GET ARGUMENTS FROM STACK
    LDR R2, R6, #3    
    LDR R1, R6, #2    
    LDR R0, R6, #1    

    ADD R0, R0, #-1                ;IF USER ENTERED 1 DISK, BREAK TO BASECASE
    BRz BASECASE
    ADD R0, R0, #1    

    
    ADD R6, R6, #-1                ;ELSE BEGIN FIRST RECURSION:
    STR R2, R6, #0                      ;MIDDLE = LAST
    ADD R6, R6, #-1                     ;LAST = MIDDLE
    STR R3, R6, #0                      ;FIRST = FIRST
    ADD R6, R6, #-1                     ;USER'S DISKS = USER'S DISKS - 1 
    STR R1, R6, #0  
    ADD R0, R0, #-1
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR MOVEDISK

    
    JSR PSOLSTEP                   ;CALL PRINT FUNCTION TO PRINT INSTRUCTION

    
    LDR R3, R6, #4                 ;BEGIN THE SECOND RECURSION (SAME LOADING AND PUSHING AS ABOVE):
    LDR R2, R6, #3                      ;MIDDLE = FIRST
    LDR R1, R6, #2                      ;FIRST = MIDDLE
    LDR R0, R6, #1                      ;NEW LAST
                                        ;USER'S DISKS = USER'S DISKS - 1
    ADD R6, R6, #-1
    STR R1, R6, #0  
    ADD R6, R6, #-1
    STR R2, R6, #0  
    ADD R6, R6, #-1
    STR R3, R6, #0  
    ADD R0, R0, #-1
    ADD R6, R6, #-1
    STR R0, R6, #0
    JSR MOVEDISK

    
    LDR R7, R6, #0                  ;RETURN TO MAIN
    ADD R6, R6, #1
    ADD R6, R6, #4
    RET



BASECASE
    JSR PSOLSTEP                    ;PRINT DEFUALT MOVE IF BASE CASE TRIGGERED ABOVE
    LDR R7, R6, #0
    ADD R6, R6, #1
    ADD R6, R6, #4
    RET


            
PSOLSTEP                            ;PRINT FUNCTION
    LEA R0, MOVE_DISK               ;PRINT "Move DISK"
    PUTS

    
    LDR R1, R6, #1
    LD R2, INT_CONVERSION           ;GET DISK NUMBER FROM STACK AND CONVERT TO ASCII
    ADD R1, R1, R2
    ADD R0, R1, #0
    OUT                             ;PRINT DISK NUMBER

        
    LEA R0, FROM_POST               ;PRINT "from post" STRING
    PUTS

    
    LDR R1, R6, #2                  ;GET FIRST POST NUMBER FORM STACK AND CONVERT TO ASCII
    LD R2, INT_CONVERSION
    ADD R1, R1, R2
    ADD R0, R1, #0                  ;PRINT FIRST POST NUMBER
    OUT

    
    LEA R0, TO_POST                 ;PRINT "to post" STRING
    PUTS

    
    LDR R1, R6, #3                  ;GET SECOND POST NUMBER FROM STACK AND CONVERT TO ASCII
    LD R2, INT_CONVERSION
    ADD R1, R1, R2
    ADD R0, R1, #0
    OUT                             ;PRINT SECOND POST NUMBER

    
    LD R0, NEWLINE                  ;PRINT NEWLINE CHARACTER TO END THIS INSTRUCTION LINE
    OUT

    RET                             ;RETURN TO MOVEDISK


;CONSTANTS AND DATA FILLS
FIRST_POST .FILL 1
LAST_POST .FILL 3
MIDDLE_POST .FILL 2
STACK_POINTER .FILL x5000
STACK_START .FILL x5000
INT_CONVERSION .FILL x0030
NEWLINE .FILL x000A

;TEXT PROMPT STRINGS
OPENING_MSG .STRINGZ "--Towers of Hanoi--\n"
DISK_PROMPT .STRINGZ "How many disks? "
INSTRUCTIONS_START .STRINGZ "\n\n\nInstructions to move     disks from post 1 to post 3:\n\n\n"
MOVE_DISK .STRINGZ "Move disk "
FROM_POST .STRINGZ " from post "
TO_POST .STRINGZ " to post "

.END
