darwBomb:
push cx
push dx
push di
jmp cod
a: dd 0
b: dd 0
a1: dd 0
b121: dd 0
radius: dd 25
cod:
mov al,[bombColor]
;mov cx, 32; x-axis
;mov dx,38; y-axis
mov ah, 0ch ; put pixel
add cx,14
add dx,4
mov bx,0
mov di ,0
;pushad
aa:      ;;;;sqaure
inc cx
inc bx
int 10h
cmp bx,4
jle aa
inc dx
mov bx,0
sub cx,4
dec cx
inc di
cmp di,3
jle aa
mov di,0
add cx,2
sub dx,7
;popad

a12:
inc cx
int 10h
inc dx
inc di
dec cx
cmp di,3
jle a12
;;cx=cx+16
;dx= dx+6
sub dx,5
inc cx
mov bx ,0
mov di,0

line2:
int 10h
inc cx
inc bx
cmp bx,3
jle line2

line3:
int 10h
inc dx
inc di
cmp di,3
jle line3
;;;circle
;;;cx=cx-3
;;dx =dx+8
sub cx,4
add dx,8
mov[a],cx
mov [b],dx
mov di,cx
add di,5
sub cx,5
circle:
mov[a1],cx
;mov [b1],dx
finit
fild dword[radius]
fild  dword[a1]
fisub dword[a]
fmul st0
fsub
;fchs
fsqrt 
fiadd  dword[b]
fistp word[b121]
mov dx,[b121]
int 10h
mov bx,dx
neg dx
add dx ,[b]
add dx, [b]
t:
int 10h
inc dx
cmp dx,bx
jle t
inc cx
cmp cx,di
jle circle

pop     di
pop     dx
pop     cx
cmp dword[cross],0
jne crossDrwa
ret
crossDrwa:
add cx, 8; x-axis
;mov dx,20; y-axis
mov ah, 0ch ; put pixel
mov al,[crossColor]
mov bx,0
mov di ,0




;int 10h
sub dx,cx
mov bx,dx
add dx,cx
mov si,dx
add si,18
ll4411:
sub dx,bx
mov cx,dx
add dx,bx
mov ah, 0ch
int 10h
inc dx
cmp dx,si
jl ll4411
;
sub dx,18
;sub cx,32
add dx,cx
mov bx,dx
sub dx,cx
mov si,dx
add si,18
lll41:
sub bx,dx
mov cx,bx
add bx,dx
mov ah, 0ch
int 10h
inc dx
cmp dx,si
jl lll41

mov dword[cross],0
ret

