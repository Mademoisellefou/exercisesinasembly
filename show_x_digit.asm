include macro1.asm
.model small
.stack 64
.data
num db 14 dup("$")
x db 12 dup("$")
msg1 db 10,13,"Ingrese el n numero :$"
msg2 db 10,13,"Ingrese el x digito :$"
salto db 10,13,"$"
.code 
Inicio: 
mov ax,@data
mov ds,ax                            
;-              
mostrarcad msg1
call leernum             
call numcad              
mostrarcad num
mostrarcad msg2
call leernum             
call xcad                
mostrarcad x             
call buscar
;-
mov ah,4ch
int 21h    
;--
buscar proc
push si
push di
push ax
mov si,0
lea si,num  
mov di,0
lea di,x
mov bl,[di]
;--
c7:       
        lea dx,salto               
        mov ah,09h
        int 21h
        mov ax,0
cmp [si],"$"
je sc7  
cmp [si],bl
jne nosame
mostrarcad x          
jmp sc7          
nosame:
inc si
jmp c7
sc7:    
pop ax
pop di
pop si
;--
ret
buscar endp
;..
    xcad proc
        push ax
        push bx
        push cx
        push dx 
        push si
        mov bx,10
        mov si,  0
        mov cx,0
        mov dx,0
        descomponerx:
        div bx
        push dx
        mov dx,0
        inc cx
        cmp ax,0
        je componerx
        jmp descomponerx
        componerx:
        pop dx
        add dl,30h
        mov x[si],dl
        inc si
        loop componerx
        mov x[si],"$"
        lea dx,salto               
        mov ah,09h
        int 21h
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    xcad endp 
;..          
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
        mov num[si],","
        inc si
        mov num[si],"$"
        lea dx,salto               
        mov ah,09h
        int 21h
        pop si
        pop dx
        pop cx
        pop bx
        pop ax
        ret
    numcad endp 

end Inicio
