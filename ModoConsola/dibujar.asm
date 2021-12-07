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

fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 90h
linv db 10,13,"DIBUJA UNA LINEA VERTICAL:$"
linh db 10,13,"DIBUJA UNA LINEA HORIZONTAL:$"
x1 db   10,13,"INGRESA CORDENADA DE X1:$"
x2 db   10,13,"INGRESA CORDENADA DE X2:$"
y1 db   10,13,"INGRESA CORDENADA DE Y1:$"
y2 db   10,13,"INGRESA CORDENADA DE Y2:$"
fil1 dw 0
col1 dw 0
fil2 dw 0
col2 dw 0 
.code
Inicio:
mov ax, @data
mov ds, ax

;-----------------------------


;mov ax,0


;---

;---------------------------
call clrscr
mov ah,00h  ;cambiar a modo grafico pixel
mov al,12h  ; res 640x480 
int 10h

	mostrarcad linv
	mostrarcad y1
	call leernum
	mov fil1,ax
	mostrarcad y2
	call leernum
	mov fil2,ax
	mostrarcad x1
	call leernum
	mov col1,ax
	mov col2,ax
	;;graficamos
	call clrscr
    mov dx,0
	mov cx,0 
    mov dx,fil1
    sub fil2,dx
    mov cx,fil2
    call lineav

	;----------
	mostrarcad linh
	mostrarcad y1
	call leernum
	mov fil1,ax
	mov fil2,ax
	mostrarcad x1
	call leernum
	mov col1,ax
	mostrarcad x2
	call leernum
	mov col2,ax
	;graficamos
	call clrscr
	mov dx,0
	mov cx,0 
    mov fil1,100
    mov fil2,100
    mov col1,100
    mov col2,200 
    mov dx,col1
    sub col2,dx
    mov cx,col2
	call lineah


;-----------------------------
mov ah,4ch
int 21h

lineav proc
push cx
push dx
push bx
push ax
ciclo1:
    add fil1,1
    push cx
	mov ah,0ch ; Escribe un Pixel
	mov al,34h
	mov bh,0
	mov cx,col1
	mov dx,fil1
	int 10h
    pop cx 
 loop ciclo1
   
pop ax
pop bx
pop dx
pop cx
ret
lineav endp


lineah proc
push cx
push dx
push bx
push ax
ciclo:
    ;add fil1,1
	add col1,1
    push cx
	mov ah,0ch ; Escribe un Pixel
	mov al,34h
	mov bh,0
	mov cx,col1
	mov dx,fil1
	int 10h
    pop cx 
 loop ciclo

   
pop ax
pop bx
pop dx
pop cx
ret
lineah endp 


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

end Inicio
