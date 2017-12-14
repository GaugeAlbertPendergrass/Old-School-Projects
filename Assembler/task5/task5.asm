;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;
;	Name: 			Gauge Pendergrass
;	Date: 			3/20/2016
;	File-name: 		task5
;	To compile: 		nasm -f elf 32 'file-name'.asm  THEN  gcc -m32 'file-name'.o -o 'exe-name'
;	To Save and Exit:  	':x', with 'ESC' used to go back to the command line && 'A' used to insert
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

		;First prompt to user, explains the program		
		prompt:	      	db		"User, we are, Calculating the first 1000 Primes", 10, 0
		
		;Shows the user we are done
		finished:       db      	"Those are the first 1000 Prime Numbers, Enjoy", 10, 0

		;First Prime
		fp:		db		"1", 10, 0

		;Counter
		count:        	dd  		1 
		
		;First number to calculate
		prime:        	dd 		3 

		;Start of a loop
		;Get it, l for loop
		l:  	      	dd 		2 

		;Number of primes to calculate	
		max:          	dd 		1000

		;space command for readability
		space:	      	db		10, 0

		;format "%s" for string, used in scanf / printf
		format_string:	db		"%s", 0

		;format "d" for int, used in scanf / printf
		format_int:	db		"%d", 0
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

		;Nothing is needed here in this program
		

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
 
		;Calling golabl main, so the c functions can be used
		global	main
		

		main:
			;Shows the first prompt to the user about the program
               	     	push	prompt
			push	format_string
			call	printf
			add	ESP, 8
	
			;A space for readability
			push	space
			push	format_string
			call	printf
			add	ESP, 8
			
			push	fp
			push	format_string
			call	printf
			add	ESP, 8
			

			;If count = 1000
		primes:
			mov 	EAX, [count]
			mov 	EBX, [max]
			cmp 	EBX, EAX
		
			;Jumps to a new label or spot in the program
			je finish
			
		   ;Checks the prime
		   mod:
			mov 	EAX, [prime]
			mov 	EDX, 0
			mov 	ECX, [l]
			idiv 	ECX
			cmp 	EDX, 0

			;Add 2 to next prime number to calculate
			je prime_2

			;If prime % 1 != 0

			;Add  one to l, if prime is greater than l, mod them again
			mov 	EAX, [l]
			inc 	EAX
			mov 	[l], EAX
			mov 	EBX, [prime]
			cmp 	EBX, EAX
			jg mod

			;Once l catches up to the prime number and they never returned 0 for prime % l, print out the prime
			call 	print_count

			;Calculate next prime
			jmp primes

		finish:
			;A space for readability
			push	space
			push	format_string
			call	printf
			add	ESP, 8

			;Means we are finished
			push 	finished
			push 	format_string
			call 	printf
			add 	ESP, 8
		
			;This return is the one that actually exits the program
			ret
				
		;label to be used elsewhere, when called the program jumps to here
		print_count:
 
			;Print the prime
			push 	DWORD[prime]
			push 	format_int
			call 	printf
			add 	ESP, 8

			;Putes a newline/space in for readability
			push 	space
			push 	format_string
			call 	printf
                        add 	ESP, 8
			
			;Add one to counter (Keeps track of how many primes found)		    
			mov 	EAX, [count]
			inc 	EAX
			mov 	DWORD[count], EAX
			
	
			;Add 2 to get the next number we want to calculate
			mov 	EAX, [prime]
			inc 	EAX 
			inc 	EAX
			mov 	[prime], EAX
			
			;Reset i loop to 2
			mov 	EAX, 2
			mov 	[l], EAX

			;This returns returns to a part of the program, not exit the program
			ret 
	
		;Label to be used elsehwere, when called the program jumps to here
		prime_2:
		
			;Add 2 to get next potential prime #
			mov 	EAX, [prime]
			inc 	EAX
			inc 	EAX
			mov 	DWORD[prime], EAX
	
			;Reset loop counter to 2
			mov 	EAX, 2
			mov 	[l], EAX
			jmp 	mod
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;	
