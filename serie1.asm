include macro1.asm
.model small
.stack 64
.data
num db 16 dup("$") 
.code
inicio:
mov ax,@data
mov ds,ax       
;---
mov ax,0
call leernum
mov cx,ax
       
mov ax,1
mov bx,1

ciclo1:
mul bx
call numcad
mostrarcad num
add bx,1
loop ciclo1
;----
mov ah,4ch
int 21h    
;----
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
mov num[si],","
pop si
pop dx
pop cx
pop bx
pop ax
ret
numcad endp  
end inicio
