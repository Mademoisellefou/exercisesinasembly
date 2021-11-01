include macro1.asm
.model small
.stack 64
.data
v db 2,4,12,9,3,"$"
mayn db 0
num db 12 dup("$")             
salto db 10,13,"$"
.code
inicio:
mov ax,@data
mov ds,ax   
;--
mov si,0
ciclo1:
cmp v[si],"$"
je salir   
mov ax,0
mov al,v[si]
cmp al,mayn
jb pasar
mov mayn,al
pasar:
inc si
jmp ciclo1
salir:       
mov ax,0
mov al,mayn
call numcad
mostrarcad num
;--
mov ah,4ch
int 21h
;--       
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
end inicio
