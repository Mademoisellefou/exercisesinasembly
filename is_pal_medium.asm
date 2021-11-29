mostrarcad  macro text
push ax
push dx
mov ah,09h
lea dx,text
int 21h
pop dx
pop ax
endm
.model small
.stack 64
.data                 
salto db 10,13,"$"
p db "Anita lava latina$"
pal db 25 dup('$') 
palr db 25 dup('$')  
espal db "es palindrome$"
noespal db "no es palindrome$"       
.code
inicio:
mov ax,@data
mov ds,ax     
;--
call formarpal
call verificar
mov ah,4ch
int 21h
;----   
formarpal proc
push si
push di
push cx
push dx
push ax
mov si,0
lea di,pal
mov cx,0
mov bx,0
ciclo1:
mov ax,0
mov al,p[si]
cmp al,"$"
je salir
cmp al," "
je noinsert
cmp al,60h
ja noconvert
cmp al,41h
jb noconvert
cmp al,5ah
ja noconvert  
add al,20h
mov p[si],al
noconvert:
mov [di],al
push ax 
inc cx     
inc di
noinsert:
inc si
jmp ciclo1 
;=
salir:
mov si,0 
lea si,palr
c2:    
pop ax
mov [si],al
inc si
loop c2
;=
pop ax
pop dx
pop cx
pop di
pop si
ret
formarpal endp
verificar proc
push di
push si     
push dx
mov si,0
mov di,0
lea si,pal
lea di,palr
c3:        
cmp [si],"$"
je salc3
mov dl,[si]
cmp dl,[di]
je ispal
mostrarcad noespal
jmp salc4
ispal:
inc si
inc di          
jmp c3          
salc3:
mostrarcad espal
salc4:
pop dx
pop si
pop di
ret             
verificar endp    

end inicio      
