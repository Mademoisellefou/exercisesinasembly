;operaciones
include macro1.asm
.model small
.stack 64
.data
v1 db 15,62,"$" 
v2 db 14,37,"$" 
num db 23 dup("$")                        
msgs db "suma $"
msgr db   "resta $"
msgd db           "division $"
msgm db                      "multi $"
.code
Inicio:
mov ax,@data      
mov ds,ax         
;--       
mov cx,0
mov si,0
ciclo:
mov ax,0
mov al,v1[si]
cmp al,"$"
je salir 
mov bl,v2[si]
cmp bl,"$"
je salir
push ax
mov ax,0
mov ah,01h
int 21h
cmp al,"+"
je suma
cmp al,"-"
je resta 
cmp al,"*" 
je multi
cmp al,"/" 
je divi
nextnum:
inc si 
jmp ciclo
;-- 
suma:    
mostrarcad msgs
pop ax
add ax,bx
call numcad
jmp nextnum
resta:   
mostrarcad msgr
pop ax
sub ax,bx
call numcad
jmp nextnum
multi:
mostrarcad msgm
pop ax
mul bx
call numcad
jmp nextnum
divi:       
mostrarcad msgd
pop ax
div bx
call numcad
jmp nextnum
salir:    
mov ah,4ch
int 21h  
;--
numcad proc
push ax
push bx
push cx
push dx 
push si
mov bx,10
mov si,0
mov cx,0
mov dx,0
descomponer:
div bx
push dx
mov dx,0
inc cx
cmp ax,0
je componer
jmp descomponer
componer:
pop dx
add dl,30h
mov num[si],dl
inc si
loop componer
mov num[si],'$' 
mov ah,09h
lea dx,num
int 21h
pop si
pop dx
pop cx
pop bx
pop ax
ret
numcad endp
;-- 
end Inicio           
