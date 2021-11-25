include macro1.asm
.model small
.stack 64
.data
x db 2 dup("$")
cad db 15 dup("$")
cad1 db 15 dup("$")
salto db 10,13,"$"
.code
inicio:
mov ax,@data
mov ds,ax
;--
mov ax,0
call xchar    
mostrarcad salto
call leercad
mov ax,cx
call numcad
mostrarcad salto
mostrarcad cad
mostrarcad salto
mostrarcad cad1
;--
mov ah,4ch
int 21h
;--
numcad proc
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
mov cad1[si],dl
inc si
loop cadena
mov cad1[si]," "
pop ax
pop bx
pop dx
pop si
pop cx
ret
numcad endp
;--
xchar proc
push ax
push si
mov si,0
mov ah,01h
int 21h
mov x[si],al
pop si
pop ax
ret
xchar endp
leercad proc
push ax
push di
push si
mov cx,0
mov di,0
lea di,x
mov si,0
ciclo:
push cx
mov ah,01h
int 21h
cmp al,13
je salir
mov cad[si],al
inc si
cmp al,[di]
jne nosame
pop cx
inc cx 
jmp ciclo
nosame:
pop cx
jmp ciclo
salir:
pop cx
pop si
pop di
pop ax
ret
leercad endp
end inicio
