;
;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;	
;
;	Name: 			Gauge Pendergrass
;	Date: 			3/20/2016
;	File-name: 		task4
;	To Compile: 		nasm -f elf 32 'file-name'.asm  THEN  gcc -m32 'file-name'.o -o 'exe-name'
;	To Save and Exit:  	':x', with 'ESC' used to go back to command line && 'A' used to insert
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

		;Varaible for the random number made by the computer
		random:    	dd 	0
		
		;First promt of the program
		prompt:		db	"The computer has generated a number between 100 and 100,000. You must try to guess said number, Please Begin!:  ", 0
	
		;Prompts used to denote large or small later in the program
		small:		db	"Sorry, your number is too small, Please guess again: ", 0
		big:		db	"Sorry, your number is too large, Please guess again: ", 0

		;Ending promts used to make a sentence at the end of the program
		end: 		db	"Congratulations, You guessed the number. ", 0
		attempts1: 	db 	"It only took you, ", 0
		attempts2:	db	", guesses. Please try harder next time.", 10
	

		;Space command for readability
		space:		db	10, 0

		;Format "%s" for string, used in scanf / printf
		format_string:	db	"%s", 0

		;Format "d" for int, used in scanf / printf
		format_int:	db	"%d", 0
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
		
		;Varaible to store what the user might input as their guess
		guess	    resd	1
	
		;Counter basically to keep track of number of guesses
		num_guess   resd        1
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
		
		;All of the external c-functions that we may or may not need for this program
		extern printf
		extern scanf
 		extern time
		extern srand
		extern rand

		;Calling golabl main instead of start is used for the gcc compiler to see the c-functions
		global	main
		

		main:
			;Flushes out whatever might be in EAX
			mov 	EAX, [random]	
			
			;Calculate a random number, and store in secret
			;RDTSC is using the processor clock to get a random time
				RDTSC
			;Math done to set the number made by the computer to the parameters set
			mov 	EDX, 0
			mov 	ECX, 100000
			idiv 	ECX
			mov 	EAX, EDX
			;Puts number within our parameters into EAX
			mov 	[random], EAX
	
			;Sets number of Guesses to 0 so the counter works
			mov 	EAX, 0
			;Puts the variabe into EAX so we can "count" it up later as the user tries to guess
			mov 	[num_guess], EAX

			;Prompt user, tells them what we are doing
			push	prompt
			push	format_string
			call	printf
			add	ESP, 8


			;Recieve guess from user
			;new_guess is label here
			new_guess:
			push	guess
			push	format_int
			call	scanf
			add	ESP, 8


      		
			;Increment # of guesses
			;Counter, since we want to output how many times it took them
			mov 	EAX, [num_guess]
			inc 	EAX

			;Done with a double word to denote size
			mov 	DWORD[num_guess], EAX
			
			;Store the guess in EBX and the secret number in EAX
			;Used in case assembler messes with the registers or what was already in them
			mov 	EAX, [random]
			mov 	EBX, [guess]

			;If positive, guess was too small, and jumps to a label elsewhere
			cmp 	EAX, EBX
			jg 	too_small

			;If negative, guess was too big, and jumps to a label elsewhere
			cmp 	EAX, EBX
			jl 	too_big
			
			;Will only jump if not equal, if equal, will skip to next step
			cmp 	EAX, EBX
		g:	jne 	new_guess

			;Prompt user
			;Sends out the ending message along with number of tries and yada yada
                        push    end
			push    format_string
			call    printf
			add     ESP, 8

			push    attempts1
			push    format_string
			call    printf
			add     ESP, 8
	
			;Output number of guesses
			push    DWORD [num_guess]
			push	format_int
			call	printf
			add	ESP, 8
			
			;More user prompt
			push  	attempts2
			push  	format_string
			call  	printf
			add  	ESP, 8
			;DONE
				ret
			
			;The label that was used above, this is if the user guesses to small then the program recongizes that 
     			too_small:
				push small
				push format_string
				call printf
				add   ESP, 8

				;Moves what is at said location into the registers
				mov EAX, [random]
				mov EBX, [guess]

				;Jumps back to the label g, that is the used to jump and make the user continue guessing
				jmp g

			;The label that was used above, this if if the user guesses too large then the program recognizes that 
			too_big:
				push big
				push format_string
				call printf
				add  ESP, 8

				;Moves what is at said location into the registers
				mov EAX, [random]
				mov EBX, [guess]

				;Jumps back to the label g, that is then used to jump and make the user continue guessing
				jmp g

			

;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
;
;	
