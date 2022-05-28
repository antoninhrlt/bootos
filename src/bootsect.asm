; This file is part of "bootos"
; Under the MIT License
; Copyright (c) 2022 Antonin Hérault

bits 16
org 0x0

    jmp boot
boot:

; Fill remaining space with 0, binary file = 512 Bytes
times 510 - ($ - $$) db 0
dw 0xAA55 ; signature for BIOS, "magic number"
