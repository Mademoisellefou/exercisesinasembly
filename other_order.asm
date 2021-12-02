nuevalinea macro
push ax
push dx         
  lea dx,nl
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
v1 db 33h,32h,31h,30h,34h,"$"
.code 
inicio: 
  mov ax,@data
  mov ds,ax
  ;--
  
  mov ax,0 
  call counttam 
  call mostrar  
  nuevalinea
  call orderarr  
  call mostrar
  mov ah,4ch
  int 21h
  ;--
  
  counttam proc
  push si
  mov si,0
  c9:        
  mov al,v1[si]
  cmp al,"$"
  je sc9
  add tam,1    
  inc si
  jmp c9
  sc9: 
  mov ax,0
  pop si
  ret
  counttam endp             
  ;--
 mostrar proc    
    
 push si
 push ax
 push cx
 push dx    
 mov si,0
 mov cx,tam
 c3:    
 mov dl,v1[si]
 mov ah,02h
 int 21h
 nuevalinea
 inc si
 loop c3
 pop dx
 pop cx
 pop ax
 pop si
 ret    
 mostrar endp
        
 orderarr proc 
 push ax
 push bx
 push dx
 push cx
 mov si,0
 mov di,0  
 mov cx,tam
 dec cx
 order:      
 mov di,si
 inc di  
 mov ax,0   
 mov x,cx
 orderm:    
 mov al,v1[si] 
 cmp al,v1[di]
 jl nochange
 mov dl,v1[di]
 mov v1[si],dl
 mov v1[di],al
 nochange: 
 inc di 
 loop orderm  
 mov cx,0
 mov cx,x  
 inc si
 loop order
 pop cx
 pop dx
 pop bx
 pop ax
 ret 
 orderarr endp        
end inicio 
