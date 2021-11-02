include macro1.asm
.model small
.stack 64
.data                 
salto db 10,13,"$"
p db "el$"
pal db 25 dup('$') 
espal db "es palindrome$"
noespal db "no es palindrome$" 
.code
inicio:
mov ax,@data
mov ds,ax 
;---      
mov si,0
mov cx,0
mov bx,0
ciclo1:   
  mov ax,0
  mov al,p[si]
  cmp al,"$"
  je salir    
  push ax
  inc si
jmp ciclo1
salir:
    mov bx,si  
    mov cx,si
    mov si,0
    mov ax,0  
ciclo2: 
    pop ax 
    mov pal[si],al
    inc si
loop ciclo2
mov si,0   
mov ax,0
mov cx,bx
ciclo3: 
    mov al,pal[si]
    cmp al,p[si]
    jne noes
    inc si
loop ciclo3
    mostrarcad espal
    jmp salirp
noes:   
    mostrarcad noespal  
    jmp salirp
;--       
salirp:
mov ah,4ch
int 21h
end inicio
