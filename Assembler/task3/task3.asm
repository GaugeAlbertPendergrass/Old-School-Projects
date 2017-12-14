;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;	Header user for information to anyone who reads.
;	Name:			Gauge Pendergrass
;	Date:			3/1/2016
;	File-name:		task3
;	To Compile:		nasm -f elf 32 'file-name'.asm && gcc -m32 'file-name'.o -o 'exec-name'
;	To Save and Exit:	':x', with 'ESC' used to go back to command line && 'A' used to insert
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;

;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
	;Define statements for system calls, in case they are used throughout the program.
	%define	STDOUT		1
	%define	SYS_EXIT	1
	%define	SYS_WRITE	4
	%define SYS_READ	3
	%define	STDIN		0
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
	;Section for initalized data.
	SECTION	.data
			;prompt to ask the user for their name
			ask_name:	db	"Please enter what you would like to be called: ", 0
			
			;prompt to ask the user for a number
			ask_number:	db	"Please enter a signed or unsigned number: ", 0

			;Thank you prompt
			thanks:		db	"Thank you, ", 0

			;thank you prompt#2 to make a sentence as required
			thanks2:	db	", Your number for this program is: ", 0

			;space command for readability
			space:		db	10, 0
			
			;format for string used in printf and scanf
			format_string:	db	"%s", 0
			
			;format for ints used in printf and scanf
			format_int:	db	"%d", 0
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
	;section for uninitalized data
	SECTION	.bss
			;reserves 60 bytes for the name input
			name		resb	60
		
			;reserves a double word of 1, or 8 bytes for the number input
			number		resd	1
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;


;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
	;section for Program
	SECTION	.text
		
		;how to delcare the c funtion: printf
		extern	printf
		
		;how to declare the c funtion: scanf
		extern	scanf

		;how to declare the main to be used like a c program instead os start
		global	main
	
	;starts main function
	main:
		;asks user for name using push and pop on stack
		push	ask_name
		push	format_string
		call	printf
		add	ESP, 8
		
		;takes in the name from user, using the stack
		push	name
		push	format_string
		call	scanf
		add	ESP, 8
		
		;asks the user for a number
		push	ask_number
		push	format_string
		call	printf
		add	ESP, 8
		
		;takes in number from user
		push	number
		push	format_int
		call	scanf
		add	ESP, 8

		;move the inputed number into EAX for manipulation
		mov	EAX, [number]
		
		;move the inputed number into EAX for manipulation
		mov	EBX, [number]

		;imul used for signed ints

		;mul EAX by EBX, so input number X input number
		;stores the result into EAx
		imul	EAX, EBX

		;imul again the new EAX times the original number inputed
		imul	EAX, EBX
				
		;imul again the NEWER EAX times the original number inputed
		imul	EAX, EBX

		;imul the EAX by 3
		imul	EAX, 3
	
		;move EAX, into ECX, so i can use EAX again
		mov	ECX, EAX
		
		;mov the inputed number into EAX
		mov	EAX, [number]

		;imul the inputed number by the inputed number
		imul	EAX, EAX

		;imul the new EAX by original inputed number
		imul	EAX, EBX
		
		;imul EAX by 2
		imul	EAX, 2

		;subtract the first messed with number that was in EAX and is now in ECX, by the number EAX
		;made by the lines above
		sub	ECX, EAX

		;mov this subtracted number into EDX again for storage
		mov	EDX, ECX

		;move the inputed number into EAX
		mov	EAX, [number]
		
		;imul EAX by 7
		imul	EAX, 7

		;add the number that was in ECX and now is in EDX with EAX
		add	EDX, EAX

		;add 4 to the answer from above
		add	EDX, 4
		
		;move EDX into EBX, because I know EAX and ECX get touched with printf
		;I know EBX does not
		mov	EBX, EDX
		
		;push my first thank you message to screen
		push	thanks
		push	format_string
		call	printf
		add	ESP, 8
			
		;push user inputed name to screen
		push	name
		push	format_string
		call	printf
		add	ESP, 8

		;push my 2nd thank you message to screen
		push 	thanks2
		push	format_string
		call	printf
		add	ESP, 8
		
		;push the now manipulated number to the screen that we stored in EBX from above
		push 	EBX
		push	format_int
		call	printf
		add	ESP, 8

		;Add a newline for readability
		push	space
		push	format_string
		call	printf
		add	ESP, 8


		;return to exit gracefully
		ret
;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;
