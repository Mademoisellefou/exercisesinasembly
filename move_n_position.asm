data segment
    c db 0
    v1 db 1,2,3
    v2 db 0,0,0
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax, data
    mov ds, ax
    mov es, ax

    mov cx,0
    mov ax,0
    mov dx,0
    mov al,1
    mov ah,3
    mov bl,ah
    mov cl,ah
    mov c,al
    mov si,0
    mov di,0  
    mov ax,0
    ciclo:    
         mov ax,si
         add al,c
         div bx
         mov di,dx
         mov dl,v1[si]
         mov v2[di],dl
         mov ax,0
         mov dx,0
         inc si
    loop ciclo 
    mov cx,0
    mov cl,bl
    mov dl,0        
    mov si,0
    ciclo2:      
          mov dl,v2[si]   
          add dl,30h
          mov ah,02h
          int 21h 
          mov dl,','
          int 21h  
          inc si
    loop ciclo2
    
            

    mov ax, 4c00h ; 
    int 21h    
ends

end start ;
