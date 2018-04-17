initialization:

    mov     ah, 0   ; set display mode function.
    mov     al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    int     10h     ; set it!
    
    mov cx, 0; x-axis
    mov dx,20; y-axis
    mov ah, 0ch ; put pixel
    int 10h
    mov  bx , 0
    mov di ,0
    mov si,0
    mov al,[backgroundColor]               ; Background color 
ee:
    inc cx
    inc bx
    int 10h
    cmp bx,320
    jle ee
    inc dx
    inc di
    sub cx,320
    mov bx,0
    dec cx
    cmp di ,180
    jle ee
    
    
    
    mov cx, 0; x-axis
    mov dx,20; y-axis
    mov  bx , 0
    mov al,[linesColor]                 ; lines color
colcount:
    inc dx
    int 10h
    cmp dx, 200
    JNE colcount
p:
    inc bx
    cmp bx ,10
    je ii
    add cx,32
    mov dx,20
    jmp colcount
ii:
    mov bx,0
    mov dx,20
row: 
    mov cx,0
    
rowcount:
    inc cx
    int 10h
    cmp cx, 320
    jne rowcount
    inc bx
    cmp bx ,11
    je oo
    add dx,18
    jmp row
oo:
    ret