;mostrar dentro de un rango
.model small
.stack 64
.data
v db 1,7,19,11
a db 5
b db 20  
num db 25 dup("$")
.code
Inicio:
mov ax,@data
mov ds,ax
;-----------
mov si,0
mov cx,4
ciclo:   
mov ax,0
mov al,v[si]
cmp al,a
jb norange
cmp al,b
ja norange
call numcad
norange:
inc si
loop ciclo
salir:
;---      
mov ah,4ch
int 21h    
numcad proc
push ax
push bx
push cx
push dx 
push si
mov bx,10
mov si,0
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
mov num[si],',' 
mov ah,09h
lea dx,num
int 21h
pop si
pop dx
pop cx
pop bx
pop ax
ret
numcad endp
end Inicio
