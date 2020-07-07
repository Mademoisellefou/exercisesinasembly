.model small
.stack 64
.data
cad1 db "Presione tecla END....!",10,13,"$"
cad2 db "GRACIAS....!$"
.code
Inicio:
mov ax, @data
mov ds, ax
;-----------------------------
mov ah,09h
lea dx,cad1
int 21h
ciclo1: ; espera que se presione la tecla END
	 mov ah,10h
	int 16h
cmp ah,4fh
je fin
jmp ciclo1
fin: 
	mov ah,09h
	lea dx,cad2
	int 21h

;-----------------------------
mov ah,4ch
int 21h

end Inicio