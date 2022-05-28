; This file is part of "bootos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

bits 16
org 0x0

    jmp init

; Includes have to be done before the jump instruction because program doesn't
; want another instructions before
%include "print.asm"
%include "gdt.asm"
%include "defs.inc"

; Segments initialization at 0x07C0
init :
    mov ax, 0x07C0
    mov ds, ax
    mov es, ax

    mov ax, 0x8000
    mov ss, ax
    mov sp, 0xF000

    jmp boot

boot:
    ; Retrieves boot unit
    mov [boot_drv], dl

    mov si, msg_hello
    call print_chars

    jmp load_kernel

; Finds the right boot device to load the kernel
load_kernel:
    xor ax, ax
    int 0x13

    push es
    mov ax, BASE
    mov es, ax
    mov bx, 0

    mov ah, 2
    mov al, SECTORS ; "how much sectors to load"
    mov ch, 0
    mov cl, 2

    mov dh, 0
    mov dl, [boot_drv]

    int 0x13
    pop es

    mov si, msg_gdt
    call print_chars

    call init_gdt_pointer
    
    mov si, msg_mode
    call print_chars

    jmp protected_mode

protected_mode:
    cli
    lgdt [gdt_ptr] ; load GDT
    or ax, 1
    mov cr0, eax

    jmp call_kernel

; Calls the kernel at 0x1000 in the device found at `load_kernel`
call_kernel:
    mov ax, 0x10
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x9F000

    jmp dword 0x8:0x1000

    ; For kernels that don't loop when problem :
    jmp $

; Data
msg_hello: db "> Loading the kernel ...", 13, 10, 0
msg_gdt: db "> Loading GDT ...", 13, 10, 0
msg_mode: db "> Passing to protected mode ...", 13, 10, 0
boot_drv: db 0

; Fill remaining space with 0, binary file = 512 Bytes
times 510 - ($ - $$) db 0
dw 0xAA55 ; signature for BIOS, "magic number"
