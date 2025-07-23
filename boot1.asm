; Simple bootloader in 16 bit mode
; Author : Elias GAUTHIER
; Date : 21/07/2025

; This simple bootloader is a very simple demonstration of 
; whats is going on when you press the power button ! 

; Here we will write two string with two loops to reach
; each character of string.

org 0x7c00 ; Lets load first 512 bytes

boot:
    mov ah,0x0e ; Write Character in TTY mode
    
    mov si,hello ; Point "si" register to str memory location
.loop1:
    lodsb ; Load the first char of SI in AL and increment SI
    or al,al ; Is Al == 0 ? (end of string)
    jz .second_string  ; If (al == 0) jump to second string
    int 0x10 ; Runs BIOS interrupt 0x10 to print char
    jmp .loop1

.second_string:
    ; Second loop - display date
    mov si, date
    
.loop2:
    lodsb
    or al,al
    jz halt  ; Jump to halt when completely done
    int 0x10
    jmp .loop2

halt:
    cli ; Clear interrupt flag
    hlt ; Halt execution
   
hello: db "Hello world! ",0
date: db "20/07/2025",0
times 510 - ($-$$) db 0 ; pad remaining 510 bytes with zeroes
dw 0xaa55 ; magic bootloader magic - marks this 512 byte sector bootable!
