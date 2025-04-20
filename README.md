### References:

Experimenting with Operating System development using the following material:
1. https://wiki.osdev.org/GCC_Cross-Compiler
2. https://wiki.osdev.org/Bare_Bones

### Preparation:

1. Build compiler docker image
2. Build qemu docker image

### Build ManOS:

```
docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-as boot.s -o boot.o
docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-gcc -T linker.ld -o manos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
```

### Run in qemu:

```
docker run --rm -it -v .:/src -w /src -p 5900:5900 qemu-system-i386 -kernel manos.bin
```