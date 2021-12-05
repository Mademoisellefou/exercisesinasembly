data segment
           v1 db 1,2,3,4,5 
           v2 db 0,0,0,0,0
           x dw 0
ends

stack segment
    dw   128  dup(0)
ends
                                
code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    mov al,5
    mov ah,3
    mov bh,ah
    mov bl,al
    mov ax,0 
    mov dl,0  
    mov dh,0
    mov di,0
    ;--
    mov cx,5
    
    c1:
    mov al,dl
    add al,bh
    div bl
    mov al,ah
    mov ah,0
    mov si,ax
    mov dh,0
    mov di,dx 
    mov dh,v1[di] 
    mov v2[si],dh
    inc dl
    add x,1
    loop c1  
    
    mov dx,0
    mov cx,x
    mov di,0
    lea di,v2
    c2:    
    mov dl,[di]
    add dl,30h
    mov ah,02h
    int 21h    
    mov dl," "
    int 21h
    inc di
    loop c2
    
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
