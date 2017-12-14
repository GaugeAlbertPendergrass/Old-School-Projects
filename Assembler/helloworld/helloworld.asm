;
; Name: Gauge Pendergrass
; Date: 1/27/2016
; File-name: Assembler Trials -- helloworld.asm
; To Compile: nasm -f elf64 helloworld.asm then  -o helloworld helloworld.o

;
;
  %define  STDOUT     1
  %define  SYS_EXIT   1
  %define  SYS_WRITE  4
;
;
  SECTION  .data
	        message:  db  "Hello, World!", 10
	        length    equ  $ - message
;
;
  SECTION  .bss
                ; nothing needed here
;
;
  SECTION  .text
                global  _start
  _start:
	  ; write the string to stdout (the screen)
	  mov         EAX, SYS_WRITE
	  mov         EBX, STDOUT
	  mov         ECX, message
          mov         EDX, length
	  int         80h

	  ; exit the program gracefully
	  mov         EAX, SYS_EXIT
	  mov         EBX, 0
	  int         80h
;
;
