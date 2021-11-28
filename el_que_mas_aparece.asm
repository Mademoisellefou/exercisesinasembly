.model small
.stack 64
.data  
msgres db "El caracter que mas aparece es: $"
cad db "aaabbcs$"                        
mayc dw 0
nrc dw 0
c dw 0
xcad  db 12 dup("$")
.code 
Inicio: 
mov ax,@data
mov ds,ax                         
;--                
call tamcad
dec cx
call countmax
mov ah,4ch
int 21h    
;--
tamcad proc
push ax
push si
;--
mov si,0
lea si,cad
mov ax,0
mov cx,0
c3:     
push cx 
cmp [si],"$"
je salc3
pop cx
inc cx
inc si
jmp c3  
salc3:
pop cx
pop si
pop ax
;--
ret
tamcad endp    
;--
countmax proc
push ax
push bx
push dx
push si
push di
mov ax,0
mov bx,0
mov si,0
mov di,1
c1:   
mov c,cx
mov dx,0
mov dl,cad[si]
c2:
cmp dl,cad[di]
jne nosame
add nrc,1 
nosame:
inc di
loop c2  
mov bl,dl
mov dx,0
mov dx,nrc
cmp dx,mayc
jb nomay
mov mayc,dx
mov di,0
mov xcad[di],bl
nomay:  
mov nrc,0     
inc si 
mov di,si
inc di 
mov cx,c
loop c1
call resp
mov dx,0
lea dx,xcad
mov ah,09h
int 21h
pop di
pop si
pop dx
pop bx
pop ax
ret      
countmax endp
resp proc
push dx
push ax
mov dx,0
lea dx,msgres
mov ah,09h 
int 21h
pop ax
pop dx
ret
resp endp    
;--
end Inicio   
