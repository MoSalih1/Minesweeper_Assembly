_showAdj:     


     mov    ecx,  [i]    ;i
     mov    esi,  [j]    ;j

;test1:
     cmp    ecx,0    
     jle    q1
     cmp    esi,0
     jle    q1
element1:
    dec     ecx ;i-1
    dec     esi ;j-1
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     q3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      q2
    mov     dword [show+eax],1
    jmp     q2
q3:
    cmp     dword [map+eax],0
    jne     q2
    cmp     dword [show+eax],0
    jne     q2
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      q2
    mov     dword [show+eax],1

    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
 
q2:
    inc     ecx ;i
    inc     esi ;j
q1:
    ;;;;;;;;;;;;;;;;;;
    
;test2:    
    cmp     esi,0
    jle     g1
    cmp     esi, [n]
    jge     g1
    cmp     ecx,0
    jl      g1
    cmp     ecx,[m]
    jge     g1
element2:
    dec     esi ;j-1
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     g3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      g2
    mov     dword [show+eax],1
    jmp     g2
g3:
    cmp     dword [map+eax],0
    jne     g2
    cmp     dword [show+eax],0
    jne     g2
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      g2
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
g2:
    inc     esi ;; j
g1:
    ;;;;;;;;;;;;;;;;;;
    
;test3:
    inc     ecx
    cmp     ecx,[m]    
    jge     u1
    cmp     esi,0
    jle     u1
element3:
    dec     esi ;j-1
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     u3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      u2
    mov     dword [show+eax],1
    jmp     u2
u3:
    cmp     dword [map+eax],0
    jne     u2
    cmp     dword [show+eax],0
    jne     u2
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      u2
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
u2:
    inc     esi      ;  j
u1:
    dec     ecx
    ;;;;;;;;;;;;;;;;;
    
;test4:    
    cmp     ecx,0    
    jle     w1
element4:
    dec     ecx ;i-1
    mov     eax,ecx
    imul     eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     w3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      w2
    mov     dword [show+eax],1
    jmp     w2
w3:
    cmp     dword [map+eax],0
    jne     w2
    cmp     dword [show+eax],0
    jne     w2
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      w2
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
w2:
    inc     ecx
w1:
    ;;;;;;;;;;;;;;;;;;;
    
    
;test5:    
    inc     ecx
    cmp     ecx, dword[m]
    jge     l1
element5:
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     l3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      l1
    mov     dword [show+eax],1
    jmp     l1
    
l3:         
    cmp     dword [map+eax],0
    jne     l1
    cmp     dword [show+eax],0
    jne     l1
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      l1
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
l1:
    dec     ecx
    ;;;;;;;;;; 
    
;test6:    
    inc     esi ; j+1
    cmp     esi,dword [n]
    jge     r1
    cmp     ecx,0
    jle     r1
     
element6:
    dec     ecx ;   i-1
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     r3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      r2
    mov     dword [show+eax],1
    jmp     r2
r3:     ;BOMB   or empty
    cmp     dword [map+eax],0
    jne     r2
    cmp     dword [show+eax],0
    jne     r2
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      r2
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
r2:
    inc     ecx
r1:
    dec     esi
    ;;;;;;;;;;;;
   
;test7:  
    inc     esi
    cmp     esi, dword [n]
    jge     b1
element7:
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0       
    jle     b3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      b1          
    mov     dword [show+eax],1      
    jmp     b1
b3:             ; bomb or empty
    cmp     dword [map+eax],0
    jne     b1
    cmp     dword [show+eax],0
    jne     b1
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      b1
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
b1:
    dec     esi
    ;;;;;;;;;;;;;;;
    
;test8:   
    inc     esi
    inc     ecx
    cmp     ecx,[m]
    jge     f1
    cmp     esi,[n]
    jge     f1
element8:
    mov     eax,ecx
    imul    eax, dword [n]
    add     eax,esi
    imul    eax,4
    cmp     dword [map+eax],0
    jle     f3
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      f1
    mov     dword [show+eax],1
    jmp     f1
f3:
    cmp     dword [map+eax],0
    jne     f1
    cmp     dword [show+eax],0
    jne     f1
    cmp     dword [flag+eax],1      ; if it was flagged, don't open it
    je      f1    
    mov     dword [show+eax],1
    
    mov     eax,[i]
    push    eax
    mov     eax,[j]
    push    eax
    push    esi
    push    ecx
    mov     [i],ecx
    mov     [j],esi
    call    _showAdj
    pop     ecx
    pop     esi
    pop     eax
    mov     [j],eax
    pop     eax
    mov     [i],eax
    
f1:
    dec     esi
    dec     ecx 
;;;;;;;;;;;;;;;;;;

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;