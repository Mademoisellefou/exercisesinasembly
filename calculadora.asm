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
menu db 10,13,"=============MENU================",10,13,
 db "       1. SUMA",10,13,
 db "       2. RESTA",10,13,
 db "       3. MULTIPLICACION",10,13,
 db "       4. DIVISION",10,13,
 db "       5. SALIR",10,13,"$"
ask db  10,13,"ingrese una op",10,13,"$"
msgnum db 10,13,"ingrese un numero: $"
 finp db 10,13,"adios$"
s db "Suma$"
r db "resta$"
d db "divi$"
m  db "mul$" 
salto db 10,13,"$"
num db 15  dup("$")
col db 35
fil db 5
pag db 0   
a dw 0
b dw 0
fini db 0
cini db 0
ffin db 24
cfin db 79
linea db 0
.code
Inicio: 
mov ax,@data
mov ds,ax  
  mov ax,0
 mostrarcad msgnum 
 call leernum
 call numcad 
 mostrarcad salto
 mov a,ax
 mov ax,0
 mostrarcad msgnum
 call leernum
 call numcad     
 mostrarcad salto
 mov b,ax  
mostrarcad menu   
;---
    ciclo1:
    mostrarcad ask
    mov ax,0
    mov ah,01h
    int 21h
    cmp al,31h
    je suma
    cmp al,32h
    je resta
    cmp al,33h
    je mult
    cmp al,34h
    je divi
    cmp al,35h
    je salir 
    jmp ciclo1
;---
suma:
mov ax,a
mov bx,b
add ax,bx
call numcad
call pant
jmp ciclo1
resta:
mov ax,a
mov bx,b
sub ax,bx
call numcad
call pant
jmp ciclo1
mult:         
mov ax,a
mov bx,b
mul bx
call numcad
call pant
jmp ciclo1
divi:
mov ax,a
mov bx,b
div bx
call numcad
call pant
jmp ciclo1
salir:   
mostrarcad finp
mov ah,4ch
int 21h
;--     
pant proc
mostrarcad salto
mostrarcad num
ret
pant endp
;---------
numcad proc
push ax
push bx
push cx
push dx 
push si
mov bx,10
mov si,  0
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
mov num[si],"$"
pop si
pop dx
pop cx
pop bx
pop ax
ret
numcad endp  
;--

leernum proc 
push bx
push cx
mov bx,10   
mov cx,0
mov ax,0
ciclo2:
push ax
mov ah,01h
int 21h
cmp al,13
je salir2
sub al,30h
mov cl,al
pop ax
mul bx
add ax, cx
jmp ciclo2
salir2:
pop ax
pop cx
pop bx
ret
leernum endp
;---
end Inicio
