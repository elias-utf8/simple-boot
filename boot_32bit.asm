; ======================================================================
; Simple bootloader in 32 bit mode - protected mode
; Author : Elias GAUTHIER
; Date : 23/07/2025
; ======================================================================

bits 16
org 0x7c00

boot:
    cld                      ; clear direction flag
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00           ; stack pointer
    
    ; enable A20 line (Fast A20 Gate)
    in al, 0x92
    or al, 2
    out 0x92, al
    
    ; Set video mode
    mov ax, 0x0003
    int 0x10
    
    cli                      ; disable interrupts
    lgdt [gdt_pointer]       ; load GDT
    
    mov eax, cr0
    or eax, 1                ; set PE bit
    mov cr0, eax
    
    jmp CODE_SEG:boot32      ; jump to 32-bit code

gdt_start:
    dq 0                     ; null descriptor
    
gdt_code:
    dw 0xFFFF, 0
    db 0, 0x9A, 0xCF, 0
    
gdt_data:
    dw 0xFFFF, 0 
    db 0, 0x92, 0xCF, 0
gdt_end:

gdt_pointer:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

bits 32
boot32:
    mov ax, DATA_SEG         ; setup segments
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, 0x90000         ; setup stack
    
    ; print message
    mov esi, msg
    mov edi, 0xb8000
    mov ah, 0x07             ; color: white on black

print_loop:
    lodsb
    test al, al
    jz halt
    stosw                    ; store AX to [EDI] and increment EDI by 2
    jmp print_loop

halt:
    cli
    hlt
    jmp halt

msg db "Hello 32-bit mode!", 0

; pad to 512 bytes
times 510-($-$$) db 0
dw 0xAA55
