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

output_handle DD 0
input_handle DD 0

rn_ascii DB 10, 13
spam_content DD 0
loop_buffer DD 0

source_0 DB 10 dup(?)
destination_0 DB 10 dup(?)
output_text_0 DB "Enter something: "
written_chars_0 DD 0
read_chars_0 DD 0

zad_4_tab_0 DD 30 dup(0)
zad_4_tab_1 DD 30 dup(0)

output_text_5 DB "Enter one character: "
sum_5 DD 0
iterator_5 DD 0
input_array_5 DB 10 dup(?)
read_chars_5 DD 0
formatted_text DB "Result: %i ", 0
final_output DB 255 dup(0)
rinp DD 0

.code

; Sample procedure for future reference
; sample proc
;	mov EAX, 3h
;	ret
; sample endp

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
	
	; Output the text
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET written_chars_0
	PUSH 11h
	PUSH OFFSET output_text_0
	PUSH output_handle
	call WriteConsoleA
	
	; Input from the user
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX

	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH 10
	PUSH OFFSET source_0
	PUSH input_handle
	call ReadConsoleA
	
	; Copy to "destination_0"
	MOV EAX, OFFSET source_0
	MOV ECX, read_chars_0
	DEC ECX
	; DEC ECX ; Don't read the enter characters
	loop_1_0:
		PUSH [EAX]
		INC EAX
	LOOP loop_1_0

	MOV EBX, OFFSET destination_0
	ADD EBX, read_chars_0
	MOV ECX, read_chars_0
	DEC ECX
	; DEC ECX ; Don't read the enter characters
	loop_1_1:
		POP [EBX]
		DEC EBX
	LOOP loop_1_1

	; Print out "destination_0"
	; PUSH STD_OUTPUT_HANDLE
	; CALL GetStdHandle
	; mov output_handle, EAX
	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH read_chars_0
	PUSH OFFSET destination_0
	PUSH output_handle
	CALL WriteConsoleA
	RET
zad_1 ENDP

zad_2 PROC
	
	; Output the text
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET written_chars_0
	PUSH 11h
	PUSH OFFSET output_text_0
	PUSH output_handle
	call WriteConsoleA
	
	; Input from the user
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX

	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH 10
	PUSH OFFSET source_0
	PUSH input_handle
	call ReadConsoleA
	
	MOV ECX, read_chars_0
	MOV ESI, OFFSET source_0
	MOV EDI, OFFSET destination_0
	REP MOVSB

	; Print out "destination_0"
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH read_chars_0
	PUSH OFFSET destination_0
	PUSH output_handle
	CALL WriteConsoleA
	RET
zad_2 ENDP

zad_3 PROC
	; Output the text
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	mov output_handle, EAX

	PUSH 0
	PUSH OFFSET written_chars_0
	PUSH 11h
	PUSH OFFSET output_text_0
	PUSH output_handle
	call WriteConsoleA
	
	; Input from the user
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	mov input_handle, EAX

	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH 10
	PUSH OFFSET source_0
	PUSH input_handle
	call ReadConsoleA
	
	; Copy to "destination_0"
	MOV EAX, OFFSET source_0
	MOV ECX, read_chars_0
	DEC ECX
	; DEC ECX ; Don't read the enter characters
	loop_1_0:
		PUSH [EAX]
		INC EAX
	LOOP loop_1_0

	MOV EBX, OFFSET destination_0
	; ADD EBX, read_chars_0
	MOV ECX, read_chars_0
	DEC ECX
	; DEC ECX 
	loop_1_1:
		POP [EBX]
		INC EBX
	LOOP loop_1_1

	; Print out "destination_0"
	; PUSH STD_OUTPUT_HANDLE
	; CALL GetStdHandle
	; mov output_handle, EAX

	MOV ECX, read_chars_0
	DEC ECX
	MOV spam_content, ECX

	PUSH 0
	PUSH OFFSET read_chars_0
	PUSH spam_content
	PUSH OFFSET destination_0
	PUSH output_handle
	CALL WriteConsoleA
	RET
zad_3 ENDP

zad_4 PROC
	; That is the only different element in this array
	; zad_4_tab_0
	; zad_4_tab_1
	MOV zad_4_tab_0, 35

	CLD	; Clear direction flag (sets to 0)
	MOV ECX, LENGTHOF zad_4_tab_0
	MOV ESI, OFFSET zad_4_tab_0
	MOV EDI, OFFSET zad_4_tab_1
	REPE CMPSB

			; Output the text
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		mov output_handle, EAX

		PUSH 0
		PUSH OFFSET written_chars_0
		PUSH 11h
		PUSH OFFSET output_text_0
		PUSH output_handle
		CALL WriteConsoleA

	RET
zad_4 ENDP

zad_5 PROC
	MOV ECX, 10
	MOV iterator_5, ECX
	MOV sum_5, 0
	
	loop_zad_5:
		MOV iterator_5, ECX
		
		; Output the text
		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET written_chars_0
		PUSH 11h
		PUSH OFFSET output_text_0
		PUSH output_handle
		CALL WriteConsoleA

		; Input from the user
		PUSH STD_INPUT_HANDLE
		CALL GetStdHandle
		MOV input_handle, EAX
		PUSH 0
		PUSH OFFSET read_chars_5
		PUSH 10
		PUSH OFFSET input_array_5
		PUSH input_handle
		CALL ReadConsoleA

		; Convert the number that was just read into an integer
		MOV EDX, OFFSET input_array_5
		ADD EDX, read_chars_5
		MOV AL, 0
		MOV [EDX-2], AL
		PUSH OFFSET input_array_5
		CALL atoi

		; Add the integer to other integers
		MOV EBX, sum_5
		ADD EBX, EAX
		MOV sum_5, EBX

		MOV ECX, iterator_5
	LOOP loop_zad_5

	; wsprintfa
	MOV EBX, sum_5
	PUSH EBX
	PUSH OFFSET formatted_text
	PUSH OFFSET final_output
	CALL wsprintfA

	ADD ESP, 12
	MOV rinp, EAX	; IMPORTANT - WSPRINTFA DOESN'T WORK WITHOUT RINP DECLARED (I think... the resources are scarce so I can't tell)

	; Output the text
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX
	PUSH 0
	PUSH OFFSET written_chars_0
	PUSH LENGTHOF final_output
	PUSH OFFSET final_output
	PUSH output_handle
	CALL WriteConsoleA

	RET
zad_5 ENDP

main PROC	
	; CALL zad_1		; WORKS
	; CALL new_line
	; CALL new_line

	; CALL zad_2		; WORKS
	; CALL new_line
	; CALL new_line

	; CALL zad_3	; WORKS

	; CALL zad_4	; WORKS

	; CALL zad_5	; WORKS

	; EVERYTHING JUST WORKS

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
