BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

; cat in hex reversed = '746163'
; cat file.txt in hex reversed = '7478742e67616c6620746163'
; push into stack
; 1st part = 0x67616c6620746163
; 2nd part = 0x7478742e


section .text

    global _start

    _start:
        mov rax, 0x7478742e67616c66
        push rax
        push 0x0020746163


        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, rsp
        mov rdx, 16
        syscall

        .exit:                                ; exit syscall
            ; exit(0)
            xor rdi, rdi
            mov rax, SYS_EXIT
            syscall
