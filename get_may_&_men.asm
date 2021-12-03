mostrarcad macro text
push ax
push dx
lea dx,text
mov ah,09h 
int 21h
pop dx
pop ax

endm
.model small
.stack 64
.data
 salto db 10,13,"$"    
 espr db 10,13,"El numerode Pares es : ",10,13,"$"
 y dw 0
 num db 12 dup("$")    
 cad db 12 dup("$")    
 mayn db 0
 menn db 200


.code
start:

    mov ax, @data
    mov ds, ax
;=
    call leernum 
    call numcad   
    call maymennum
    mostrarcad salto 
    ;-
    add menn,30h
    add mayn,30h
    mov ah,02
    mov dl,mayn
    int 21h
    mov dl," "
    int 21h    
    mov dl,menn
    int 21h
    ;---
    mov ax, 4c00h 
    int 21h    
;=
    leernum proc 
    push cx
    push bx
    mov ax,0
    mov bx,10
    mov cx,0
    c1:
    push ax
    mov ah,01h
    int 21h
    cmp al,13
    je sc1   
    sub al,30h
    mov cl,al
    pop ax
    mul bx
    add ax,cx
    jmp c1  
    sc1:
    pop ax
    pop bx
    pop cx
    ret
    leernum endp
;=
    numcad proc
    push ax
    push bx
    push cx
    push dx
    mov cx,0
    mov bx,10
    mov si,0
    c6:   
    div bx
    push dx
    mov dx,0
    inc cx
    cmp ax,0
    je sc6
    jmp c6
    sc6:    
    pop dx
    add dl,30h
    mov num[si],dl
    inc si
    loop sc6
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    numcad endp        
;=
    maymennum proc
    mov si,0
    c9:   
    mov al,num[si]
    cmp al,"$"
    je sc9
    sub al,30h
    cmp al,menn
    ja pass1   
    mov menn,al
    pass1:
    cmp al,mayn
    jb pass2
    mov mayn,al
    pass2:    
    inc si
    jmp c9
    sc9:
    ret 
    maymennum endp        

end start 
