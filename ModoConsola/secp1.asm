.model small
.stack 64
.data
fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 42h  
.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
call clrscr
add fini,5
add cini,5
mov ffin,20
mov cfin,13
mov color,00h 
call clrscr

;-----------------------------
mov ah,4ch
int 21h
;-----procedimientos


clrscr proc near
push ax
push bx
push cx
mov ah,06h
mov al,00h
mov bh,color
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
end Inicio