bits 16
org 0x7C00


    cli
    
    mov ah ,0x02
    mov al ,13
    mov dl ,0x80
    mov dh ,0
    mov ch ,0
    mov cl ,2
    mov bx ,CodeBegin
    int 0x13
    jmp CodeBegin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
times (510 - ($ - $$)) db 0
db 0x55, 0xAA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


CodeBegin:
    xor     esp,esp
    xor     ax,ax
    mov     ss,ax
    mov     sp,0xffff
    jmp     GameBegin
    
    ;;;;;;;;;;;;;;;; Supporting Files ;;;;;;;;;;;;
    %include"Print.asm"
    %include"showAdj.asm"
    %include"MaabPrint.asm"
    %include"zeroPrint.asm"
    %include"flagPrint.asm"
    %include"drawBomb.asm" 
    %include"minesShow.asm"
    %include"init.asm"   
    %include"mapSelection.asm"
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GameBegin:
    call    memoryPre    
    call    initialization

    call    enable                  ; enable mouse
    mov     al,[linesColor]
    mov     [curserColor],al
    mov     dword[mapSelected],1



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;; Game biggest loop is to be :- ;;;;;;;;;;;;;;;;;;;;;;
check:
    mov     al, 0
    in      al, 0x64
    test    al, 1
    jz      check
    test    al, 0x20
    jz      keyboard
    
mouse:
    mov     dword[mouseActive],1
    mov     dword[keyboardActive],0     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;PRINT (remove) prev CURSER IN SCREEN;;;;;;;;;;;
    mov     ah, 0ch     ; input
    mov     al, [curserColor]   ; BackgoundColor
    mov     cx, [xpos]  ; col
    mov     dx, [ypos]  ; row
    int     10h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    in      al,0x60
    and     al,3
    mov     [status],al
    in      al,0x60
    movsx   ax,al
    add     [xpos],ax
    
    cmp     word[xpos] , 0
    jge     nothing1
    mov     word[xpos] , 0
    jmp     nothing2
nothing1:
    cmp     word[xpos] , 319
    jl      nothing2
    mov     word[xpos] , 319
nothing2:
    in      al,0x60
    movsx   ax,al
    sub     [ypos],ax
    cmp     dword[ypos] , 20
    jl      twen
    cmp     dword[ypos] , 199
    jle     continue1
    mov     dword[ypos] , 199 
    jmp     continue1
twen:
    mov     dword[ypos] , 20    
continue1:
    in      al, 0x60     ;no roller
    
    call    update
    call    selectedBlock
    
    ;cmp     byte[status] , 3
    ;je      back
    ;cmp     byte[status] , 0 
    ;je      back    
    cmp     byte[status], 1
    je      open
    cmp     byte[status],2
    je      mflag
back:    
;;;;;;;;;;;;;this used to get current pixel color before curser;;;;;;;;;;;;;;;;;
    mov cx,[xpos]
    mov dx,[ypos]
    mov ah,0dh
    int 10h
    mov [curserColor],al
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;PRINT CURSER IN SCREEN;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov     ah, 0ch     ; input
    mov     al, 1111b   ; color
    mov     cx, [xpos]  ; col
    mov     dx, [ypos]  ; row
    int     10h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    jmp     check
    
    
keyboard: 
    mov     dword[mouseActive],0
    mov     dword[keyboardActive],1
    in      al,0x60
    ;;;;;; SomeCode here ;;;;;;
    cmp      al, 0x80
    ja       check
    
    cmp      al, 0x48
    je       up
    cmp      al, 0x4B
    je       left
    cmp      al, 0x4D
    je       right
    cmp      al, 0x50
    je       down
    cmp      al, 0x0B
    je       open
    cmp      al,0x02
    je       mflag
    cmp      al,0x22            ; player gived up
    je       GameOver
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jmp     check    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
up:
    cmp     dword[i],0
    jle     check
    dec     dword[i]
    call    selectedBlock
    jmp     check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
left:
    cmp     dword[j],0
    jle     check
    dec     dword[j]
    call    selectedBlock
    jmp     check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
right:
    mov     eax,[n]
    dec     eax
    cmp     [j],eax
    jge     check
    inc     dword[j]
    call    selectedBlock
    jmp     check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
down:
    mov     eax,[m]
    dec     eax
    cmp     [i],eax
    jge     check
    inc     dword[i]
    call    selectedBlock
    jmp     check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
open:
    mov     ax,0002h
    int     33h
    mov     dword[opened],0
    cmp     dword[mapSelected],0
    jne     openit
    mov     dword[mapSelected],1
    pushad
    call    _selectmap
    popad
openit:
    xor      eax,eax
    mov      eax, dword[i] ; i
    imul     eax, dword[n] ;i*n
    add      eax, dword[j]  ;i*n+j
    imul     eax,4

    cmp     dword [show+eax],1         ;    -> click on opened block will do nothing
    je      return

    cmp     dword [flag+eax],1
    je      return
    
    mov     dword[opened],1
    
    mov     dword [show+eax],1
    
    cmp     dword [map+eax], -1     ;; bomb block opened
    je      GameOver
    
    cmp     dword [map+eax], 0
    jne     numberClicked
    
    ;;;;;;;;;;; zero clicked  ;;;;;;;;;; 
    push    dword[j]
    push    dword[i]
    call    _showAdj
    add     esp,8     
    call     print
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    jmp     return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
mflag:
    mov     dword[opened],1
    mov     ebx, dword[i]
    imul    ebx, 10
    add     ebx, dword[j]
    imul    ebx,4
        
    cmp     dword[show+ebx],1
    je      return
    
    cmp     dword[flag+ebx],0
    jnz     removeFlag
    
    xor     dword[flag+ebx],1
    push    dword[j]
    push    dword[i]
    call    flagPrint
    add     esp,8
    jmp     return
removeFlag:
    xor     dword[flag+ebx],1
    push    dword[j]
    push    dword[i]
    call    flagf
    add     esp,8
    jmp     return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
numberClicked:
    ; print the number ......

    push    dword[map+eax]
    push    dword[j]
    push    dword[i]    
    call    MaabPrint
    add     esp,12
    jmp     return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
GameOver:
    call     mineShow
    ;cli
Again:
    in      al,0x64
    test    al,1
    jz      Again
    ;test    al,5
    ;jnz     Again
    in      al,0x60
    cmp     al,0x1E
    jne     Again
    jmp     GameBegin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;           
update:
    ; modefies i & j according to xpos and ypos
    xor     edx, edx
    
    mov     eax, [xpos]
    mov     ebx, 32
    div     ebx
    cmp     eax,0
    jge     next100
    mov     eax , 0
next100:
    mov     [j], eax
    
    mov     eax, [ypos]
    mov     ebx, 18
    sub     eax, 20
    xor     edx,edx
    div     ebx
    cmp     eax,0
    jge     next101
    mov     eax,0
next101:
    mov     [i], eax
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
selectedBlock:
    mov     ecx,[prevj]
    imul    ecx,32
    
    mov     edx,[previ]
    imul    edx,18
    add     edx,20
    mov     byte[boxColor],0
    call    drawBlock
    
    mov     ecx,[j]
    imul    ecx,32
    
    mov     edx,[i]
    imul    edx,18
    add     edx,20
    mov     byte[boxColor],1111b
    call    drawBlock
    
    mov     eax,dword[i]
    mov     [previ],eax
    mov     eax,[j]
    mov     [prevj],eax
    
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
drawBlock:
mov ah, 0ch ; put pixel
mov al,[boxColor]
mov bx,0
mov di,0

line11:
int 10h 
inc cx
inc bx 
cmp bx,31
jle line11
sub cx ,32
line12:
int 10h
inc dx
inc di 
cmp di,17
jle line12
mov bx ,0
line13:
int 10h 
inc cx
inc bx 
cmp bx,31
jle line13
sub dx ,19
mov di ,0
line14:
int 10h
inc dx
inc di 
cmp di,19
jle line14

ret  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
enable:    
    in      al,0x64
    and     al,0x02
    jnz     enable    
    mov     al,0xd4
    out     0x64,al    
    mov     al,0xf4
    out     0x60,al     ;mouse enabled
    in      al,0x60     ;not used
    ret
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
return:
    jmp     back
    ;;;;;;;;; Mouse Active ;;;;;;;;;;;;;;;;;;;;;;;;
    cmp     dword[mouseActive],1
    je      back
    ;;;;;;; Keyboard Active ;;;;;;;;;;;;;;;;;;;;;;;
    cmp     dword[opened],0
    je      check
    mov     cx,[xpos]
    mov     dx,[ypos]
    mov     ah,0dh
    int     10h
    mov     [curserColor],al
    jmp     check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
memoryPre:
    mov     dword[i],0
    mov     dword[j],0
    
    mov     dword [xpos],0
    mov     dword [ypos],20
    mov     dword [mapSelected],0

    mov     eax, [m]
    imul    eax, [n]
    xor     ecx, ecx
loop32:
    cmp     ecx,eax
    jge     finish32
    mov     dword[flag+ecx*4] , 0
    mov     dword[show+ecx*4] , 0
    inc     ecx
    jmp     loop32
finish32:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    cli
    hlt
;;;;;;;;;;;;;;Data Section ;;;;;;;;;;;   
i: dd 0
j: dd 0
linesColor: db 0
boxColor: db 0
previ: dd 0
prevj: dd 0
backgroundColor: db 0x07
zeroColor: db 0x08
flagColor: db 1
bombColor:db 0 
crossColor: db 2    
flag: times 100 dd 0
show: times 100 dd 0
n: dd 10
m: dd 10
empty: db '0',0                      
xpos: dd 0
ypos: dd 20
status: db 0
mapSelected: dd 0
lo1: dd 0
curserColor: db 0
printi: dd 0
printj: dd 0
printk: dd 0
cross: dd 0
mouseActive: dd 0
keyboardActive: dd 1
opened: dd 0

map:  dd 1,1,0,0,0,1,1,1,0,0
      dd -1,1,0,0,1,2,-1,1,1,1
      dd 2,2,1,1,2,-1,2,1,1,-1
      dd 1,-1,1,1,-1,2,1,0,1,1
      dd 1,1,1,1,2,3,2,2,2,2,0
      dd 1,1,2,2,-1,-1,2,-1,-1
      dd 0,1,-1,3,-1,4,2,3,3,3
      dd 1,2,1,3,-1,3,1,3,-1,3
      dd -1,2,1,1,1,3,-1,4,-1,-1
      dd 2,-1,1,0,0,2,-1,3,2,2
      
map1:dd 1,1,0,0,0,1,1,1,0,0,-1,1,0,0,1,2,-1,1,1,1,2,2,1,1,2,-1,2,1,1,-1,1,-1,1,1,-1,2,1,0,1,1,1,1,1,1,2,3,2,2,2,2,0,1,1,2,2,-1,-1,2,-1,-1,0,1,-1,3,-1,4,2,3,3,3,1,2,1,3,-1,3,1,3,-1,3,-1,2,1,1,1,3,-1,4,-1,-1,2,-1,1,0,0,2,-1,3,2,2
map2:dd 0,2,-1,2,0,1,1,2,1,1,0,2,-1,2,0,1,-1,2,-1,1,1,2,2,1,0,2,2,3,1,1,1,-1,1,0,0,2,-1,2,1,1,1,1,1,1,1,4,-1,3,1,-1,0,1,1,2,-1,4,-1,3,2,1,0,1,-1,2,2,-1,5,-1,2,0,1,3,4,3,2,3,-1,-1,2,0,1,-1,-1,-1,1,2,-1,4,2,0,1,2,3,2,1,1,2,-1,1,0
map3:dd -1,1,1,-1,2,-1,-1,1,2,-1,1,1,1,1,2,2,2,2,-1,-1,-1,0,0,0,0,0,1,2,3,-1,2,0,0,0,0,1,2,-1,-1,2,1,1,2,1,1,1,-1,3,3,2,1,-1,2,-1,2,2,2,2,2,-1,2,1,2,2,3,-1,2,2,-1,3,-1,0,0,1,-1,2,2,-1,2,2,1,0,1,2,2,1,2,2,2,0,0,0,1,-1,1,0,1,-1,1,0,0
map4:dd -1,1,0,0,0,1,-1,2,2,-1,1,1,0,0,0,1,2,-1,2,1,1,1,1,0,1,2,3,2,1,0,1,-1,2,1,1,-1,-1,1,0,0,1,2,-1,1,1,2,2,1,1,1,1,2,1,1,0,1,1,1,1,-1,-1,1,0,0,1,3,-1,3,3,3,1,1,0,1,2,-1,-1,3,-1,-1,1,1,2,2,-1,3,2,3,4,-1,1,-1,2,-1,2,1,0,1,-1,2
map5:dd 1,2,1,1,1,2,2,1,0,0,-1,4,-1,1,1,-1,-1,2,1,0,-1,-1,3,2,1,3,4,-1,1,0,2,3,-1,2,2,2,-1,3,2,0,0,2,3,-1,2,-1,3,-1,1,0,0,1,-1,2,3,2,3,1,1,0,1,2,2,3,3,-1,1,0,1,1,-1,1,1,-1,-1,2,1,0,1,-2,1,2,3,4,3,1,0,0,1,1,0,1,-1,-1,1,0,0,0,0,0
map6:dd -1,2,1,0,0,0,0,2,-1,2,3,-1,2,0,0,0,0,3,-1,3,3,-1,3,0,0,0,0,2,-1,2,2,-1,2,0,0,0,1,2,2,1,1,1,1,1,1,1,2,-1,2,0,0,0,0,1,-1,2,3,-1,3,1,0,0,0,1,2,-1,2,2,-1,2,0,1,1,1,2,2,3,3,4,-1,1,3,-1,2,1,-1,3,-1,-1,2,-1,3,-1,2,1,1,3,-1,3,1
map7:dd 1,2,-1,1,0,1,-1,1,1,-1,1,-1,3,2,0,2,3,3,2,1,2,3,-1,1,0,1,-1,-1,1,0,-1,3,2,1,0,1,2,3,2,1,3,-1,2,0,0,0,0,1,-1,1,3,-1,3,1,2,2,2,2,2,2,-1,3,3,-1,2,-1,-1,1,1,-1,1,2,-1,3,4,4,4,2,2,2,1,0,1,1,2,-1,-1,2,-1,1,0,0,0,0,1,2,2,2,1,1,0
map8:dd 1,-1,-1,4,-1,2,1,2,2,2,3,5,-1,-1,3,3,-1,2,-1,-1,-1,-1,3,2,3,-1,3,2,2,2,2,2,1,0,2,-1,2,0,1,1,0,1,1,1,1,1,1,0,2,-1,0,2,-1,2,0,0,0,0,2,-1,0,3,-1,3,0,0,0,0,1,1,0,2,-1,3,1,1,0,0,1,1,0,1,1,2,-1,1,0,1,2,-1,0,0,0,1,1,1,0,1,-1,2
map9:dd 1,-1,2,2,-1,2,1,1,1,-1,2,2,2,-1,2,2,-1,2,2,1,-1,1,1,1,1,1,2,-1,2,1,2,2,2,1,1,0,2,3,-1,1,2,-1,2,-1,1,0,1,-1,2,1,-1,2,2,2,2,2,3,3,3,1,1,1,0,1,-1,2,-1,-1,2,-1,0,0,0,1,1,3,3,3,2,1,0,0,0,0,0,1,-1,3,3,2,0,0,0,0,0,1,2,-1,-1,-1
map10:dd 0,0,1,-1,2,-1,1,1,-1,1,0,0,1,2,3,2,1,1,2,2,1,2,3,3,-1,1,0,0,1,-1,1,-1,-1,-1,3,3,1,1,1,1,2,4,-1,5,-1,4,-1,3,1,1,-1,2,1,3,-1,4,-1,3,-1,1,2,2,1,1,1,2,2,3,2,1,1,-1,1,0,0,0,1,-1,1,0,2,2,2,1,2,1,2,1,1,0,-1,1,1,-1,2,-1,1,0,0,0
map11:dd 1,2,-1,2,-1,-1,-1,2,0,0,1,-1,2,2,2,4,-1,2,0,0,1,1,1,0,0,1,1,1,0,0,1,2,1,1,0,0,0,0,0,0,-1,3,-1,3,2,1,0,0,0,0,-1,3,2,-1,-1,3,2,1,1,1,1,1,1,3,4,-1,-1,1,1,-1,0,0,0,2,-1,5,3,1,1,1,1,1,0,2,-1,-1,3,1,1,0,-1,1,0,1,3,-1,3,-1,1,0
map12:dd 1,-1,2,1,1,-1,1,0,2,-1,1,2,-1,1,1,1,1,0,2,-1,1,2,1,1,1,1,1,0,1,1,-1,1,0,0,1,-1,1,0,0,0,1,1,1,2,3,2,1,0,0,0,0,0,1,-1,-1,2,1,0,0,0,2,2,2,3,5,-1,2,0,0,0,-1,-1,2,2,-1,-1,2,0,0,0,4,-1,4,4,-1,4,1,0,1,1,2,-1,-1,3,-1,2,0,0,1,-1
map13:dd 2,-1,-1,3,-1,2,-1,1,1,1,-1,4,-1,4,2,2,1,1,1,-1,1,2,2,-1,1,0,0,1,3,3,0,0,1,1,1,0,1,2,-1,-1,0,0,0,0,0,0,1,-1,3,2,1,2,3,2,1,1,2,2,1,0,2,-1,-1,-1,2,2,-1,2,1,1,-1,4,4,2,2,-1,3,3,-1,1,2,-1,1,0,1,2,-1,2,1,1,1,1,1,0,0,1,1,1,0,0


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


times (0x400000 - 512) db 0 



db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x76, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF4
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00