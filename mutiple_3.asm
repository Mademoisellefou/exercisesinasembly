mostrarcad macro text
push ax
push dx 

lea dx,text
mov ah,09h 
int 21h    
lea dx,salto
int 21h    

pop dx
pop ax
endm    

data segment
  cad db  15 dup("$")     
  salto db 10,13,"$"  
  indc dw 0
  ncad db  15 dup("$")
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;--  multiples of 3
    call leernum
    call numcad
    call reverse
    mostrarcad cad
    mostrarcad ncad
    ;--  
    mov ah,4ch
    int 21h
    
    reverse proc
    ;-  
    push ax
    push bx
    push cx
    push dx
    mov si,0   
    mov di,0   
    mov dx,0
    mov cx,0
    c6:     
    mov dl,ncad[si]
    cmp dl,"$"
    je sc6
    push dx
    mov dx,0
    inc si 
    inc cx
    jmp c6
    sc6:     
       pop dx
       mov ncad[di],dl            
       inc di
       loop sc6
    pop dx
    pop cx
    pop bx
    pop ax
    ret        
    reverse endp
    
    leernum proc
    push cx
    push bx
    push dx
    mov ax,0
    mov cx,0      
    mov bx,10
    c5:   
       push ax
       mov ah,01h
       int 21h
       cmp al,13 
       je sc5
       sub al,30h
       mov cl,al
       pop ax
       mul bx
       add ax,cx                   
    jmp c5      
    sc5:
    pop ax   
    pop dx
    pop bx
    pop cx
    ret
    leernum endp        
    
    numcad proc
    push cx
    push dx
    push bx
    mov cx,0
    mov dx,0
    mov bx,10
    mov si,0        
    c1:     
        div bx
        push dx
        call ismul
        mov dx,0
        inc cx
        cmp ax,0
        je sc1
    jmp c1
    sc1:    
    pop dx
    add dl,30h
    mov cad[si],dl
    inc si 
    loop sc1
    pop bx
    pop dx
    pop cx
    ret
    numcad endp
    ismul proc
    push ax 
    push bx
    push dx
    push cx
    mov ax,dx
    mov cx,dx
    mov dx,0
    mov bx,3
    div bx
    cmp dx,0
    jne nomul
     mov si,indc 
     add cl,30h
     mov ncad[si],cl
     add indc,1
    nomul:
    pop cx
    pop dx
    pop bx
    pop ax
    ret 
    ismul endp        
    
    
    
ends

end start
