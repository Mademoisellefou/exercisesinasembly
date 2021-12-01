
mostrarcad  macro text
push ax
push dx
mov ah,09h
lea dx,text
int 21h
pop dx
pop ax
endm
data segment
    pkey db "press any key...$"
    c dw 0  
    num db 25 dup("$")
ends
stack segment
    dw   128  dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

    ;- primos 
    call leernum
    mov c,ax   
    mov bx,2h
    mov dx,0h
    mov cx,0
    c1:     
        cmp cx,c
        je salc
        inc dx
        mov bx,2h 
        cmp dl,2h
        je esPrimo
        cmp dl,3h   
        je esPrimo
        cmp dl,4h
        jae veri
        veri:   
        mov al,dl
        div bl
        cmp ah,00
        je  noPrimo
        add bl,1
        cmp bl,al
        jge esPrimo
        jmp veri   
        esPrimo:
        inc cx
        noPrimo:      
        jmp c1    
    salc:        
    mov ax,dx
    call numcad
    mostrarcad num
    ;-
    mov ax, 4c00h
    int 21h      
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
ends

end start
