include macro1.asm
.model small
.stack 64
.data
num db 15 dup("$")
lo dw 0            
salto db 10,13,"$"
msgnotfound db "NOT IN RANGE$"
.code
Inicio:
mov ax,@data
mov ds,ax
;--            
mov bx,0   
mov ax,0
call leernum
call numcad
mostrarcad salto
mostrarcad num 
mov ax,0
call countcad
mov bx,ax
mov ax,0
mostrarcad salto
call leernum
cmp ax,bx
jge salir 
mostrarcad salto
mov si,ax
mov dl,num[si]
mov ax,0
mov ah,02h
int 21h
salir:
mov ah,4ch
int 21h
;-----
leernum proc
push bx
push cx
mov bx,10
mov cx,0
mov ax,0
ciclo2:
push ax
mov ah,01h
int 21h
cmp al,13
je salir2
sub al,30h
mov cl,al
pop ax
mul bx
add ax, cx
jmp ciclo2
salir2:
pop ax
pop cx
pop bx
ret 
leernum endp
;---
numcad proc
push ax
push bx
push cx
push dx 
push si
mov bx,10
mov si,  0
mov cx,0
mov dx,0
descomponer:
div bx
push dx
mov dx,0
inc cx
cmp ax,0
je componer
jmp descomponer
componer:
pop dx
add dl,30h
mov num[si],dl
inc si
loop componer

pop si
pop dx
pop cx
pop bx
pop ax
ret
numcad endp
;---
countcad proc
push si
push bx
mov bx,0
mov si,0
lea si,num
ciclo1:
push ax
mov bl,[si]
cmp bl,"$"
je salir1
inc si 
pop ax
inc ax
jmp ciclo1
salir1:    
pop ax     
pop bx
pop si
ret
countcad endp
end Inicio
