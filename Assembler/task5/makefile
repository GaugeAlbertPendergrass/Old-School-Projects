#this is a makefile

all: task5

task5:	task5.asm
	nasm -f elf32 task5.asm && gcc -m32 task5.o -o task5

clean:
	rm *.o
