.386
.MODEL flat, STDCALL

STD_INPUT_HANDLE EQU -10 
STD_OUTPUT_HANDLE EQU -11

ExitProcess PROTO :DWORD

GetStdHandle PROTO :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
wsprintfA PROTO C :VARARG

.data
; MISC
spam_content DD 0
rn_ascii DB 10, 13

output_handle DD 0
input_handle DD 0

; Assignment 1 variables
num_0_value DD 0
num_0_text DB "Enter value for number 1: "
num_0_input DB 10 dup(?)
num_0_read DD 0

num_1_value DD 0
num_1_text DB "Enter value for number 2: "
num_1_input DB 10 dup(?)
num_1_read DD 0

num_2_value DD 0
num_2_text DB "Enter value for number 3: "
num_2_input DB 10 dup(?)
num_2_read DD 0

num_3_value DD 0
num_3_text DB "Enter value for number 4: "
num_3_input DB 10 dup(?)
num_3_read DD 0

; Assignment 2 variables
;	Uses variables from the first assignment
equation_val DD 0

; Assignment 3 variables
;	Uses variables from the first and second assignment
formatted_text DB "a/(b*c)+d = %i / (%i * %i) + %i = %i", 0
final_output DB 255 dup(0)
rinp DD 0
written_chars_0 DD 0

; Assignment 4 variables
bool_0_value DD 0
bool_0_text DB "Enter the first boolean value (0/1): "
bool_0_input DB 10 dup(?)
bool_0_read DD 0

bool_1_value DD 0
bool_1_text DB "Enter the second boolean value (0/1): "
bool_1_input DB 10 dup(?)
bool_1_read DD 0

bool_2_value DD 0
bool_2_text DB "Enter the third boolean value (0/1): "
bool_2_input DB 10 dup(?)
bool_2_read DD 0

bool_3_value DD 0
bool_3_text DB "Enter the fourth boolean value (0/1): "
bool_3_input DB 10 dup(?)
bool_3_read DD 0

bool_result DD 0
bool_text DB "The result of the equation: a XOR (b AND c) OR d = %i XOR (%i AND %i) OR %i = %i", 0
bool_final_output DB 255 dup(?)

; Assignment 5 variables
num_4_value DD 0
num_4_text DB "Enter value for number that is going to be multiplicated by 19 using the left shifting technique: "
num_4_input DB 10 dup(?)
num_4_read DD 0

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

zad_1 PROC
	; --------- 1st data input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF num_0_text
	PUSH OFFSET num_0_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET num_0_read
	PUSH LENGTHOF num_0_input
	PUSH OFFSET num_0_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 2nd data input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF num_1_text
	PUSH OFFSET num_1_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET num_1_read
	PUSH LENGTHOF num_1_input
	PUSH OFFSET num_1_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 3rd data input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET num_2_read
	PUSH LENGTHOF num_2_text
	PUSH OFFSET num_2_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET num_2_read
	PUSH LENGTHOF num_2_input
	PUSH OFFSET num_2_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 4th data input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF num_3_text
	PUSH OFFSET num_3_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET num_3_read
	PUSH LENGTHOF num_3_input
	PUSH OFFSET num_3_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- Conversion of the numbers ---------
	; no. 1
	MOV EDX, OFFSET num_0_input
	ADD EDX, num_0_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_0_input
	CALL atoi
	MOV num_0_value, EAX

	; no. 2
	MOV EDX, OFFSET num_1_input
	ADD EDX, num_1_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_1_input
	CALL atoi
	MOV num_1_value, EAX

	; no. 3
	MOV EDX, OFFSET num_2_input
	ADD EDX, num_2_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_2_input
	CALL atoi
	MOV num_2_value, EAX

	; no. 4
	MOV EDX, OFFSET num_3_input
	ADD EDX, num_3_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_3_input
	CALL atoi
	MOV num_3_value, EAX

	RET
zad_1 ENDP


zad_2 PROC
	; 12 => a/(b*c)+d 
	; for testing: a = 2, b = 1, c = 2, d = 0
	XOR EAX, EAX
	XOR EBX, EBX
	XOR ECX, ECX

	; Multiplication
	MOV EBX, num_2_value
	MOV EAX, num_1_value
	MUL EBX
	
	; Addition
	MOV ECX, num_3_value
	ADD EAX, ECX

	; Division
	MOV spam_content, EAX
	MOV EBX, spam_content
	MOV EAX, num_0_value
	DIV EBX
	MOV equation_val, EAX
	XOR EAX, EAX
	XOR EBX, EBX
	XOR ECX, ECX
	XOR EDX, EDX

	RET
zad_2 ENDP

zad_3 PROC
	; wsprintfa
	MOV EBX, equation_val
	PUSH EBX
	MOV EBX, num_3_value
	PUSH EBX
	MOV EBX, num_2_value
	PUSH EBX
	MOV EBX, num_1_value
	PUSH EBX
	MOV EBX, num_0_value
	PUSH EBX

	PUSH OFFSET formatted_text
	PUSH OFFSET final_output
	CALL wsprintfA

	ADD ESP, 12
	MOV rinp, EAX	; IMPORTANT - WSPRINTFA DOESN'T WORK WITHOUT RINP DECLARED (I think... the resources are scarce so I can't tell)

	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET written_chars_0
	; PUSH LENGTHOF final_output
	PUSH rinp
	PUSH OFFSET final_output
	PUSH output_handle
	CALL WriteConsoleA
	JMP CONT

	RET
zad_3 ENDP

zad_4 PROC
	; --------- 1st bool input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF bool_0_text
	PUSH OFFSET bool_0_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET bool_0_read
	PUSH LENGTHOF bool_0_input
	PUSH OFFSET bool_0_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 2nd bool input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF bool_1_text
	PUSH OFFSET bool_1_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET bool_1_read
	PUSH LENGTHOF bool_1_input
	PUSH OFFSET bool_1_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 3rd bool input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF bool_2_text
	PUSH OFFSET bool_2_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET bool_2_read
	PUSH LENGTHOF bool_2_input
	PUSH OFFSET bool_2_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- 4th bool input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF bool_3_text
	PUSH OFFSET bool_3_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET bool_3_read
	PUSH LENGTHOF bool_3_input
	PUSH OFFSET bool_3_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- Conversion of the numbers ---------
	; no. 1
	MOV EDX, OFFSET bool_0_input
	ADD EDX, bool_0_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET bool_0_input
	CALL atoi
	MOV bool_0_value, EAX

	; no. 2
	MOV EDX, OFFSET bool_1_input
	ADD EDX, bool_1_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET bool_1_input
	CALL atoi
	MOV bool_1_value, EAX

	; no. 3
	MOV EDX, OFFSET bool_2_input
	ADD EDX, bool_2_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET bool_2_input
	CALL atoi
	MOV bool_2_value, EAX

	; no. 4
	MOV EDX, OFFSET bool_3_input
	ADD EDX, bool_3_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET bool_3_input
	CALL atoi
	MOV bool_3_value, EAX

	; --------- Solving the boolean equation ---------
	; No. 12
	MOV EAX, bool_0_value
	MOV EBX, bool_1_value
	MOV ECX, bool_2_value
	MOV EDX, bool_3_value

	AND EBX, ECX
	XOR EAX, EBX
	OR EAX, EDX

	; --------- Equation result ---------
	MOV bool_result, EAX

	MOV EBX, bool_0_value
	PUSH EBX
	MOV EBX, bool_1_value
	PUSH EBX
	MOV EBX, bool_2_value
	PUSH EBX
	MOV EBX, bool_3_value
	PUSH EBX
	MOV EBX, bool_result
	PUSH EBX

	PUSH OFFSET bool_text
	PUSH OFFSET bool_final_output
	CALL wsprintfA

	ADD ESP, 12
	MOV rinp, EAX	; IMPORTANT - WSPRINTFA DOESN'T WORK WITHOUT RINP DECLARED (I think... the resources are scarce so I can't tell)

	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET written_chars_0
	PUSH LENGTHOF bool_final_output
	PUSH OFFSET bool_final_output
	PUSH output_handle
	CALL WriteConsoleA

	JMP CONT_2

	RET
zad_4 ENDP

zad_5 PROC
	; 19=(16+2+1)

	; --------- Number input ---------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF num_4_text
	PUSH OFFSET num_4_text
	PUSH output_handle
	CALL WriteConsoleA

	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET num_4_read
	PUSH LENGTHOF num_4_input
	PUSH OFFSET num_4_input
	PUSH input_handle
	CALL ReadConsoleA

	; --------- Number conversion ---------
	; no. 1
	MOV EDX, OFFSET num_4_input
	ADD EDX, num_4_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_4_input
	CALL atoi
	MOV num_4_value, EAX

	; --------- Left shifting technique ---------
	; e.g.: 5 x 7 = (5 x 4) + (5 x 2) + (5 x 1)
	; here: entered_num x 19 = (entered_num x 16) + (entered_num x 2) + (entered_num x 1)
	; 
	MOV EAX, num_4_value
	MOV EBX, num_4_value
	MOV ECX, num_4_value
	SHL EAX, 15d
	SHL EBX, 1d
	

	ADD EBX, ECX
	ADD EAX, EBX

	RET
zad_5 ENDP

main PROC	
	; CALL zad_1 ; WORKS \
	; CALL zad_2 ; WORKS - = > To use those uncomment all of the three as they work together (plus CONT::)
	; CALL zad_3 ; WORKS /
	CONT::
	; CALL zad_4
	; CALL new_line
	CONT_2::
	CALL zad_5

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
