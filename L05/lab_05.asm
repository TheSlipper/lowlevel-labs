.386
.MODEL flat, STDCALL

STD_INPUT_HANDLE EQU -10 
STD_OUTPUT_HANDLE EQU -11

ExitProcess PROTO :DWORD

GetStdHandle PROTO :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
wsprintfA PROTO C :VARARG

GetTickCount PROTO
nseed PROTO :DWORD
nrandom PROTO :DWORD

.data
; MISC
spam_content DD 0
rn_ascii DB 10, 13
rinp DD 0
iterator_buffer DD 0
seed_buffer DD 0

output_handle DD 0
input_handle DD 0

; Assignment 1 variables
number_input_string DB "Enter a number: "

num_0_val DD 0
num_0_raw_input DB 10 dup(?)
num_0_chars_read DD 0

num_1_val DD 0
num_1_raw_input DB 10 dup(?)
num_1_chars_read DD 0

equ_msg DB "They are equal"
not_equ_msg DB "They are not equal"

; Assignment 2 variables
below_msg DB "The first number is lower than the latter one"
above_msg DB "The first number is bigger than the latter one"

; Assignment 3 variables
rand_num_3 DD 0
formatted_text_3 DB "Pseudo-random integer: %i", 0
final_output_3 DB 255 dup(?)

; Assignment 4 variables
x_input_text DB "Insert range for the random number: "
guess_text DB "Insert your guess: "

x_val DD 0
x_raw_input DB 10 dup(?)
x_chars_read DD 0

guess_val DD 0
guess_raw_input DD 10 dup(?)
guess_chars_read DD 0

above_text DB "This value is too high!"
below_text DB "This value is too low!"
equal_text DB "You guessed it!"

; Assignment 5 variables

.code

new_line PROC
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET spam_content
	PUSH 2
	PUSH OFFSET rn_ascii
	PUSH output_handle
	call WriteConsoleA
	RET
new_line ENDP

assignment_1 PROC
	
	; ----------------------- Get data from the user -----------------------
	; No. 1
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF number_input_string
	PUSH OFFSET number_input_string
	PUSH output_handle
	call WriteConsoleA
	
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX
	PUSH 0
	PUSH OFFSET num_0_chars_read
	PUSH LENGTHOF num_0_raw_input
	PUSH OFFSET num_0_raw_input
	PUSH input_handle
	call ReadConsoleA

	; No. 2
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF number_input_string
	PUSH OFFSET number_input_string
	PUSH output_handle
	call WriteConsoleA
	
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX
	PUSH 0
	PUSH OFFSET num_1_chars_read
	PUSH LENGTHOF num_1_raw_input
	PUSH OFFSET num_1_raw_input
	PUSH input_handle
	call ReadConsoleA

	; ----------------------- Data conversion to integers -----------------------
	; No. 1
	MOV EDX, OFFSET num_0_raw_input
	ADD EDX, num_0_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_0_raw_input
	CALL atoi
	MOV num_0_val, EAX

	; No. 2
	MOV EDX, OFFSET num_1_raw_input
	ADD EDX, num_1_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_1_raw_input
	CALL atoi
	MOV num_1_val, EAX

	; ----------------------- Checking the condition -----------------------
	MOV EAX, num_0_val
	MOV EBX, num_1_val
	
	CMP EAX, EBX
	JE equal_1
	JMP not_equal_1
	; equ_msg

	equal_1:
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH LENGTHOF equ_msg
		PUSH OFFSET equ_msg
		PUSH output_handle
		CALL WriteConsoleA
	JMP end_1

	not_equal_1:
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH LENGTHOF not_equ_msg
		PUSH OFFSET not_equ_msg
		PUSH output_handle
		CALL WriteConsoleA
	JMP end_1

	end_1:
	RET
assignment_1 ENDP

assignment_2 PROC
	; ----------------------- Get data from the user -----------------------
	; No. 1
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF number_input_string
	PUSH OFFSET number_input_string
	PUSH output_handle
	call WriteConsoleA
	
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX
	PUSH 0
	PUSH OFFSET num_0_chars_read
	PUSH LENGTHOF num_0_raw_input
	PUSH OFFSET num_0_raw_input
	PUSH input_handle
	call ReadConsoleA

	; No. 2
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF number_input_string
	PUSH OFFSET number_input_string
	PUSH output_handle
	call WriteConsoleA
	
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX
	PUSH 0
	PUSH OFFSET num_1_chars_read
	PUSH LENGTHOF num_1_raw_input
	PUSH OFFSET num_1_raw_input
	PUSH input_handle
	call ReadConsoleA

	; ----------------------- Data conversion to integers -----------------------
	; No. 1
	MOV EDX, OFFSET num_0_raw_input
	ADD EDX, num_0_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_0_raw_input
	CALL atoi
	MOV num_0_val, EAX

	; No. 2
	MOV EDX, OFFSET num_1_raw_input
	ADD EDX, num_1_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_1_raw_input
	CALL atoi
	MOV num_1_val, EAX

	; ----------------------- Checking the condition -----------------------
	MOV EAX, num_0_val
	MOV EBX, num_1_val
	
	CMP EAX, EBX
	JE equal_2
	JMP not_equal_2

	equal_2:
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH LENGTHOF equ_msg
		PUSH OFFSET equ_msg
		PUSH output_handle
		CALL WriteConsoleA
	JMP end_2

	not_equal_2:
		JBE below_2

		above_2:
			PUSH STD_OUTPUT_HANDLE
			CALL GetStdHandle
			MOV output_handle, EAX
			PUSH 0
			PUSH OFFSET spam_content
			PUSH LENGTHOF above_msg
			PUSH OFFSET above_msg
			PUSH output_handle
			CALL WriteConsoleA

			JMP end_2
		below_2:
			PUSH STD_OUTPUT_HANDLE
			CALL GetStdHandle
			MOV output_handle, EAX
			PUSH 0
			PUSH OFFSET spam_content
			PUSH LENGTHOF below_msg
			PUSH OFFSET below_msg
			PUSH output_handle
			CALL WriteConsoleA

	end_2:
	RET
assignment_2 ENDP

assignment_3 PROC
	MOV ECX, 10
	CALL GetTickCount
	MOV seed_buffer, EAX

	loop_3:
		MOV iterator_buffer, ECX

		; Get random num
		MOV EAX, seed_buffer
		PUSH EAX
		CALL nseed
		PUSH 20	; Range
		CALL nrandom

		; Save random num and use random num as seed
		MOV rand_num_3, EAX
		MOV seed_buffer, EAX

		; Preprocess the text before output 
		PUSH EAX
		PUSH OFFSET formatted_text_3
		PUSH OFFSET final_output_3
		CALL wsprintfA
		ADD ESP, 12
		MOV rinp, EAX

		; Printing out the string
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH LENGTHOF final_output_3
		PUSH OFFSET final_output_3
		PUSH output_handle
		CALL WriteConsoleA

		MOV ECX, iterator_buffer
	LOOP loop_3

	RET
assignment_3 ENDP

assignment_4 PROC

	; ---------------------- Get X from the user ----------------------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF x_input_text
	PUSH OFFSET x_input_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET x_chars_read
	PUSH LENGTHOF x_raw_input
	PUSH OFFSET x_raw_input
	PUSH input_handle
	CALL ReadConsoleA

	; ---------------------- Convert X to integer ---------------------- 
	MOV EDX, OFFSET x_raw_input
	ADD EDX, x_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET x_raw_input
	CALL atoi
	MOV x_val, EAX


	; ---------------------- Generate random number ---------------------- 
	; MOV EAX, seed_buffer
	; PUSH EAX
	CALL GetTickCount
	PUSH EAX
	CALL nseed
	; TODO: Change the range
	PUSH x_val
	CALL nrandom
	MOV rand_num_3, EAX


	; ---------------------- Game Loop ----------------------
	MOV ECX, 2

	game_loop:
		MOV iterator_buffer, ECX
		; Print out text and get user input
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH LENGTHOF guess_text
		PUSH OFFSET guess_text
		PUSH output_handle
		CALL WriteConsoleA

		PUSH STD_INPUT_HANDLE
		CALL GetStdHandle
		MOV input_handle, EAX
		PUSH 0
		PUSH OFFSET guess_chars_read
		PUSH LENGTHOF guess_raw_input
		PUSH OFFSET guess_raw_input
		PUSH input_handle
		CALL ReadConsoleA

		; Convert the given input to integer
		MOV EDX, OFFSET guess_raw_input
		ADD EDX, guess_chars_read
		MOV AL, 0
		MOV [EDX-2], AL
		PUSH OFFSET guess_raw_input
		CALL atoi
		MOV guess_val, EAX

		MOV EBX, rand_num_3

		CMP EAX, EBX
		JNE not_equal_4
		equal_4:

			PUSH STD_OUTPUT_HANDLE
			CALL GetStdHandle
			MOV output_handle, EAX
			PUSH 0
			PUSH OFFSET spam_content
			PUSH LENGTHOF equal_text
			PUSH OFFSET equal_text
			PUSH output_handle
			CALL WriteConsoleA

			JMP endo

		not_equal_4:
			JA above_4
			below_4:
				PUSH STD_OUTPUT_HANDLE
				CALL GetStdHandle
				MOV output_handle, EAX
				PUSH 0
				PUSH OFFSET spam_content
				PUSH LENGTHOF below_text
				PUSH OFFSET below_text
				PUSH output_handle
				CALL WriteConsoleA
				JMP continue_loop
			
			above_4:
				PUSH STD_OUTPUT_HANDLE
				CALL GetStdHandle
				MOV output_handle, EAX
				PUSH 0
				PUSH OFFSET spam_content
				PUSH LENGTHOF above_text
				PUSH OFFSET above_text
				PUSH output_handle
				CALL WriteConsoleA

	continue_loop:
	CALL new_line
	MOV ECX, iterator_buffer
	ADD ECX, 1
	; LOOP game_loop
	JMP game_loop


	endo:
	RET
assignment_4 ENDP

assignment_5 PROC
	
	RET
assignment_5 ENDP

main PROC	
	; CALL assignment_1		; WORKS
	; CALL assignment_2		; WORKS
	; CALL assignment_3		; WORKS BUT WITH UGLY OUTPUT

	; CALL assignment_4		; WORKS

	PUSH 0
	CALL ExitProcess
main ENDP

atoi proc uses esi edx inputBuffAddr:DWORD
	mov esi, inputBuffAddr
	xor edx, edx
	xor EAX, EAX
	mov AL, BYTE PTR [esi]
	cmp eax, 2dh
	je parseNegative

	.Repeat
		lodsb
		.Break .if !eax
		imul edx, edx, 10
		sub eax, "0"
		add edx, eax
	.Until 0
	mov EAX, EDX
	jmp endatoi

	parseNegative:
	inc esi
	.Repeat
		lodsb
		.Break .if !eax
		imul edx, edx, 10
		sub eax, "0"
		add edx, eax
	.Until 0

	xor EAX,EAX
	sub EAX, EDX
	jmp endatoi

	endatoi:
	ret
atoi endp

END
