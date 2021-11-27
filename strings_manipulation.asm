; multi-segment executable file template.

data segment
    
    cad db "Ho,.$"
    cad2 db "Ho,.$"
    salto db 10,13,"$"
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax, data
    mov ds, ax
    mov es, ax 
    mov ax,0
    mov cx,0 
    call convertlower
    call mostrarsalto
    call convertupper
    call mostrarsalto
    call convertinverse  
    call mostrarsalto     
    call countpal   
    dec cx
    call ordenarpal 
    
      
                            
    mov ax, 4c00h    
    int 21h       
    countpal proc
    push si
    mov si,0
    mov cx,0
    lea si,cad
    c8:   
    push cx
    cmp [si],"$"
    je sc8
    inc si
    pop cx 
    inc cx
    jmp c8
    sc8:
    pop cx 
    pop si
    
    
    
    
    ret 
    countpal endp        
    mostrarsalto proc
    push dx
    push ax
    lea dx,salto
    mov ah,09h
    int 21h
    pop ax
    pop dx
    ret
    mostrarsalto endp        
    convertupper proc
    push ax
    push si   
    push dx
    push di
    mov ax,0
    mov di,0
    lea di,cad2
    mov si,0
    lea si,cad
    c3:      
    mov dl,[si]
    mov [di],dl
    cmp [si],"$"
    je salir3
    cmp [si],61h
    jb noconvert3
    cmp [si],7ah
    ja noconvert3
    sub dl,20h
    mov [di],dl
    noconvert3:
    inc si
    inc di
    jmp c3
    salir3:   
    mov dx,0
    lea dx,cad2
    mov ah,09h
    int 21h
    pop di  
    pop dx         
    pop si
    pop ax

    ret        
    convertupper endp
    convertlower proc
    push ax
    push si   
    push dx
    push di
    mov dx,0
    mov ax,0
    mov si,0
    lea si,cad
    mov di,0
    lea di,cad2
    c2:     
    mov dl,[si]
    mov [di],dl
    cmp [si],"$"
    je salir2
    cmp [si],41h
    jb noconvert2
    cmp [si],5ah
    ja noconvert2
    add dl,20h
    mov [di],dl
    noconvert2:
    inc si
    inc di
    jmp c2
    salir2:
    mov dx,0
    lea dx,cad2
    mov ah,09h
    int 21h
    pop di  
    pop dx         
    pop si
    pop ax

    ret
    convertlower endp        
    
    convertinverse proc
    push ax
    push si   
    push dx
    push di
    mov dx,0
    mov ax,0
    mov di,0
    lea di,cad2    
    mov si,0
    lea si,cad
    c1:       
    mov dl,[si]
    mov [di],dl
    cmp [si],"$"
    je salir
    cmp [si],61h
    jb maychar
    cmp [si],7ah
    ja noconvert
    sub dl,20h
    mov [di],dl
    jmp noconvert
    maychar:
    cmp [si],41h
    jb noconvert
    cmp [si],5ah
    ja noconvert
    add dl,20h
    mov [di],dl
    noconvert:
    inc si
    inc di
    jmp c1
    salir:
    lea dx,cad2
    mov ah,09h
    int 21h
    pop di  
    pop dx         
    pop si
    pop ax
    ret
    convertinverse endp
    ordenarpal proc
    push di
    push ax
    push dx
    push bx
    push si
    mov di,0
    mov ax,0 
    mov dx,0
    mov si,0
    c6:
    mov di,si
    inc di 
    mov dx,0
    mov dx,cx
    c7:  
    mov ah,0
    mov al, cad[si]
    cmp al,cad[di]
    jb nomay
    mov bl,cad[di]
    mov cad[di],al
    mov cad[si],bl

    nomay:
    inc di
    loop c7  
    mov cx,0
    mov cx,dx
    inc si
    loop c6
    
    lea dx,cad
    mov ah,09h
    int 21h
    pop si
    pop bx
    pop dx
    pop ax
    pop di

    ret 
    ordenarpal endp            
ends

end start
