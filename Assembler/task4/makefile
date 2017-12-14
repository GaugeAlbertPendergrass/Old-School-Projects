#this is a makefile

all: task4

task4:	task4.asm
	nasm -f elf32 task4.asm && gcc -m32 task4.o -o task4

clean:
	rm *.o	 
