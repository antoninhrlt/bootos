# This file is part of "bootos"
# Under the MIT License
# Copyright (c) 2022 Antonin Hérault

ASM = nasm

BIN = build/bootos

.PHONY : _init
_init :
	mkdir -p build/

build : _init $(BIN)

$(BIN) : src/bootsect.asm
	$(ASM) -f bin -I src/ -o $@ $<
