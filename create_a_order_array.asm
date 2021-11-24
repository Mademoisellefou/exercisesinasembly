include macro1.asm
.model small
.stack 64
.data
v db 30h,30h,30h,"$"
saltol db 10,13,"$"
space db ",$"
c dw 0
.code
Inicio:
mov ax,@data
mov ds,ax
;---         
   mov cx,3 
   mov si,0
   ciclo:   
    mov ah,01h
    int 21h
    mov v[si],al
    inc si
   loop ciclo

   mov cx,3 
   mov si,0    
   mostrarcad saltol
   ciclo1:  
    mov dl,v[si]
    mov ah,02h
    int 21h
    inc si
    mostrarcad space
   loop ciclo1  
   
   ;--- ordenamos el array
   mov si,0
   mov di,1
   mov cx,3
   ciclo3:    
   mov c,cx
   ciclo4:    
   mov al,v[si]
   cmp al,v[di]
   ja salto
   mov dl,v[di]
   mov v[di],al
   
   mov v[si],dl
   salto:      
   inc di
   loop ciclo4
   mov di,0
   inc si
   mov di,si
   inc di
   mov cx,c
   loop ciclo3
   
   ;--- mostramos
   mov cx,3 
   mov si,0
   ;---
   mostrarcad saltol
   ciclo5:  
    mov dl,v[si]
    mov ah,02h
    int 21h
    inc si      
    mostrarcad space
   loop ciclo5
;---
mov ah,4ch
int 21h
end Inicio
 
       
