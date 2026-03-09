

; direccion de practicas: cd pract1/
;  nasm -f elf32  pract2.asm -o main.o
;  ld -m elf_i386 -s -o main main.o libpc_io.a
;  ./main


%include "./pc_io.inc"

; section .data	;Datos inicializados
; 	msg1:	db "Ingresa tu nombre",10,0
; 	msg2:	db "Hola ",0

; section .bss	;Datos no inicializados
; 	nombre	resb 256

; section .text
; 	global _start:

; _start:

section .data
    ; msj: db "Ingrese un dígito (0-9)",0x0
    msj: db "Ingrese un dígito (0-9)",10,0
    len: equ $-msj

section .bss
    num1 resb 1
    num2 resb 1
    cad 		resb 	8

section .text
    global _start

_start:
    mov edx, msj
    call puts

    call getche
    mov ebx, num1
    sub al, 48
    mov [ebx], al
    ; call salto

    call getche
    mov ebx, num2
    sub al, 48
    mov [ebx], al

    call putchar

    mov ebx, num1
    mov al, [ebx]
    mov ebx, num2
    add al, [ebx]

    mov esi, cad 
    mov eax, al
    call printHex

mov eax, 1 ; sys_exit syscall
mov ebx, 0 ; return 0 (todo correcto)
int 80h

;en eax el valor a convertir mostrar en hexadecimal
; para utilizar en 
printHex:
  pushad
  mov edx, eax
  mov ebx, 0fh
  mov cl, 28
.nxt: shr eax,cl
.msk: and eax,ebx
  cmp al, 9
  jbe .menor
  add al,7
.menor:add al,'0'
  mov byte [esi],al
  inc esi
  mov eax, edx
  cmp cl, 0
  je .print
  sub cl, 4
  cmp cl, 0
  ja .nxt
  je .msk
.print: mov eax, 4
  mov ebx, 1
  sub esi, 8
  mov ecx, esi
  mov edx, 8
  int 80h
  popad
  ret
