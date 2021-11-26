include macro1.asm
.model small
.stack 64
.data
c dw 0 
salto db 10,13,"$"
num db 15 dup("$")
.code
Inicio:
mov ax,@data
mov ds,ax
;. 
mov ax,122
call countnum 
mov ax,0
mov ax,c 
call numcad  
mostrarcad num
mov ah,4ch
int 21h
;.  
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
countnum proc   
; convierte el numero a reversa 56-> 65    
push ax
push bx   
push cx
mov cx,0
mov bx,10
ciclo1:
div bx   
push dx
mov dx,0 
inc cx
cmp ax,0
je salir1
jmp ciclo1
salir1:
mov bx,1
ciclo2: 
pop dx
mov ax,dx
mov dx,0
mul bx
;--      
add c,ax
mov ax,0
mov ax,bx
mov bx,10
mul bx
mov bx,ax
;--   
loop ciclo2
pop cx
pop bx
pop ax
ret 
countnum endp
end Inicio
           
