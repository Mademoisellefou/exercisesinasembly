mostrarcad macro text 
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
num db 14 dup("$")

.code
Inicio:
mov ax,@data
mov ds,ax
call leernum
call numcad 
mostrarcad num
call change
mostrarcad num        
mov ah,4ch
int 21h    
;-
change proc
push ax 
push bx
mov ax,0
mov bx,0
mov al,num[si-1]
mov bl,num[0]
mov num[0],al
mov num[si-1],bl
pop bx
pop ax
ret
change endp    
;-
leernum proc
push bx
push cx
mov ax,0
mov bx,10
mov si,0
mov cx,0
c5:
push ax 
mov ah,01h
int 21h
cmp al,13
je sc5
sub al,30h  
inc si
mov cl,al
pop ax   
mul bx
add ax,cx
jmp c5
sc5:
pop ax
;-
pop cx
pop bx

ret
leernum endp
;--
numcad proc
;-     
push dx
push ax
push bx
push cx
mov bx,10
mov cx,0
mov dx,0
mov di,0
lea di,num
c6: 
div bx
push dx
mov dx,0
inc cx
cmp ax,0
je jc6
jmp c6
jc6:
pop dx
add dl,30h
mov [di],dl
inc di
loop jc6
mov [di]," "
pop cx
pop bx
pop ax
pop dx
ret 
numcad endp    
;---
end inicio
