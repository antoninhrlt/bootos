# This file is part of "bootos"
# Under the MIT License
# Copyright (c) 2022 Antonin Hérault

LINKER = ld
ASM = nasm

BIN = build/bootos

_init :
	mkdir -p build/

build : _init $(BIN)

$(BIN) : build/bootsect

build/bootsect : src/bootsect.asm
	$(ASM) -f bin -I src/ -o $@ $<
