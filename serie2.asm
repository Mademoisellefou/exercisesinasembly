mostrarcad  macro text
push ax
push dx
mov ah,09h
lea dx,text
int 21h
pop dx
pop ax
endm
data segment
     num db 16 dup("$")
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

;--
mov ax,0
mov bx,0
mov ax,1
mov bx,2
mov dx,0
mov cx,0
;--         
call numcad
call leernum
mov cx,ax 
mov ax,1
c1:    
cmp bx,dx
jne notnext
inc bx
mov dx,0
notnext:
mostrarcad num
inc dx
add ax,bx 
call numcad
loop c1  
        mov ax, 4c00h
        int 21h 
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
numcad proc
	push cx
	push si
	push dx
	push bx
	push ax
	mov bx,10
	mov cx,0
	mov dx,0
	mov si,0
digitos:
	div bx
	push dx
	mov dx,0
	inc cx
	cmp ax,0
	je cadena
	jmp digitos
cadena:
	pop dx
	add dl,30h
	mov num[si],dl   
	inc si
	loop cadena
	mov num[si],' '
	pop ax
	pop bx
	pop dx
	pop si
	pop cx
	ret
ret
numcad endp         
   
ends

end start 
