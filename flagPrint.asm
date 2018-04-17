flagPrint:
;;parameters(i,j)
    mov     ecx,[esp+6]
    imul    ecx,32
    
    mov     edx,[esp+2]
    imul    edx,18
    add     edx,20


    push    di
    ;mov    ah, 0   ; set display mode function.
    ;mov    al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    ;int    10h     ; set it!
    
    mov     al,[flagColor]
    ;mov    cx, 0; x-axis
    ;mov    dx,20; y-axis
    mov     ah, 0ch ; put pixel
    add     cx,8
   ; add     dx,4
    mov     bx,0
    mov     di ,0
    inc     dx
    
ss1f:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,8
    jle     ss1f
    inc     dx
    inc     di
    sub     cx,9
    mov     bx,0
    cmp     di ,8
    jle     ss1f
    add     cx ,9
hf:
    sub     cx ,3
s1f:
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     dx
    inc     bx
    cmp     bx,4
    jle     hf
q1f:
    sub     cx ,9
qf:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,19
    jle     qf
    inc     dx
    sub     cx ,15
q2f:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,34
    jle     q2f
    
    pop di
ret