#this is a makefile
	
all: task3
	
task3: task3.asm
	nasm -f elf32 task3.asm && gcc -m32 task3.o -o task3

clean:
	rm *.o
	
