; Print from 10 to 1

BITS 64

extern printf
extern scanf

section .data
    var1 :    dq 10

section .rodata
    var2 :    db "%d", 10, 0

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        .label1:
            mov rsi, var2
            mov rdi, QWORD [var1]
            call printf
            dec QWORD [var1]
            cmp QWORD [var1], 0
            je .label2
            jmp .label1

        .label2:
            xor rax, rax
            leave
            ret
