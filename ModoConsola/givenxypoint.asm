.model small
.stack 64
.data

fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 79h
fil dw 200
col dw 200  
.code
Inicio:
mov ax, @data
mov ds, ax

;-----------------------------
 
call clrscr

mov ah,00h  ;cambiar a modo grafico pixel
mov al,12h  ; res 640x480 
int 10h



mov cx,77
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
end Inicio
