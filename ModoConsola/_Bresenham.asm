data segment
    x0 dw 0
    y0 dw 0
    x1 dw 50
    y1 dw 10 
    pcolor dw 0fh
    incE   dw 0
    incNE dw 0
    x dw 0
    y dw 0
    p dw 0    
    deltax dw 0    ;
    deltay dw 0
    pasox dw 0     ;paso en x
    pasoy dw 0     ; paso en y
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:

    mov ax, data
    mov ds, ax
    mov es, ax

    mov ah,00h   
    mov al,13h
    int 10h 
    ;===== FIJA CONSTANTES
    mov ax,0
    
    ;deltay=abs(yfinal-yinicial)
        mov ax,y1
        sub ax,y0                ; deltay=(y1-y0)
        jns  deltay_positivo1    ;if (deltay<0)
        neg ax                        ;abx(deltay)
        mov pasoy,-1                  ;pasoy=-1
        jmp end_deltay             
            deltay_positivo1:                 ;else
                mov pasoy,1                   ;pasoy=1
            end_deltay:
                mov deltay,ax           ; deltay=abs(y1-y0)
    
    ;deltax=abs(xfinal-xinicial)
    mov ax,x1
    sub ax,x0                  ;deltax=(x1-x0)
    jns deltax_positivo        ;if (deltax>0)
    neg ax                       ;abx(deltax)
    mov pasox,-1                 ;pasox=-1
    jmp end_positivo2            ;
        deltax_positivo:                    ;else
            mov pasox,1                   ;pasox=1
        end_positivo2:
            mov deltax,ax             ; deltax=abs(x1-x0)
    call _Bresenham
    
    mov ax, 4c00h 
    int 21h 
    ;===== 
    _Bresenham proc 
    ;p=2*deltay-deltax
    mov ax,deltay         
    shl ax,1                    ;los bits del destino del operando hacia la izquierda
    mov incE,ax                 ;incE=2*deltay DESPUES  =>p+=incE   si p<0   
    sub ax,deltax               
    mov p,ax                    ;p=2*deltay-deltax 
     
    ;incNE=2*(deltay-deltax)   p+=incNE si p>0
    mov ax, deltay
    sub ax,deltax
    shl ax,1
    mov incNE,ax              ;incNE=2*(deltay-deltax)
   
   
   
    ;GRAFICAR 
    mov ax,x0
    mov x,ax          ; x=x0
    mov ax,y0        
    mov y,ax          ; y=y0
    mov cx,x1         ; xend=x1
    mov ax,0
    mov bx,0
    mov dx,0
    while1:     
    cmp x,cx               ;while (x!=xend)
    je fin1                 ;salimos
    
      ;=== PINTAR PIXEL
        push cx
        mov ah,0ch ; Escribe un Pixel
    	mov al,34h 
    	mov bh,0
    	mov cx,x
    	mov dx,y
    	int 10h
    	pop cx
    	
      ;=== INCREMENTAR

        mov ax,pasox
        add x,ax                 ;x+=pasox
        mov ax,0                 
        
        mov ax,p                
        cmp ax,0              ; if(p<0)
            jns p_esmay0
                add ax,incE                 ;incE=2*deltay
                mov p,ax                    ;p+=incE
                jmp end_if1
            p_esmay0:                    
                add ax,incNE         ; incNE=2*(deltay-deltax)
                mov p,ax             ;p+=incNE
                mov ax,pasoy
                add y,ax                ;y+=pasoy
                mov ax,0
            end_if1:        
    jmp while1                
    fin1:    
    ret
    _Bresenham endp 
        
ends

end start 
