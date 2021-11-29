mostrarcad  macro text
push ax
push dx
mov ah,09h
lea dx,text
int 21h
pop dx
pop ax
endm  
.model small
.stack 64
.data	
    a  dw 1
	b dw 0
	x dw 0
	m1 db 'Ingrese numero: $'
	salto db 10,13,'$'
	num db 5 dup('$')
	cero db "0 $"
.code
inicio:
	mov ax, @data
	mov ds, ax
;-------------------------------------
	mostrarcad m1  ; ingrese numero
	mostrarcad salto
	call leernum   ; Procedimiento para leer numeros desde teclado
	mov cx,ax   ; variable auxliar
	mov ax,0    ; iniciamos la serie en 2
	mov bx,0    ; bx sera un contador que debe llegar a cx 
	mov dx,0
		
	ciclo:
		cmp bx,cx
		je fin    ; cuando llegue a cx termina OJO  cx es equivalente a N  en la serie
		cmp dx,0  ; dx hace la funcion de SW variable bandera
		je pares
		jne ceros
		ceros: 
			push ax
			push bx
			mov ax,a
			mov bx,b
			add ax,bx
			call numcad
			mostrarcad num
			mov  a,bx
			mov  b,ax
			pop bx;mov ax,ca
			pop ax;mov bx,cb	
			mov dx,0
			inc bx
			jmp ciclo
		pares:
			push ax
			mov ax,x
			call numcad     ; procedimiento para convertir un numero en cadena desplegable en pantalla, devuelve en num
			mostrarcad num
			add ax,2
			mov x,ax
			pop ax
			mov dx,1
			inc bx
			jmp ciclo
	fin:
;-------------------------------------
	mov ah,4ch
	int 21h
;PROCEDIMIENTOS
leernum proc
; Lee un numero desde teclado y devuelve el numero en AX
	push bx
	push cx
	mov ax,0
	mov bx,10
	mov cx,0
f1:
	push ax
	mov ah,01h
	int 21h
	cmp al,13
	je salir
	sub al,30h
	mov cl,al
	pop ax
	mul bx
	add ax,cx
	jmp f1
salir:
	pop ax
	pop cx
	pop bx
	ret
leernum endp

numcad proc
; Convierte un numero en cadena. Requiere en AX el numero y devuelve en num la cadena 
	push cx
	push si
	push dx
	push bx
	push ax
	mov bx,10
	mov cx,0
	mov dx,0
	mov si,0
digitos:
	div bx
	push dx
	mov dx,0
	inc cx
	cmp ax,0
	je cadena
	jmp digitos
cadena:
	pop dx
	add dl,30h
	mov num[si],dl
	inc si
	loop cadena
	mov num[si],' '
	pop ax
	pop bx
	pop dx
	pop si
	pop cx
	ret
numcad endp

end inicio
