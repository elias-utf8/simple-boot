; ======================================================================
; Simple bootloader in 16 bit mode - real mode
; Author : Elias GAUTHIER
; Date : 21/07/2025
; ======================================================================

org 0x7c00					
							 ; lets load first 512 bytes
boot:
    mov ah,0x0e 			 ; write Character in TTY mode
    
    mov si,hello 			 ; point si register to str memory location
.loop1:
    lodsb 					 ; load first char of SI in AL and increment
    or al,al 				 ; is AL == 0 ? (end of string)
    jz .second_string  		 ; if (al == 0) jump to second string
    int 0x10 				 ; runs BIOS interrupt 0x10 to print char
    jmp .loop1

.second_string:
							 ; second loop - display date
    mov si, date
    
.loop2:
    lodsb
    or al,al
    jz halt  				 ; jump to halt when completely done
    int 0x10
    jmp .loop2

halt: 
    cli 					 ; clear interrupt flag
    hlt ; halt execution
   
hello: db "Hello world! ",0
date: db "20/07/2025",0
times 510 - ($-$$) db 0 	 ; pad remaining 510 bytes with zeroes
dw 0xaa55 					 ; magic bootloader magic - 
							 ; marks this 512 byte sector bootable
