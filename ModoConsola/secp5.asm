.model small
.stack 64
.data

cad1 db 2,"$"


fil db 0
col db 0

fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 21h
.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
call clrscr
call cuadrado1
call cuadrado2

ciclo1: ; espera que se presione end  o la tecla fin
mov ah,10h
int 16h
cmp ah,48h
je arriba
cmp ah,50h
je abajo
cmp ah,4bh
je izquierda
cmp ah, 4dh
je derecha
cmp ah,4fh 
je fin
jmp ciclo1
arriba: 
sub fil,1
call clrscr
call cuadrado1
call cuadrado2
call gotoxy
call mostrarcad
jmp ciclo1
abajo:
add fil,1
call clrscr
call cuadrado1
call cuadrado2
call gotoxy
call mostrarcad
jmp ciclo1
izquierda:
sub col,1
call clrscr
call cuadrado1
call cuadrado2
call gotoxy
call mostrarcad
jmp ciclo1
derecha:
add col,1
call clrscr
call cuadrado1
call cuadrado2
call gotoxy
call mostrarcad
jmp ciclo1	
fin: 
	

;-----------------------------
mov ah,4ch
int 21h
mostrarcad proc
push ax
push dx
mov ah,09h
lea dx,cad1
int 21h
pop dx
pop ax
ret
mostrarcad endp

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

cuadrado1 proc near
push ax
push bx
push cx
mov ah,06h
mov bh,31h
mov al,15
mov ch,5
mov cl,10
mov dh,20
mov dl,30
int 10h
pop cx
pop bx
pop ax
ret
cuadrado1 endp

cuadrado2 proc near
push ax
push bx
push cx
mov ah,06h
mov bh,51h
mov al,15
mov ch,5
mov cl,50
mov dh,20
mov dl,70
int 10h
pop cx
pop bx
pop ax
ret
cuadrado2 endp



gotoxy proc near
push dx
push bx
push ax
mov ah,02h
mov bh,00
mov dh,fil
mov dl,col
int 10h
pop ax
pop bx
pop dx

ret
gotoxy endp





end Inicio