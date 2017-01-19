; Someone tried learning some arithmetic but got a strange error

BITS 64

extern printf

section .rodata
    out: db "%d", 10, 0

section .text

global main

    main:
        push rbp
        mov rbp, rsp

        mov rax, 1000
        xor rdx, rdx
        xor rcx, rcx
        idiv rcx

        mov rsi, rax
        mov rdi, out
        call printf

        leave
        xor rax, rax
        ret
