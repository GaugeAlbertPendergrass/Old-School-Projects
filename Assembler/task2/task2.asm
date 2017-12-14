;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;	Header, spot for my name, and file and other useful information
;
;	Name: Gauge Pendergrass
;	Date: 2/27/2016
;	File-name: task2 (not caps)
;	To compile: nasm -f elf 32 'file-name'.asm  THEN  gcc -m32 'file-name'.o -o 'exe-name'
;	To Save and Exit:  ':x'
;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;

;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;
		;Command Calls / Numbers from System
		%define STDOUT	 	 1
		%define SYS_EXIT 	 1
		%define SYS_WRITE 	 4
		%define SYS_READ	 3
		%define STDIN	  	 0
;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;

;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;
	;Section for initialized data
	SECTION	.data
		;My declared number, declared as a dword, and set to 50
		a:			dd	50
		
		;The prompt to ask user their name, declared as bytes	
		ask_name:		db	"Greetings, Peasant, Please enter your name?: ", 0

		;The prompt to ask user a number, declared as bytes
		ask_number:		db	"Please enter a number between 0 and 123456789 inclusive?: ", 0

		;First Thank you prompt, declared as bytes
		thanks:			db	"Thank you, ", 0
		
		;Second Thank you prompt, declared as bytes
		thanks2:		db	", Your number for this program is: ", 0

		;space command for newline, for readability, declared as bytes
		space:			db	10, 0

		;format "%s" for string, used in scanf / printf
		format_string:		db	"%s", 0

		;format "d" for int, used in scanf / printf
		format_int:		db	"%d", 0
;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;

;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;
	;Section for uninitialized data
	SECTION	.bss
		
		;Define a variable name, reserve the length of byte to 60
		name 		resb	60
		
		;Define a variable name, for a number, reserve double word to 1
		number		resd	1
;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;

;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;
	;Section for the actual program
	SECTION	.text
		;How to call printf function and make it usuable in my program
		extern printf

		;How to call scanf function and make it usuable in my program
		extern scanf

		;calling golabl main instead of start is used for the gcc compiler to see the c-functions
		global	main

		;think of this just like c++
		main:

			;These push and pop commands are how we use the Stack

			;The stack much be used to call printf and scanf functions

			;This line  outputs my first prompt, where I ask the user for their name
			push	ask_name
			;This line sets yup the format from above, "s"
			push	format_string
			;This line calls the function itself
			call	printf
			;This line clears the stack, because we need too
			;ESP is the stack pointer
			;The number gets 4 added for each arguement pushed on
			add	ESP, 8

			;This line gets ready to read input from the user, their name in this case
			push	name
			push	format_string
			;scanf means input, oppisite of printf
			call	scanf
			add	ESP, 8

			;This group does the same as the printf above
			;But, prints my 2nd promt asking for the number
			push	ask_number
			push	format_string
			call	printf
			add	ESP, 8

			;This group does the same as the scanf above
			;But, takes in the number from the user
			push	number
			push	format_int 
			call	scanf
			add	ESP, 8

			;These 2 lines move the user inputed number into registers
			;This is so i can change the number in the program
			;I will be changing EAX
			; EBX, is a placeholder for later in the program
			mov	EAX, [number]
			mov	EBX, [number]

			;ADDing 281 to the input number in EAX
			add	EAX, 281

			;decrementing the input number in EAX
			;three times
			dec	EAX
			dec	EAX
			dec	EAX

			;subtracting my number I declared above from EAX
			sub	EAX, dword [a]
			
			;subtracting 200 from input number in EAX
			sub	EAX, 200
	
			;decrementing input number in EAX
			dec	EAX
				
			;subtracting the stored unchanged input number in EBX
			;FRom the changed input number in EAX
			sub	EAX, EBX

			;subtracting 16 from EAX
			sub	EAX, 16

			;incrementing EAX, twice
			inc	EAX
			inc	EAX

			;assking my declared number into EAX
			add	EAX, dword [a]
			
			;moving the now changed number into EBX, so I can use EAX for print functions
			mov	EBX, EAX

			;Prints out my thank you messages number 1
			push	thanks
			push	format_string
			call	printf
			add	ESP, 8

			;prints out the user inputed name
			push 	name
			push	format_string
			call	printf
			add	ESP, 8

			;prints out my thank you messages number 2
			push	thanks2
			push	format_string
			call	printf
			add	ESP, 8
			
			;prints out the now changed EAX number, from the arithmetic, that I stored in EBX
			push	EBX
			push	format_int
			call	printf
			add	ESP, 8

			;Adds a newline so the program looks cleaner on the linux prompt
			push	space
			push	format_string
			call	printf
			add	ESP, 8

			;use return instead of the old exit gracefully, because we are using main
			;Think of it again like a c++ program
			ret
;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;	
