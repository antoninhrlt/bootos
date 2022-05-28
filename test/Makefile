# This file is part of "bootos"
# Under the MIT License
# Copyright (c) 2022 Antonin Hérault

LINKER = ld
CC = gcc

SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, build/%.o, $(SRC))

KERNEL = build/kernel
BOOTLOADER = ../build/bootos
FLOPPY = build/floppy

.PHONY : _init
_init :
	mkdir -p build/

test : _init $(FLOPPY)

emu : test
	qemu-system-x86_64 -boot a -fda $(FLOPPY)

$(FLOPPY) : $(BOOTLOADER) $(KERNEL)
	cat $^ $< /dev/zero | dd of=$@ bs=512 count=2880

$(KERNEL) : $(OBJ)
	$(LINKER) --oformat binary -Ttext 1000 -o $@ $^ 

build/%.o : %.c
	$(CC) -c -o $@ $<

$(BOOTLOADER) :
	$(MAKE) -C .. build
