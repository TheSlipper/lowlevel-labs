.386
.MODEL flat, STDCALL

; Declare the constants here

STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE equ -10

; Procedure declarations (or imports? dunno what those are called)
ExitProcess PROTO :DWORD
GetStdHandle PROTO :DWORD
WriteConsoleA PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD

.data

source DB 10 dup (?)
text_output_1 DB "Please enter the text: "
output_char_count DW 0
input_char_count DW 0

output_handle DD 0
input_handle DD 0

.code
main PROC	

	looperino:

	; Assignment 1
	; Get output handle and display the first text output
	PUSH STD_OUTPUT_HANDLE
	CALL GetStdHandle
	MOV output_handle, EAX

	PUSH 0
	PUSH OFFSET output_char_count
	PUSH 17h
	PUSH OFFSET text_output_1
	PUSH output_handle
	
	; Get input handle and get input from the user
	PUSH STD_INPUT_HANDLE
	CALL GetStdHandle
	MOV input_handle, EAX
	
	PUSH 0
	PUSH OFFSET input_char_count
	PUSH 10h
	PUSH OFFSET source
	PUSH input_handle
	
	PUSH 0
	CALL ExitProcess
main ENDP

END