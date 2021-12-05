mostrarcad macro text
push ax
push dx
lea dx,text
mov ah,09h 
int 21h
pop dx
pop ax

endm   
saltop macro
    push ax 
    push dx
    lea dx,salto 
    mov ah,09h
    int 21h 
    pop dx
    pop ax
endm
.model small
.stack 64
.data  
salto db 10,13,"$"
num db 12 dup("$")
nomed db "-1$"
.code
start:

    mov ax, @data
    mov ds, ax
;= EJERCICIO      
    mov dx,12254
    mov ax,dx
    call numcad
    mostrarcad num  
    mov dx,0
    mov ax,si
    mov bx,2
    div bx
    cmp dx,0
    jne  medm
    call nomedia
    jmp salir
    medm:
    mov cx,ax 
    call media        
    salir:
    mov ah,4ch
    int 21h 
    
;= EJERCICIO 

      
  nomedia proc 
  push dx
  push ax
  saltop  
  lea dx,nomed
  mov ah,09h
  int 21h
  pop ax
  pop dx
  ret
  nomedia endp        


  media proc
  mov si,0
  mov di,0
  c1:    
  mov di,si
  inc di
  mov dl,num[si]
  push cx
  c2:
      cmp dl,num[di]
      jne ismedia
      call nomedia
      jmp salc1 
      ismedia:
      inc di
  loop c2
  pop cx
  inc si
  loop c1 
  saltop
  mov si,ax
  mov dl,num[si]
  mov ah,02h
  int 21h
  salc1:
  pop cx
  ret
  media endp  
    
    
  numcad proc
    push ax
    push bx
    push cx
    push dx    
    mov dx,0
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
