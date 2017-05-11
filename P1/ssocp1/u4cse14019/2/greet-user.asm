BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60
                                        ; global macro, does not contain in binary
                                        ; 0, 1, 2 are stdin, stdout and stderr

section .rodata
    msg:    db "Hello world!", 10, 0     ; msg to print
    len:    equ $-msg                   ; len of msg, $ = end of msg - beg og msg
    str1:   db "Hello ", 0
    str2:   db "!", 10, 0

section .text
    global _start                       ; entry point, starting point of any program

    _start:
	cmp qword[rsp], 2
	jl .helloworld
	
	mov r15, qword[rsp + 16]

	mov rax, SYS_WRITE	
	mov rdi, STDOUT
	mov rsi, str1
	mov rdx, 6
	syscall

	mov rdi, r15
	call strlen
	mov r14, rax

	mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, r15
        mov rdx, r14
        syscall

	mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, str2
        mov rdx, 2
        syscall

	jmp .exit



	.helloworld:	
        	mov rax, SYS_WRITE              ; Set write system call number
        	mov rdi, STDOUT                 ; 1st argument of SYS_WRITE: file ID
        	mov rsi, msg                    ; 2nd argument of SYS_WRITE: buffer
        	mov rdx, len                    ; 3rd argument of SYS_WRITE: length of buffer
        	syscall                         ; Invoke system call interface of kernel

        .exit:
        	mov rax, SYS_EXIT               ; Set exit system call number
        	xor rdi, rdi                    ; 1st argument of SYS_EXIT: exit code
       	 	syscall


strlen:
        push rbp
        mov rbp, rsp

        xor rax, rax                    ; the length of the string

        .cmploop:
            cmp BYTE [rdi + rax], 0     ; check if current byte is null
            je .cmpdone                 ; if yes, done
            inc rax                     ; else increment length counter
            jmp .cmploop                ; and continue

        .cmpdone:
            leave
            ret
