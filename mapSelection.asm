_selectmap:

     mov    ecx,    dword[i]                ;[esp+4]
     mov    esi,    dword[j]                ;[esp+8]
     
     mov    eax,    [i]
     imul   eax,    [n]
     add    eax,    [j]
     imul   eax,    4
     
     cmp dword [map1+eax] , 0
     je smap1
     cmp dword [map2+eax] , 0
     je smap2
     cmp dword [map3+eax] , 0
     je smap3
     cmp dword [map4+eax] , 0
     je smap4
     cmp dword [map5+eax] , 0
     je smap5
     cmp dword [map6+eax] , 0
     je smap6
     cmp dword [map7+eax] , 0
     je smap7
     cmp dword [map8+eax] , 0
     je smap8
     cmp dword [map9+eax] , 0
     je smap9
     cmp dword [map10+eax] , 0
     je smap10
     cmp dword [map11+eax] , 0
     je smap11
     cmp dword [map12+eax] , 0
     je smap12
     cmp dword [map13+eax] , 0
     je smap13
  
     jmp smap13 ;;;;;;; -- to ensure we have map selected
     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap1:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop1:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map1+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
smap2:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop2:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map2+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
smap3:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop3:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map3+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
smap4:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop4:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map4+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap5:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop5:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map5+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap6:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop6:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map6+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap7:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop7:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map7+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap8:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop8:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map8+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap9:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop9:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map9+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap10:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop10:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map10+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap11:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop11:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map11+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop11
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap12:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop12:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map12+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
smap13:
    mov     eax, dword[m]
    imul    eax, dword[n]
    xor     ecx, ecx
sloop13:
    cmp     ecx, eax
    jge     done
    mov     ebx,[map13+ecx*4]
    mov     [map+ecx*4], ebx
    inc     ecx
    jmp     sloop13
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
    
    
done:
     ret     