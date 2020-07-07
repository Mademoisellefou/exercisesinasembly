.model small
.stack 64    ;ejercicio practico con limites 
.data

cad1 db 2,"$" ;codigo hexa 2
fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
color db 51h

fil db 0
col db 0
pag db 0

.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
call clrscr
call cuadrado1
call cuadrado2

ciclo1: ; espera que se presione una tecla
	mov ah,10h
	int 16h
	cmp ah,48h
	je arriba
	cmp ah,50h
	je abajoa
	cmp ah,4bh
	je izquierdaa
	cmp ah,4dh
	je derechaa
	cmp ah,01h   ;sale con la tecla Esc
	je finf
	jmp ciclo1
arriba: 
        cmp fil,0
	je ciclo1
        cmp fil,21
	je inteA
	cmp fil,6
	je inteA
	go3:
        sub fil,1
	call drawmap
	jmp ciclo1
inte1:
    jmp ciclo1	
inteA:
        cmp col,10
	jb go3
	cmp col,70
	ja go3
	cmp col,51
	ja inte1
        cmp col,31 
	ja go3
	cmp col,10
	jae inte1
	cmp col,30
	jbe inte1	
abajoa:
    jmp abajo
izquierdaa:
    jmp izquierda
derechaa:
    jmp derecha
finf:
    jmp fin
abajo: 
        cmp fil,24
	je inte2
	cmp fil,5
	je inte2A
        go6:
	add fil,1
	call drawmap
	jmp ciclo1
inte2:
    jmp ciclo1	
inte2A:
        cmp col,9
	jbe go6
	cmp col,70
	ja go6
	cmp col,50
	jae inte2
	cmp col,31
	jae go6
	cmp col,10
	jae inte2
	cmp col,30
	jbe inte2
izquierda: 
	cmp col,0
	je inte3
	cmp col,31
	je inte3A
	cmp col,71
	je inte3A 
	go9:
	sub col,1
	call drawmap
	jmp ciclo1
inte3:
    jmp ciclo1	
inte3A:
     cmp fil,4
	jbe go9
    cmp fil,21
	jae go9
    cmp fil,5
	je inte3
	cmp fil,20
	je inte3
derecha: 
	cmp col,79
	je inte4
	cmp col,9
	je inte4A
	cmp col,49
	je inte4A
go:
        add  col,1
	call drawmap
	jmp ciclo1	
inte4:
 jmp ciclo1
inte4A:
    cmp fil,4
	jbe go
    cmp fil,21
	jae go
	jb inte4
   cmp fil,5
	je  inte4
	cmp fil,20
	jbe inte4
fin:
mov ah,4ch
int 21h
;-----------------------------

drawmap proc 
    call clrscr
	call cuadrado1
	call cuadrado2
	call gotoxy
	call mosCad  
   
ret 
drawmap endp

mosCad proc   
    push ax dx
	
    mov ah,09h
    lea dx,cad1
    int 21h
	
	pop dx ax
ret 
mosCad endp




clrscr proc near
push ax
push bx
push cx
mov ax, 0600h
mov bh,color
mov cx,0000
mov dx,184fh
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
mov ah, 06h
mov bh,31h
mov al,15 ;recorremos 15 lineas
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
mov ah, 06h
mov bh,21h
mov al,15 ;recorremos 15 lineas
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

gotoxy proc 
	push ax bx dx
	mov ah,02h
	mov bh,pag
	mov dh,fil
	mov dl,col
	int 10h
	
	pop dx bx ax

	ret
gotoxy endp

end Inicio