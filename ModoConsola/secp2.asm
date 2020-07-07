.model small
.stack 64
.data

fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 42h  

cad db "HOLA$"

fil db 12
col db 40
pag db 0

.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
call clrscr
call gotoxy
mov ah,09h
lea dx,cad
int 21h
mov  fil,6
mov col,20
call gotoxy
int 21h
mov fil,6
mov col,60
call gotoxy
int 21h

;-----------------------------
mov ah,4ch
int 21h
;-----procedimientos

gotoxy proc 
	push ax
	push bx
	push dx
	mov ah,02h	
	mov bh,pag
	mov dh,fil
	mov dl,col
	int 10h
	pop dx
	pop bx
	pop ax

	ret
gotoxy endp

clrscr proc near
push ax
push bx
push cx
mov ah, 06h
mov bh,color
mov al,linea
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