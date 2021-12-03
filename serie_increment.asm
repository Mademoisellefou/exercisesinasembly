mostrarcad macro text
push ax
push dx
lea dx,text
mov ah,09h 
int 21h
pop dx
pop ax    
endm    


.model small
.stack 64
.data
vcx dw 0
num db 15 dup("$")
.code
inicio:
mov ax,@data
mov ds,ax
;-
mov ax,1
mov cx,5
add vcx,1
c1:
push cx
mov cx,vcx
c2:
call numcad
mostrarcad num
loop c2
add vcx,1
pop cx
inc ax 
loop c1
;-
mov ah,4ch
int 21h
numcad proc
push cx
push bx
push dx  
push ax
mov cx,0
mov dx,0
mov bx,10 
mov si,0
c7:
div bx
push dx 
mov dx,0
inc cx
cmp ax,0
je sc7
jmp c7
sc7:
pop dx
add dl,30h
mov num[si],dl
inc si
loop sc7
mov num[si]," "
pop ax
pop dx
pop bx
pop cx
ret
numcad endp
end inicio

