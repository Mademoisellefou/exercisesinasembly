mostrarcad macro texto
push ax
push dx 
lea dx,texto
mov ah,09h
int 21h
pop dx
pop ax
endm

.model small
.stack 64
.data
P1 db "INGRESA PUNTO DE INICIO:$",10,13,"$"
P2 db "INGRESA PUNTO DE FIN:$",10,13,"$"
fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 79h
fil dw 0
col dw 0 
.code
Inicio:
mov ax, @data
mov ds, ax

;----------------------------
mov ax,0
mostrarcad P1
call leernum
mov col,ax
mostrarcad P2
call leernum
mov fil,ax

;---------------------------
call clrscr

mov ah,00h  ;cambiar a modo grafico pixel
mov al,12h  ; res 640x480 
int 10h


mov cx,100
ciclo:
    add fil,1
	;add col,1
    push cx
	mov ah,0ch ; Escribe un Pixel
	mov al,62h
	mov bh,0
	mov cx,col
	mov dx,fil
	int 10h
    pop cx 
 loop ciclo


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
;-------
end Inicio
