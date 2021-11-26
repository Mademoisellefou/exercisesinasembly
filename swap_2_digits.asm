include macro1.asm
.model small
.stack 64
.data
a dw 123      
num db 15 dup("$")
x dw 1
y dw 2
.code
Inicio:
mov ax,@data
mov ds,ax
;--            
mov ax,0
mov ax,a
call numcad   
mostrarcad num
call swapcad
mostrarcad num 
;-
mov ah,4ch
int 21h        
;--
numcad proc
; Convierte un numero en cadena. Requiere en AX el numero y devuelve en num la cadena 
	push cx
	push si
	push dx
	push bx
	push ax
	mov bx,10
	mov cx,0
	mov dx,0
	mov si,0
digitos:
	div bx
	push dx
	mov dx,0
	inc cx
	cmp ax,0
	je cadena
	jmp digitos
cadena:
	pop dx
	add dl,30h
	mov num[si],dl   
	inc si
	loop cadena
	mov num[si],' '
	pop ax
	pop bx
	pop dx
	pop si
	pop cx
	ret
numcad endp
;--
swapcad proc
push ax
push dx
push si
push di
mov ax,0
mov dx,0
mov si,0
cicloswap:
mov al,num[si]
cmp al,"$"
je salirswap
cmp si,x
jne noswap
mov di,y
mov dl,num[di]
mov num[di],al
mov num[si],dl
jmp salirswap
noswap:
inc si
jmp cicloswap

;--
salirswap:
pop di    
pop si
pop dx
pop ax

ret
swapcad endp   

end Inicio
