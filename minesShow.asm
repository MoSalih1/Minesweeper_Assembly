mineShow:
    ;;;; [i]
    ;;;; [j]
    ;;;;;;;;;Call blackMine;;;;;
    ;;;;;;;;;With red background;;;
    mov     ecx,[j]
    imul    ecx,32
    mov     edx,[i]
    imul    edx,18
    add     edx,20
    
    push    ecx
    push    edx
    push    di
    xor     ebx,ebx
    mov     bl,[zeroColor]
    push    bx
    mov     byte[zeroColor], 4
    call    zerof
    pop     bx
    mov     [zeroColor],bl
    pop     di
    pop     edx
    pop     ecx
    
    
    push    ecx
    push    edx
    push    di
    mov     byte[bombColor], 0
    call    darwBomb
    pop     di
    pop     edx
    pop     ecx
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov     ecx,0
minelines:
    cmp     ecx, dword[m]
    jge     lines
    mov     edx,0
minecols:
    cmp     edx, dword[n]
    jge     cols
    
    mov     eax, ecx
    imul    eax, dword[n]
    add     eax, edx
    imul    eax, 4
    
    cmp     ecx,[i]
    jne     checkMine
    cmp     edx, [j]
    jne     checkMine
    jmp     nextElement

checkMine:
    cmp     dword[map+eax] , -1
    jne     checkFlags
    
    cmp     dword[flag+eax], 1
    jne     blackMine
    
    ;;;;;;;;;Checked Mine;;;;;;;
    ;;;;;;;;;GreenMine;;;;;;;;;;
    
    push    edx
    push    ecx
    call    flagf
    pop     ecx
    pop     edx
    
    
    push    ecx
    push    edx
    push    di
    mov     byte[bombColor], 2
    xchg    ecx,edx
    imul    ecx,32
    imul    edx,18
    add     edx,20
    call    darwBomb
    pop     di
    pop     edx
    pop     ecx
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jmp     nextElement
blackMine:
    ;;;;;if mine had no flag ;;
    ;;;;;  black mine ;;;;;;;;;
    push    ecx
    push    edx
    push    di
    mov     byte[bombColor], 0
    xchg    ecx,edx
    imul    ecx,32
    imul    edx,18
    add     edx,20
    call    darwBomb
    pop     di
    pop     edx
    pop     ecx
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jmp     nextElement
checkFlags:
    cmp     dword[flag+eax], 1
    jne     nextElement
    ;;;;;;;;flag without Mine ;;;;;;;;;;;;;;;;;;
    ;;;;;;;; Fake Mine -- > crossed ;;;;
    
    push    edx
    push    ecx
    call    flagf
    pop     ecx
    pop     edx
    
    
    push    ecx
    push    edx
    push    di
    mov     byte[bombColor], 0
    mov     dword[cross],1
    xchg    ecx,edx
    imul    ecx,32
    imul    edx,18
    add     edx,20
    call    darwBomb
    pop     di
    pop     edx
    pop     ecx
    ;;;;;;;;;;;;;;;;;;;;;;;;;;
nextElement:
    inc     edx
    jmp     minecols
cols:
    inc     ecx
    jmp     minelines
lines:
ret