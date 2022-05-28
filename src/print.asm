; This file is part of "bootos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

print_chars:
    push ax
    push bx

    .loop:
        lodsb ; ds:si -> al
        
        ; Check for NULL character
        cmp al, 0 
            jz .print_end
        
        mov ah, 0x0E ; service 0x0E, BIOS 0x10 int
        mov bx, 0x07
        int 0x10 ; BIOS call
        jmp .loop

    .print_end:
        pop bx
        pop ax
        ret
