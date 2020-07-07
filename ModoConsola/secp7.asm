.model small
.stack 64
.data

menu db "==============MENU=================0",10, 13,
     db "     1. Mostrar una cadena en en centro de la pantalla",10,13,
	 db "     2. Mostrar un rectangulo en la pantalla",10,13,
	 db "     3. Salir",10,13,
	 db "Ingrese una opcion",10,13,"$"

cad db "HOLA$"
gracias db 10,13,"Gracias, fin del programa$"
col db 35
fil db 12
pag db 0

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
ciclo1: 
call ubicar
mov ah,09h
lea  dx,menu
int 21h
mov ah,10h
 int 16h
 cmp ah,02h
 je uno
 cmp ah,03h
 je dos
 cmp ah,04h
 je tres
 jmp ciclo1
uno:
call clrscr
call  mostrarcad
jmp ciclo1
dos:
call clrscr
call  gotoxy
call rectangulo1
jmp ciclo1
tres:
call clrscr
mov ah,09h
lea dx,gracias
int 21h
final:
;-----------------------------
mov ah,4ch
int 21h

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
ubicar proc near
push dx
push bx
push ax
mov ah,02h
mov bh,00
mov dh,0
mov dl,0
int 10h
pop ax
pop bx
pop dx

ret
ubicar endp

mostrarcad proc
push ax
push dx
mov ah,09h
lea dx,cad
int 21h
pop dx
pop ax
ret
mostrarcad endp

rectangulo1 proc near
push ax
push bx
push cx
mov ah,06h
mov bh,41h
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
rectangulo1 endp



End Inicio