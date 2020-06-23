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
	mov rax, 110 	; syscall getpid
	syscall
	; el resultado ya está en rax
	mov rsp, rbp
	pop rbp
	ret

; int createFile( const char * filename )
; recivo en rdi el filename
createFile:
	push rdi
	push rdx
	push rsi
	push rax

    mov rdx, 0666o
    mov rsi, 0102o
    call open
	mov rdi, rax
	call close

	pop rax
	pop rsi
	pop rdx
	pop rdi
    ret

; void writeFile( const char * text, const char * filename)
writeFile:
	push rcx
	push rdi
	push rsi

	mov rdi, rsi
	mov rsi, 2
	call open
	mov rcx, rax

	pop rsi
	pop rdi
	call strlen
	
	mov rdx, rax
	mov rsi, rdi
	mov rdi, rcx
	call write

	call close
	pop rcx
	ret

; int open(const char* filename, int flags, int mode)
; flag 0 = read-only, 1 = write-only, 2 = read and write
open:
	mov rax, 2
	; RDI es el filename
	; RSI es el flag
	; RDI es el mode
	syscall
	ret

; int close(unsigned int fd)
close:
	mov rax, 3
	syscall
	ret

; Recibe en RDI el string
; int strlen( const char * string)
strlen:
    push rcx
	push rdi
	mov rax, 0
    mov rcx, 0
.loop:
    mov al, [rdi]
    cmp al, 0
    jz .fin
    inc rdi
    inc rcx
    jmp .loop

.fin:
    mov rax, rcx
	pop rdi
    pop rcx
    ret

; void print( const char * string)
print:
	push rax

	call strlen

	mov rsi, rdi
	mov rdi, 1
	mov rdx, rax 
	call write

	pop rax
	ret

; int read(int fd, char * buff, int dim)
; fd = 0 es read de pantalla
read:
    push rax

    mov rax, 0
    syscall

    pop rax
    ret

; int write( int fd, char * string, int len)
write:
	push rax

	mov rax, 1
	syscall
	
	pop rax
	ret

exit:
	mov rax, 60
	mov rdi, 0
	syscall
	ret
