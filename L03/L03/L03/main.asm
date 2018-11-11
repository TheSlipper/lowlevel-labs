.386
.MODEL flat, STDCALL

stala equ 10

ExitProcess PROTO :DWORD

.data

zmienna1 db 10h

.code
main PROC
	push 0
	call ExitProcess
main ENDP

END