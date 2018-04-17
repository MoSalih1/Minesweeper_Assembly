;;;;;;; Print Function - > traverse whole map ;;;;;;
;;;;;;; It calls MaabPrint and flagPrint      ;;;;;;

print:

    mov     ecx,0 
l10:
    cmp     ecx, dword[m]
    jge     f10
    mov     edx,0
l20:
    cmp     edx, dword [n]
    jge     f20
    mov     ebx, ecx
    imul    ebx, dword[n]
    add     ebx, edx
    shl     ebx, 2
    cmp     dword[show+ebx],0
    jz      Hidden
    mov     eax, [map +ebx]
    ;;;;;;;;;;;;
    mov     [printk], eax
    mov     [printj], edx
    mov     [printi], ecx
    push    eax
    push    edx
    push    ecx
    call    MaabPrint
    pop     ecx
    pop     edx
    pop     eax
    ;add     esp,12
    mov     eax, [printk]
    mov     edx, [printj]
    mov     ecx, [printi]
    ;;;;;;;;;;;;   
    inc     edx
    jmp     l20
    
Hidden:                                          ; displaying hidden block
    cmp     dword[flag+ebx],0
    jnz     disFlag
    inc     edx
    jmp     l20
disFlag:     
    ;;;;;;;;;;;;
    push    edx
    push    ecx
    call    flagPrint
    pop     ecx
    pop     edx
    ;;;;;;;;;;;;
    inc     edx
    jmp     l20
f20:
    inc     ecx
    jmp     l10

f10:  
    ret
