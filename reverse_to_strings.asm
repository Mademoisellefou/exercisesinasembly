;mostrar reversa 2 strings
.model small
.stack 64
.data
v1 db "papa$"
v2 db "pan$"
num db 25 dup("$")
.code
Inicio:
mov ax,@data
mov ds,ax
;----------- 
call llenar
;-----------     
mov ah,4ch
int 21h
;----
llenar proc
push ax
push bx
push cx
push dx
mov si,0
mov cx,0
mov ax,0
mov dx,0
ciclo1:
mov dl,v1[si]    
cmp dl,"$"
je ciclo2
push dx      
inc si
inc cx
mov dx,0

jmp ciclo1
ciclo2:
mov si,0
mov dx,0
cc2:
mov dl,v2[si]
cmp dl,"$"
je salir
push dx      
inc si
inc cx
mov dx,0
jmp cc2
salir: 
mov si,0
ciclo3:
pop dx
mov num[si],dl
inc si
loop ciclo3
mov num[si],',' 
mov ah,09h
lea dx,num
int 21h
pop dx
pop cx
pop bx
pop ax
ret
llenar endp
end Inicio
