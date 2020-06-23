GLOBAL read
GLOBAL write
GLOBAL print
GLOBAL strlen
GLOBAL exit
GLOBAL open
GLOBAL close
GLOBAL createFile
GLOBAL writeFile
GLOBAL pid
section .text

pid:
	push ebp
	mov ebp, esp
	mov eax, 0x14 ; syscall getpid
	int 0x80
	; el resultado ya está en eax
	mov esp, ebp
	pop ebp
	ret

; int createFile( const char * filename )
createFile:
        push ebp
        mov ebp, esp
        
        mov eax, [ebp+8]
        push 0666o
        push 0102o
        push eax
        call open
	add esp, 3*4

	push eax
	call close

        mov esp, ebp
        pop ebp
        ret

; void writeFile( const char * text, const char * filename)
writeFile:
        push ebp
        mov ebp, esp
	push eax
	push ebx
	push ecx

	mov ebx, [ebp+8] 	; text
	mov ecx, [ebp+12]	; filename

	push 2
	push ecx
	call open
	add esp, 4
	mov ecx, eax

	push ebx
	call strlen
	add esp, 4
	
	push eax
	push ebx
	push ecx
        call write
	add esp, 3*4

	push eax
	call close
	add esp, 4
	
	mov esp, ebp
	pop ebp
	ret

; int open(const char* filename, int flags, int mode)
; flag 0 = read-only, 1 = write-only, 2 = read and write
open:
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx	

	mov eax, 5
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	int 80h

	pop edx
	pop ecx
	pop ebx

	mov esp, ebp
	pop ebp
	ret

; int close(unsigned int fd)
close:
	push ebp
	mov ebp, esp
	push ebx
	mov eax, 6
	mov ebx, [ebp+8]
	int 80h

	pop ebx
	mov esp, ebp
	pop ebp
	ret

; Recibe en EBX el string
strlen:
	push ebp
	mov ebp, esp
        push ecx
        push ebx

	mov ebx, [ebp+8]
	mov eax, 0
        mov ecx, 0
.loop:
        mov al, [ebx]
        cmp al, 0
        jz .fin
        inc ebx
        inc ecx
        jmp .loop

.fin:
        mov eax, ecx
        pop ebx
        pop ecx
	mov esp, ebp
	pop ebp
        ret

; void print( const char * string)
print:
	push ebp
	mov ebp, esp
	push eax
	push ebx

	mov ebx, [ebp+8]
	push ebx
	call strlen
	add esp, 4

	push eax
	mov ebx, [ebp+8]
	push ebx
	push 1
	call write
	add esp, 2*4

	pop ebx
	pop eax
	mov esp, ebp
	pop ebp
	ret

; int read(int fd, char * buff, int dim)
; fd = 0 es read de pantalla
read:
        push ebp
        mov ebp, esp
        pushad

        mov eax, 3
        mov ebx, [ebp+8]
        mov ecx, [ebp+12]
        mov edx, [ebp+16]
        int 80h

        popad
        mov esp, ebp
        pop ebp
        ret

; int write( int fd, char * string, int len)
write:
	push ebp
	mov ebp, esp
	push eax
	push ebx
	push ecx
	push edx

	mov eax, 4
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	int 80h
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	mov esp, ebp
	pop ebp
	ret

exit:
	mov eax, 1
	mov ebx, 0
	int 80h
	ret
