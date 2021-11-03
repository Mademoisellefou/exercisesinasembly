data segment
    c db 0        
    mayn db 0
    v1 db 8,9,6,7
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
    mov al,4
    mov cl,al
    mov c,cl
    ciclo1:
        cmp al,0
        je salir
        mov si,0 
        mov di,0
        mov mayn,0
        ciclo2:
              mov dl,v1[si]
              cmp dl,mayn
              jb menor
              mov mayn,dl
              mov di,si
              menor:
              inc si
        loop ciclo2 
        mov dh,0    
        mov dl,v1[di]
        push dx         
        mov v1[di],0
        mov cx,0
        mov cx,si
    sub al,1
    jmp ciclo1
    salir:
    mov cx,0
    mov cl,c  
    ciclo3:    
    pop dx 
    add dl,30h
    mov ah,02h
    int 21h
    mov dl,','
    int 21h
    loop ciclo3
    
    
    
    mov ax, 4c00h
    int 21h    
ends
end start ;
