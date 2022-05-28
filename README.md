# bootos
Kernel loader in protected mode with GDT initialized, for x64 and x86 operating systems

## Usage
Clone the repository for your project : `git clone https://github.com/antoninhrlt/bootos` (delete the "test/" folder inside "bootos/" because useless)

Your project structure :
```
build/
  - kernel.o
bootos/ (cloned from https://github.com/antoninhrlt/bootos)
src/
  - kernel.c (will gives build/kernel.o)
```

Your Makefile :
```make
# Generates "floppy disk" with the operating system, runnable with "qemu"
floppy : bootos/build/bootos build/kernel
	cat $^ $< /dev/zero | dd of=$@ bs=512 count=2880

# Builds the kernel
build/kernel : build/kernel.o
	ld --oformat binary -Ttext 1000 -o build/kernel build/kernel.o 

build/kernel.o : src/kernel.c
    gcc -c -o $@ $<

# Builds the boot sector
bootos/build/bootos :
    $(MAKE -C .. build)
```

## Build
The project requires [make](https://www.gnu.org/software/make/), "ld" and [nasm](https://www.nasm.us/)
> Test also requires [gcc](https://gcc.gnu.org/)
```bash
# Build the project, giving "build/bootos" output
make build -B 
# Test for a simple kernel using "bootos"
(cd test && make emu -B) 
```
