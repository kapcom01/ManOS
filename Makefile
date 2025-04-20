default:
	docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-as boot.s -o boot.o
	docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	docker run --rm -it -v .:/src -w /src cross-compile:i686-elf i686-elf-gcc -T linker.ld -o manos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
	# cp manos.bin isodir/boot/
	# docker run --rm -it -v .:/src -w /src cross-compile:i686-elf grub-mkrescue -o manos.iso isodir
	docker run --rm -it -v .:/src -w /src -p 5900:5900 qemu-system-i386 -kernel manos.bin
