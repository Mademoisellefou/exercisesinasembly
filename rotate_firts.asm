mostrarcad macro text
push ax
push dx         
  lea dx,text
  mov ah,9
  int 21h
pop dx
pop ax  
endm
  
  
  
.model small
.stack 100h


.data
x dw 0
y dw 0  
tam dw 0
nl   db  10,13,'$'            
nrorot db 10,13,"=============================",10,13,
 db  "ingrese una nro de rotaciones:",10,13,"$"
cadi db 12 dup("$")
cads db 12 dup("$")
num db 12 dup("$")
v1 db 36h,20h,14h,"$"
.code 
inicio: 
  mov ax,@data
  mov ds,ax
  ;--
                
  mov ax,0 
  call recorer 
  mostrarcad nrorot  
  call leernum
  mov x,ax
  call movepos     
  mostrarcad nl
  ;mostrarcad cads
  mostrarcad nl
  call repartes  
  
  ;==========
  mov ah,4ch
  int 21h
  ;==========
  repartes proc
  mov cx, tam
  mov si,0
  c3:    
  mov al,v1[si]
  mov dl,cads[si]
  call numcad
  mov num[0],dl
  mostrarcad num  
  inc si    
  loop c3
  
  ret
  repartes endp    
  movepos proc
  mov si,0
  mov ax,0  
  
  mov cx,tam
  sub cx,x
  mov x,cx
  mov cx,tam
  mov bx,tam
  c2:        
  mov ax,si
  add ax,x
  div bx
  mov di,dx
  mov dx,0   
  mov al,cadi[si]
  mov cads[di],al
  inc si
  loop c2
  ret    
  movepos endp
  
  leernum proc
  push bx
  push cx
  mov bx,10
  mov ax,0
  mov cx,0
  c1:   
  push ax 
  mov ah,01h
  int 21h
  cmp al,13
   je sc1
   sub al,30h
   mov cl,al  
   pop ax
   mul bx
   add ax,cx
   jmp c1
  sc1:
  pop ax
  pop cx
  pop bx
  ret    
  leernum endp
  
  recorer proc
  push si
  mov si,0
  c9:        
  mov al,v1[si]
  cmp al,"$"
  je sc9
  call numcad  
  mov dl,num[0]
  mov cadi[si],dl
  mostrarcad num
  inc si
  jmp c9
  sc9:  
  mov tam,si
  mov ax,0
  pop si
  ret
  recorer endp  
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
    mov num[si],' ' 
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
    numcad endp
  
  ;--
end inicio 
