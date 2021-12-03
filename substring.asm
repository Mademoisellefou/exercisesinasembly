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
  cad db  "1234$"     
  salto db 10,13,"$"
  scad db  15 dup("$")
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
    mov cx,0 
    mov dx,0
    call contarcad 
    call substrings
    ;-- 
    mov ah,04
    int 21h
    
   
    substrings proc 
    dec cx
    mov si,0
    c4: 
     push cx
     push si
     mov cx,2  ;CHANGE IF YOU WANT
     mov di,0
     c6:       
      mov dl,cad[si]
      mov scad[di],dl
      inc di
      inc si
     loop c6
     mostrarcad scad
     pop si
     pop cx
     inc si
    loop c4
    ret        
    substrings  endp           
    
    contarcad proc    
    mov si,0
    mov cx,0   
    lea si,cad
    c1:   
        cmp [si],"$"
        je sc1 
        inc cx     
        inc si
    jmp c1    
    sc1:
    ret
    contarcad endp
    
ends

end start
