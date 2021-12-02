mostrarcad macro text
push ax
push dx
mov ah,09h
lea dx,text
int 21h
pop dx
pop ax
endm
data segment
    c dw 0
    a dw 0          
    num db 15 dup("$")
    salto  db 10,13,"$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax
    ;--cantidad de nros
    call leernum         
    ;--numeros fibo
    mov cx,ax
    mostrarcad salto
    call sucesion
    ;--         
    mov ax, 4c00h 
    int 21h     
    ;--
    leernum proc
    push bx
    push cx
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
    pop cx
    pop bx
    ret
    leernum endp
    ;--
    numcad proc
    push si
    push cx
    push bx 
    push dx
    mov bx,10 
    mov cx,0 
    mov dx,0
    mov si,0 
    lea si,num
    c3:    
    div bx
    push dx
    mov dx,0
    inc cx
    cmp ax,0
    je sc3
    jmp c3
    sc3:   
    pop dx
    add dl,30h
    mov [si],dl
    inc si
    loop sc3
    mov [si],","
    inc si     
    mov [si],"$"
      
    pop dx
    pop bx
    pop cx
    pop si

    ret 
    numcad endp              
    ;--  
    sucesion proc 
    push ax
    push bx
    ;_     
    mov ax,1
    mov bx,0
    c2:    
    add ax,bx  
    mov dx,0
    mov dx,ax
    call numcad
    mostrarcad num
    mov ax,bx
    mov bx,dx
    loop c2
    ;_
    pop ax
    pop bx
    ret
    sucesion endp

ends

end start ; 
