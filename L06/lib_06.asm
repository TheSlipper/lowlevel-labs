.386
.MODEL FLAT, STDCALL


ExitProcess PROTO :DWORD
potateiro PROTO
testeiro PROTO :DWORD
lstrlenA PROTO :DWORD

.data

.code

potateiro proc

	mov EAX,100
	ret
potateiro endp

testeiro proc param1:DWORD 


	mov EAX,100
	mov EBX, param1
	ret
testeiro endp

fillRegister PROC
	MOV EAX, 1000
	RET
fillRegister ENDP

ScanInt   PROC 
	;; funkcja ScanInt przeksztalca ciag cyfr do liczby, która jest zwracana przez EAX 
	;; argument - zakonczony zerem wiersz z cyframi 
	;; rejestry: EBX - adres wiersza, EDX - znak liczby, ESI - indeks cyfry w wierszu, EDI - tymczasowy 
	;--- poczatek funkcji 
	   push   EBP 
	   mov   EBP, ESP   ; wskaznik stosu ESP przypisujemy do EBP 
	;--- odkladanie na stos 
	   push   EBX 
	   push   ECX 
	   push   EDX 
	   push   ESI 
	   push   EDI 
	;--- przygotowywanie cyklu 
	   mov   EBX, [EBP+8] 
	   push   EBX 
	   call   lstrlenA 
	   mov   EDI, EAX   ;liczba znaków 
	   mov   ECX, EAX   ;liczba powtórzen = liczba znaków 
	   xor   ESI, ESI   ; wyzerowanie ESI 
	   xor   EDX, EDX   ; wyzerowanie EDX 
	   xor   EAX, EAX   ; wyzerowanie EAX 
	   mov   EBX, [EBP+8] ; adres tekstu
	;--- cykl -------------------------- 
	pocz: 
	   cmp   BYTE PTR [EBX+ESI], 0h   ;porównanie z kodem \0 
	   jne   @F 
	   jmp   et4 
	@@: 
	   cmp   BYTE PTR [EBX+ESI], 0Dh   ;porównanie z kodem CR 
	   jne   @F 
	   jmp   et4 
	@@: 
	   cmp   BYTE PTR [EBX+ESI], 0Ah   ;porównanie z kodem LF 
	   jne   @F 
	   jmp   et4 
	@@: 
	   cmp   BYTE PTR [EBX+ESI], 02Dh   ;porównanie z kodem - 
	   jne   @F 
	   mov   EDX, 1 
	   jmp   nast 
	@@: 
	   cmp   BYTE PTR [EBX+ESI], 030h   ;porównanie z kodem 0 
	   jae   @F 
	   jmp   nast 
	@@: 
	   cmp   BYTE PTR [EBX+ESI], 039h   ;porównanie z kodem 9 
	   jbe   @F 
	   jmp   nast 
	;---- 
	@@:    
		push   EDX   ; do EDX procesor moze zapisac wynik mnozenia 
	   mov   EDI, 10 
	   mul   EDI      ;mnozenie EAX * EDI 
	   mov   EDI, EAX   ; tymczasowo z EAX do EDI 
	   xor   EAX, EAX   ;zerowanie EAX 
	   mov   AL, BYTE PTR [EBX+ESI] 
	   sub   AL, 030h   ; korekta: cyfra = kod znaku - kod 0    
	   add   EAX, EDI   ; dodanie cyfry 
	   pop   EDX 
	nast:   
		inc   ESI 
	   loop   pocz 
	;--- wynik 
	   or   EDX, EDX   ;analiza znacznika EDX 
	   jz   @F 
	   neg   EAX 
	@@:    
	et4:;--- zdejmowanie ze stosu 
	   pop   EDI 
	   pop   ESI 
	   pop   EDX 
	   pop   ECX 
	   pop   EBX 
	;--- powrót 
	   mov   ESP, EBP   ; przywracamy wskaznik stosu ESP
	   pop   EBP 
	   ret	4
	ScanInt   ENDP 

END