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
buffer DD 0

output_handle DD 0
input_handle DD 0

; Assignment 4_b variables
output_4_msg DB "Insert the number: "

input_4_val DD 0
input_4_raw DB 10 dup(?)
input_4_chars_read DD 0

binary_output_string DB 255 dup(?), 0
binary_string_length DD 0

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

zad_4_b PROC
	; Output the text
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET spam_content
	PUSH LENGTHOF output_4_msg
	PUSH OFFSET output_4_msg
	PUSH output_handle
	call WriteConsoleA
	
	; Input from the user
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX

	PUSH 0
	PUSH OFFSET input_4_chars_read
	PUSH 10
	PUSH OFFSET input_4_raw
	PUSH input_handle
	call ReadConsoleA
	
	; Convert
	MOV EDX, OFFSET input_4_raw
	ADD EDX, input_4_chars_read
	MOV AL, 0
	MOV [EDX-2], AL
	PUSH OFFSET input_4_raw
	CALL atoi
	MOV input_4_val, EAX

	; From Decimal to binary with modulo (the remainder is stored in EDX)
	XOR EDX, EDX
	XOR EAX, EAX
	XOR EBX, EBX
	MOV ECX, OFFSET binary_output_string
	MOV EAX, input_4_val
	MOV buffer, EAX

	conversion:
		MOV EBX, binary_string_length
		INC EBX
		MOV binary_string_length, EBX
	
		XOR EDX, EDX
		MOV EAX, buffer
		MOV EBX, 2
		DIV EBX
		MOV buffer, EAX

		ADD EDX, 48
		MOV [ECX], EDX
		INC ECX

		CMP EAX, 0
		JE output
		CMP EAX, 1
		JE once_more
		JNE conversion

	once_more:
	MOV EBX, binary_string_length
	INC EBX
	MOV binary_string_length, EBX
	MOV EBX, 49
	MOV [ECX], EBX 

	output:
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET spam_content
	PUSH binary_string_length
	PUSH OFFSET binary_output_string
	PUSH output_handle
	call WriteConsoleA

	; TODO: Flip the binary string and format it

	RET
zad_4_b ENDP

main PROC	
	CALL zad_4_b

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