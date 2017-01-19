BITS 64

extern printf
extern scanf

section .data
    var1 :    dq 1

section .rodata
    var2 :    db "%d", 10, 0

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        .label1:
            mov rsi, QWORD [var1]
            mov rdi, var2
            call printf
            inc QWORD [var1]
            cmp QWORD [var1], 10
            jg .label2
            jmp .label1

        .label2:
            xor rax, rax
            leave
            ret
