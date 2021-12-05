.model small
.stack 64
.data  
salto db 10,13,"$"
.code
start:

    mov ax, @data
    mov ds, ax
;= EJERCICIO      

    mov ax,432
    mov bh,00
    mov bl,10
    mov dx,0
    
    show:    
    div bl   
    mov cl,al
    mov dl,ah
    add dl,30h
    mov ah,02h
    int 21h
    mov ah,00
    mov al,cl    
    cmp al,0
    je sc1
    jmp show 
    sc1:
    mov ah,4ch
    int 21h 
    
;= EJERCICIO 
end start 
