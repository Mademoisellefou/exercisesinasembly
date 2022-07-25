
; Numero Feliz
; 234: 2^2 + 3^2 + 4^2 = 29  
; 65535: 36+75+9

data segment
  num           dw 0   
  sum           dw 0 
  sw            db 0  ; 0->:(, 1->:)  
  msj_feliz     db "Es un numero feliz  :)$"
  msj_no_feliz  db "No es un numero feliz  :($"
ends

stack segment
    dw   128  dup(0)
ends

code segment  
start:      
    mov ax, data
    mov ds, ax
    
    ;limites    
    ;16bits -> 65535
    ;8 bits -> 255
    ;32bits -> 4.294.967.295  
    mov num, 100   
    call es_feliz 
    
    cmp sw, 0
    jne feliz
        no_feliz:   
            lea dx, msj_no_feliz
            mov ah,9
            int 21h
        feliz: 
            lea dx, msj_feliz
            mov ah,9
            int 21h 
    
    salir:        
    mov ah, 1
    int 21h
    
    mov ax, 4c00h
    int 21h    
       


es_feliz proc
    
    call suma_cuadrados     
    cmp sum,4
    jne verificarf
        mov sw,0
        jmp salirf
    verificarf:
    cmp sum,1    
    jne continuaf  
        mov  sw,1
        jmp salirf
    continuaf:
    mov ax,sum
    mov num,ax
    mov sum,0        
    call es_feliz
    salirf:
ret
es_feliz endp 

suma_cuadrados proc  
  mov bx,10
  ciclo:  
    mov dx,0
    mov ax,num
    div bx
    mov num,ax
    mov ax,dx
    mul dx
    add sum,ax
    cmp num,0
    jne ciclo
    
ret
suma_cuadrados endp 


ret
ends    
end start
