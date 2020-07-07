.model small
.stack 64
.data

fini db 5
cini db 20
ffin db 6
cfin db 60
linea db 0
color db 11h  

.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
call limpia
mov cx,15
ciclo:
call clrscr
add color,10h
add fini,1
add ffin,1
loop ciclo
;-----------------------------
mov ah,4ch
int 21h
;-----procedimientos


clrscr proc near
push ax
push bx
push cx
mov ah,06h
mov bh,color
mov al,00
mov ch,fini
mov cl,cini
mov dh,ffin
mov dl,cfin
int 10h
pop cx
pop bx
pop ax
ret
clrscr endp


limpia proc near
push ax
push bx
push cx
mov ah,06h
mov bh,51h
mov al,00
mov cx,0000h
mov dx,184fh
int 10h
pop cx
pop bx
pop ax
ret
limpia endp




end Inicio