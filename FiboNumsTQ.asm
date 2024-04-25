; Tina Quach
; COSC-2425-86001
; FiboNums.asm - Program to calculate the nth Fibonacci sequence with user's 'n'

.386
.model flat, stdcall, c
.stack 4096

.data
prompt BYTE 'Enter a positive integer for your n value to calculate the nth Fibonacci sequence: ', 0
formatStr BYTE "%d", 0
nnum DWORD ?
outputStr BYTE "Your Fibonacci sequence is: %d", 0


.code
includelib libucrt.lib
includelib legacy_stdio_definitions.lib
includelib libcmt.lib
includelib libvcruntime.lib

extrn printf:near
extrn scanf:near
extrn exit:near

public main
main proc
; display prompt to get user's nth value
	push offset prompt
	call printf

; read the nth input 
	push offset nnum
	push offset formatStr
	call scanf

; now to calculate the fibonacci sequence
; the first two numbers in the sequence are always 0, 1 so
	mov eax, 0 ; initialize eax to 0 for fib(0)
	mov ebx, 1 ; initialize ebx to 1 for fib(1)
	mov ecx, nnum ; move user's n to ecx
	cmp ecx, 1 ; compare user's n with 1
	jbe fib_done


fib_loop:
	add eax, ebx ; add fib (i-1) to fib(i-2)
	xchg eax, ebx ; swap eax and ebx so fib (i-1) becomes fib(i-2)
	loop fib_loop ; decrement ecx and loop if not zero

fib_done:
; print the results
	push eax
	push offset outputStr
	call printf

; terminate program
	push 0
	call exit

main endp
end