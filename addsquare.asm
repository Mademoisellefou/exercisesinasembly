
; Halla el cuadrado de la suma de los digitos
; de un numero
; 234: 2^2 + 3^2 + 4^2 = 29  
; 65535: 36+75+9

data segment
  num dw 0 
  sum dw 0 
ends

stack segment
    dw   128  dup(0)
ends

code segment  
start:      
    mov ax, data
    mov ds, ax

cmain:    
    mov num,123
    mov bx,10
    call sum_num
    

    salir:                
    mov ax,sum
    mov ah, 1
    int 21h
    
    mov ax, 4c00h
    int 21h    

sum_num:
     
     mov dx,0 
     mov ax,num
     div bx
     mov num,ax
     mov ax,dx
     mul dx
     add sum,ax
     cmp num,0
     jne sum_num 
     je salir
ret     

ends    
end start
