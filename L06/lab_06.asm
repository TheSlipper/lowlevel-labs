.386
.MODEL flat, STDCALL

STD_INPUT_HANDLE EQU -10 
STD_OUTPUT_HANDLE EQU -11

ExitProcess PROTO :DWORD

GetStdHandle PROTO :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
wsprintfA PROTO C :VARARG

fillRegister PROTO
; ScanInt PROTO :DWORD
ScanInt PROTO

.data
; MISC
spam_content DD 0
rn_ascii DB 10, 13
rinp DD 0
iterator_buffer DD 0
seed_buffer DD 0

output_handle DD 0
input_handle DD 0

; Assignment 2
four_numbers_text DB "Enter four numbers: "
four_numbers_input DB 6 dup(?), 0

; Assignment 3
hout DWORD 0
hinp DWORD 0

number_input_string DB "Enter a number: "

num_0_val DD 0
num_0_raw_input DB 10 dup(?)
num_0_chars_read DD 0

num_1_val DD 0
num_1_raw_input DB 10 dup(?)
num_1_chars_read DD 0

num_2_val DD 0
num_2_raw_input DB 10 dup(?)
num_2_chars_read DD 0

num_3_val DD 0
num_3_raw_input DB 10 dup(?)
num_3_chars_read DD 0

equation_val DD 0

final_output_string DB "%i + %i + %i + %i = %i", 0
final_output_buffer DB 255 dup(?)

; rinp DD 0

.code

ReturnDescryptor MACRO handleConstantIn :REQ, handleOut :REQ
	PUSH handleConstantIn
	CALL GetStdHandle
	MOV handleOut, EAX
ENDM

assignment_1 PROC
	XOR EAX, EAX
	CALL fillRegister
	RET
assignment_1 ENDP

assignment_2 PROC
	; ------------------------- Input from the user -------------------------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF four_numbers_text
	PUSH OFFSET four_numbers_text
	PUSH output_handle
	CALL WriteConsoleA
	
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF four_numbers_input
	PUSH OFFSET four_numbers_input
	PUSH input_handle
	CALL ReadConsoleA

	; ------------------------- ScanInt ------------------------- 
	MOV EDX, OFFSET four_numbers_input
	ADD EDX, LENGTHOF four_numbers_input
	MOV AL, 0
	MOV [EDX-2], AL	; Deleting 'enter' by putting 0 in the first character
	PUSH OFFSET four_numbers_input
	CALL ScanInt

	; TODO: Ask what does "Adding those 4 numbers mean" and why do we have implement ScanInt if we are only adding the numbers


	RET
assignment_2 ENDP

assignment_3 PROC
	; ------------------------- User inputs (4 numbers) ------------------------- 
	; No.1
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
	
	; No. 3
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
	PUSH OFFSET num_2_chars_read
	PUSH LENGTHOF num_2_raw_input
	PUSH OFFSET num_2_raw_input
	PUSH input_handle
	call ReadConsoleA

	; No. 4
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
	PUSH OFFSET num_3_chars_read
	PUSH LENGTHOF num_3_raw_input
	PUSH OFFSET num_3_raw_input
	PUSH input_handle
	call ReadConsoleA

	; ------------------------- Convert 4 numbers ------------------------- 
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

	; No. 3
	MOV EDX, OFFSET num_2_raw_input
	ADD EDX, num_2_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_2_raw_input
	CALL atoi
	MOV num_2_val, EAX

	; No. 4
	MOV EDX, OFFSET num_3_raw_input
	ADD EDX, num_3_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET num_3_raw_input
	CALL atoi
	MOV num_3_val, EAX

	; ------------------------- Add everything up ------------------------- 
	MOV EAX, num_0_val
	MOV EBX, num_1_val
	MOV ECX, num_2_val
	MOV EDX, num_3_val
	ADD EAX, EBX
	ADD EAX, ECX
	ADD EAX, EDX
	MOV equation_val, EAX

	XOR EAX, EAX
	XOR EBX, EBX
	XOR ECX, ECX
	XOR EDX, EDX

	; ------------------------- Format for output -------------------------
	; equation_val DD 0
	; final_output_string DB "%i + %i +%i + %i = %i", 0
	; final_output_buffer DB 255 dup(?)

	MOV EBX, equation_val
	PUSH EBX
	MOV EBX, num_3_val
	PUSH EBX
	MOV EBX, num_2_val
	PUSH EBX
	MOV EBX, num_1_val
	PUSH EBX
	MOV EBX, num_0_val
	PUSH EBX

	PUSH OFFSET final_output_string
	PUSH OFFSET final_output_buffer
	CALL wsprintfA

	ADD ESP, 12
	MOV rinp, EAX

	; ------------------------- Output -------------------------
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET final_output_buffer
	PUSH rinp
	PUSH OFFSET final_output_buffer
	PUSH output_handle
	CALL WriteConsoleA

	JMP cont_after_3

	RET 
assignment_3 ENDP

assignment_4_a PROC ; num: DD
	; ------------------------- ScanInt ------------------------- 


	; ------------------------- Print (Still work in progress) ------------------------- 
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF four_numbers_text
	PUSH OFFSET four_numbers_text
	PUSH output_handle
	CALL WriteConsoleA
	
	RET
assignment_4_a ENDP

assignment_4_b PROC
	
	RET
assignment_4_b ENDP

assignment_4 PROC
	RET
assignment_4 ENDP

main PROC
	; Pobranie uchwytow wyjscia i wejscia przez makro
	ReturnDescryptor STD_OUTPUT_HANDLE, hout
	ReturnDescryptor STD_INPUT_HANDLE, hinp
	CALL assignment_3
	; CALL assignment_1		; WORKS
	; CALL assignment_2
	cont_after_3::
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