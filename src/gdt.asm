; This file is part of "bootos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

init_gdt_pointer:
    mov ax, gdt_end
    mov bx, gdt
    sub ax, bx
    mov word [gdt_ptr], ax

    ; Performs calculation to retrieve the GDT linear address
    xor eax, eax
    xor ebx, ebx
    mov ax, ds
    mov ecx, eax
    shl ecx, 4
    mov bx, gdt
    add ecx, ebx
    mov dword [gdt_ptr + 2], ecx

    ret

; Data
gdt: db 0, 0, 0, 0, 0, 0, 0, 0
gdt_cs: db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10011011b, 11011111b, 0x0
gdt_ds: db 0xFF, 0xFF, 0x0, 0x0, 0x0, 10010011b, 11011111b, 0x0
gdt_end:
;--------------------------------------------------------------------
gdt_ptr:
    dw 0 ; limitation
    dd 0 ; base
