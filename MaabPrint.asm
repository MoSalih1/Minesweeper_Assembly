;;;; it takes index and value of the element to be displayes.. 0 - 8 ;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MaabPrint:

;    K-->esp+12                    -> edi 
;    j-->esp +8     cx             -> ecx   --> values to be changed for caller
;    i-->esp +4     dx             -> edx   

    mov     ecx,[esp+6]
    imul    ecx,32
    
    mov     edx,[esp+2]
    imul    edx,18
    add     edx,20

    mov     edi,[esp+10]
    
    pushad
    
    push    edi
    call    zerof
    pop     edi
    
    cmp     edi,0
    je      maab0
    cmp     edi,1
    je      one1
    cmp     edi,2
    je      two2
    cmp     edi,3
    je      three3
    cmp     edi,4
    je      four4
    cmp     edi,5
    je      five5
    cmp     edi,6
    je      six6
    cmp     edi,7
    je      seven7
    cmp     edi,8
    je      eight8
    popad
    ret
    
maab0:
    popad
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
one1:
    mov     al,1100b
    mov     ah, 0ch ; put pixel
    add     cx,14
    add     dx,4
    mov     bx,0
oness1:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,8
    jle     oness1
    inc     dx
    sub     cx,9
oness12:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,17
    jle     oness12
    mov     bx,0
    
oneh:
    sub     cx ,3
ones1:
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     dx
    inc     bx
    cmp     bx,9
    jle     oneh
oneq1:
    sub     cx ,8
oneq:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,21
    jle     oneq
    inc     dx
    sub     cx ,12
oneq2:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,33
    jle     oneq2
    
    popad
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
two2:
    mov    al,1100b
    mov     ah, 0ch ; put pixel
    add     cx,14
    add     dx,4
    mov     bx,0
    inc     dx                                          ; recently
    inc     dx                                          ; recently
ss122:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,8
    jle     ss122
    inc     dx
    sub     cx,9
ss1222:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,17
    jle     ss1222
    mov     bx,0
    
h22:
    sub     cx ,3
s122:
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     dx
    inc     bx
    cmp     bx,2
    jle     h22
q122:
    sub     cx ,9
q22:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,11
    jle     q22
    inc     dx
    sub     cx ,9
q222:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,20
    jle     q222
    
    
    
    sub     cx ,9
    mov     bx,0
q1022:
    inc     cx 
    int     10h
    inc     cx 
    int     10h
    inc     cx 
    int     10h
    inc     dx
    sub     cx,3
    inc     bx
    cmp     bx ,2
    jle     q1022
q022:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,11
    jle     q022
    inc     dx
    sub     cx ,9
q0122:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,20
    jle     q0122
    
    popad
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
three3:
    mov     al,1100b ; color
    mov     ah, 0ch ; put pixel
    add     cx,14
    add     dx,4
    mov     bx,0
ss133:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,8
    jle     ss133
    inc     dx
    sub     cx,9
ss1233:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,17
    jle     ss1233
    mov     bx,0
    
h33:
    sub     cx ,3
s133:
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     cx
    int     10h
    inc     dx
    inc     bx
    cmp     bx,2
    jle     h33
q133:
    sub     cx ,9
q33:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,11
    jle     q33
    inc     dx
    sub     cx ,9
q233:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,20
    jle     q233
    
    
    
    sub     cx ,3
    mov     bx,0
q1033:
    inc     cx 
    int     10h
    inc     cx 
    int     10h
    inc     cx 
    int     10h
    inc     dx
    sub     cx,3
    inc     bx
    cmp     bx ,2
    jle     q1033
    sub     cx,6
q033:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,11
    jle     q033
    inc     dx
    sub     cx ,9
q0133:
    inc     cx 
    int     10h
    inc     bx
    cmp     bx ,20
    jle     q0133
    
    popad
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
four4:
    push    di
    mov     al,1100b
    mov     ah, 0ch     ; put pixel
    add     cx, 13 
    add     dx, 1
    mov     bx,0
    mov     di ,0
ss14:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,2
    jle     ss14
    inc     dx
    sub     cx,2
    dec     cx
    mov     bx,0
    inc     di
    cmp     di,10
    jle     ss14
ss184:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,11
    jle     ss184
    inc     dx
    sub     cx,11
    dec     cx
    mov     bx,0
    inc     di
    cmp     di,12
    jle     ss184
    
    sub     dx ,4
    add     cx ,6
s84:
    inc     cx
    inc     bx
    int     10h
    cmp     bx,2
    jle     s84
    inc     dx
    sub     cx,2
    dec     cx
    mov     bx,0
    inc     di
    cmp     di,20
    jle     s84
    pop     di

    popad
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
five5:
mov al,1100b
    mov ah, 0ch ; put pixel
    add cx,14
    add dx,4
    mov bx,0
ss1550:                   ;;;;;;;;;;;;;line 1
    inc cx
    inc bx
    int 10h
    cmp bx,8
    jle ss1550
    inc dx
    sub cx,9
ss12550:                   ;;;;;;;;;;;;line2
    inc cx
    inc bx
    int 10h
    cmp bx,17
    jle ss12550
    mov bx,0
    sub cx ,6
h550:
    sub cx ,3
s1550:
    inc cx
    int 10h
    inc cx
    int 10h
    inc cx
    int 10h
    inc dx
    inc bx
    cmp bx,2
    jle h550
    sub cx ,3
q1550:
    ;
q550:
    inc cx 
    int 10h
    inc bx
    cmp bx ,11
    jle q550
    inc dx
    sub cx ,9
q2550:
    inc cx 
    int 10h
    inc bx
    cmp bx ,20
    jle q2550
    
    
    
    sub cx ,3
    mov bx,0
q1050:
    inc cx 
    int 10h
    inc cx 
    int 10h
    inc cx 
    int 10h
    inc dx
    sub cx,3
    inc bx
    cmp bx ,2
    jle q1050
    sub cx,6
q050:
    inc cx 
    int 10h
    inc bx
    cmp bx ,11
    jle q050
    inc dx
    sub cx ,9
q0150:
    inc cx 
    int 10h
    inc bx
    cmp bx ,20
    jle q0150
popad
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
six6:
    popad
    ret
seven7:
    popad
    ret
eight8:
    popad
    ret
