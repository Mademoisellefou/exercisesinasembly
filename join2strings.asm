include macro1.asm
.model small
.stack 64
.data
cad1 db 15 dup("$") 
result db 10,13,"El resultado es $"
.code              
Inicio:   
mov ax,@data
mov ds,ax
;--       
mov ax,0   
mov bx,0
call leecad  
call leecad     
mostrarcad result
mostrarcad cad1
;--
mov ah,4ch 
int 21h
;--        
leecad proc 
push ax
push si
mov si,bx
ciclo1:  
push bx 
mov ah,01h
int 21h 
cmp al,13
je salir1
mov cad1[si],al
inc si
pop bx
inc bx
jmp ciclo1
salir1: 
pop bx
pop si
pop ax
ret
leecad endp
;--
end Inicio
