zerof:
    push    ecx
    push    edx
    push    di
    mov     al,[zeroColor]                      ; color opened color
    mov     ah, 0ch                             ; put pixel
    mov     bx,0
    mov     di,0
    inc     dx
e09:
    inc cx
    inc bx
    int 10h
    cmp bx,30
    jle e09
    inc dx
    inc di
    sub cx,30
    mov bx,0
    dec cx
    cmp di ,16
    jle e09
    pop di
    pop edx
    pop ecx
 ret
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;This is used to remove the flag ;;;;;;;;;;;;
flagf:
    mov     ecx,[esp+6]
    imul    ecx,32
    mov     edx,[esp+2]
    imul    edx,18
    add     edx,20
    call    zerof
    push    ecx
    push    edx
    push    di
    ;mov ah, 0   ; set display mode function.
    ;mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    ;int 10h     ; set it!
    
    mov al,[backgroundColor]  ;                 color opened color
    ;mov cx, 0; x-axis
    ;mov dx,20; y-axis
    mov ah, 0ch ; put pixel
    mov bx,0
    mov di,0
    inc dx
e0999:
    inc cx
    inc bx
    int 10h
    cmp bx,30
    jle e0999
    inc dx
    inc di
    sub cx,30
    mov bx,0
    dec cx
    cmp di ,16
    jle e0999
    pop di
    pop edx
    pop ecx
        
ret