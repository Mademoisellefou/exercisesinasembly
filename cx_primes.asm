.model small
.stack 64
.data
arrprime db 0,0,0,0,0,0,0,0,0,0,"$"
num db 30 dup("$")
i db 02h
.code
Inicio:
mov ax,@data
mov ds,ax
;---
mov dl,01h
mov cx,5h
lea di,arrprime
ciclo:
mov bl,02h
add dl,01h
cmp dl,02h
je insert
cmp dl,03h
je insert
cmp dl,04h
jge evaluar
evaluar:
mov ah,00
mov al,dl
div bl
cmp ah,00
je ciclo
add bl,01h
cmp bl,al
jle evaluar
jmp insert
insert:
mov [di],dl
inc di 
loop ciclo
exit:
;---         
mov si,0
mov cx,5
ciclo2:
mov ax,0
mov al,arrprime[si]
call numcad
lea dx,num
mov ah,09h
int 21h
inc si
loop ciclo2
mov ah,4ch
int 21h
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
end Inicio
