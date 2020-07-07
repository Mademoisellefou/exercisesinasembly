.model small
.stack 64
.data
.code
Inicio:
mov ax,0b800h
mov es,ax
;-------------------
	mov si,2000
	mov cx,30
	mov al,'a'
	mov bl,41h
ciclo:	
	mov es:[si],al
	inc si
	add al,1
	mov es:[si],bl
	inc si
	add bl,11h
	loop ciclo

;-------------------
	mov ah,4ch
	int 21h

end Inicio