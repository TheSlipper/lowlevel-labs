.386
.MODEL flat, STDCALL

; Constants
STD_INPUT_HANDLE EQU -10 
STD_OUTPUT_HANDLE EQU -11
GENERIC_READ EQU 80000000h
GENERIC_WRITE EQU 40000000h
CREATE_NEW EQU 1
CREATE_ALWAYS EQU 2
OPEN_EXISTING EQU 3
OPEN_ALWAYS EQU 4


; Procedures
ExitProcess PROTO :DWORD
GetStdHandle PROTO :DWORD
WriteConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadConsoleA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
wsprintfA PROTO C :VARARG

GetCurrentDirectoryA PROTO :DWORD, :DWORD
CreateDirectoryA PROTO :DWORD, :DWORD
CreateFileA PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WriteFile PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ReadFile PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
CloseHandle PROTO :DWORD

GetTickCount PROTO
nseed PROTO :DWORD
nrandom PROTO :DWORD

.data
; MISC
spam_content DD 0
rn_ascii DB 10, 13
rinp DD 0
iterator_buffer DD 0

output_handle DD 0
input_handle DD 0

; Zad 1
buffer DB "c:\Grupa1"

; Zad 2
seed_buffer DD 41032
random_numbers_array DD 20 dup(?), 0
random_numbers_offset DD 0

random_numbers_template DB "%i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i %i", 0
random_numbers_string DB 255 dup(0)

path DB "C:\Grupa1\test.dat", 0
file_handle DD 0

; Zad 4
path_2 DB "C:\Grupa1\test.txt", 0



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
	INVOKE CreateDirectoryA, OFFSET buffer, 0
	RET
zad_1 ENDP

initiate_10_rand_num PROC
	MOV ECX, 20
	CALL GetTickCount
	MOV seed_buffer, EAX
	MOV EDX, OFFSET random_numbers_array
	MOV random_numbers_offset, EDX

	loop_3:
		MOV iterator_buffer, ECX

		; Get random num
		MOV EAX, seed_buffer
		PUSH EAX
		CALL nseed
		PUSH 10	; Range	< ====================================== Change this with useer input
		CALL nrandom

		; Save random num and use random num as seed
		MOV EDX, random_numbers_offset
		MOV [EDX], EAX
		MOV seed_buffer, EAX
		INC EDX
		MOV random_numbers_offset, EDX

		MOV ECX, iterator_buffer
	LOOP loop_3
	RET
initiate_10_rand_num ENDP

preformat_10_rand_string PROC
	
;	MOV ECX, 20
;	MOV EDX, OFFSET random_numbers_array
;	MOV random_numbers_offset, EDX	; Just in case save it
;	looperino:
;		MOV EAX, [EDX]
;		PUSH EAX
;		INC EDX
;	loop looperino

;	PUSH OFFSET random_numbers_template
;	PUSH OFFSET random_numbers_string
;	CALL wsprintfA

;	ADD ESP, 22
;	MOV rinp, EAX
	
	MOV ECX, 20
	MOV EDX, OFFSET random_numbers_array
	MOV random_numbers_offset, EDX
	looperino:
		MOV EAX, [EDX]
		ADD EAX, 48
		MOV [EDX], EAX
		INC EDX
	loop looperino

	RET
preformat_10_rand_string ENDP

zad_2 PROC
	CALL initiate_10_rand_num
	CALL preformat_10_rand_string ; Doesn't work ffs
	INVOKE CreateFileA, OFFSET path, GENERIC_READ OR GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0
	MOV file_handle, EAX
	INVOKE WriteFile, file_handle, OFFSET random_numbers_array, 20, spam_content, 0
	INVOKE CloseHandle, file_handle
	RET
zad_2 ENDP

print_zad_3 PROC
	MOV ECX, 20
	MOV EDX, OFFSET random_numbers_array
	MOV random_numbers_offset, EDX
	looperino:
		MOV iterator_buffer, ECX

		PUSH STD_OUTPUT_HANDLE
		CALL GetStdHandle
		MOV output_handle, EAX
		PUSH 0
		PUSH OFFSET spam_content
		PUSH 1
		PUSH random_numbers_offset
		PUSH output_handle
		CALL WriteConsoleA
		CALL new_line

		MOV EDX, random_numbers_offset
		INC EDX
		MOV random_numbers_offset, EDX

		MOV ECX, iterator_buffer
	loop looperino
	RET
print_zad_3 ENDP

zad_3 PROC
	INVOKE CreateFileA, OFFSET path, GENERIC_READ OR GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0
	MOV file_handle, EAX
	INVOKE ReadFile, file_handle, OFFSET random_numbers_string, 20, OFFSET spam_content, 0
	CALL print_zad_3
	INVOKE CloseHandle, file_handle
	RET
zad_3 ENDP

zad_4 PROC
	INVOKE CreateFileA, OFFSET path_2, GENERIC_READ OR GENERIC_WRITE, 0, 0, CREATE_ALWAYS, 0, 0
	MOV file_handle, EAX
	INVOKE WriteFile, file_handle, OFFSET random_numbers_string, 20, spam_content, 0
	INVOKE CloseHandle, file_handle
	RET
zad_4 ENDP

main PROC
	; CALL zad_1 ; Works
	; CALL zad_2 ; Works but you need to make the hooman input :smirk:
	CALL zad_3 ; Works
	CALL zad_4 ; In order to make it work first run only 2 and then run 3 and 4

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
