;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                              ;
; Author    :   Arvind                                                         ;
; Program   :   Find greatest of two numbers                                   ;
; Note      :   This program was tested on Ubuntu 14.04 64 bit using           ;
;               nasm 2.10.09 and gcc 4.8.4.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

extern printf
extern scanf

section .rodata
    inp  :    db "%d", 0                     ; input format for scanf
    grt  :    db "%d", 10, 0                 ; output format for printf
    equ  :    db "Same", 10, 0               ; output format for printf
    p1   :    db "Enter first number: ", 0   ; prompt to enter inputs
    p2   :    db "Enter second number: ", 0  ; for the two numbers

section .bss
    num1: resq 1                             ; first number
    num2: resq 1                             ; second number

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        mov rdi, p1                         ; Display prompt
        call printf

        mov rsi, num1                       ; Read number 1
        mov rdi, inp
        call scanf

        mov rdi, p2                         ; Display prompt
        call printf

        mov rsi, num2                       ; Read number 2
        mov rdi, inp
        call scanf

        mov rax, QWORD [num1]               ; Mov num1 into rax
        cmp rax, QWORD [num2]               ; Compare rax with num2
        jg .greater                         ; num1 is greater
        jl .lesser                          ; num2 is greater
        jmp .equal                          ; Both are equal

        .greater:
            mov rsi, QWORD [num1]
            jmp .display

        .lesser:
            mov rsi, QWORD [num2]
            jmp .display

        .equal:
            mov rdi, equ
            call printf
            jmp .final

        .display:
            mov rdi, grt
            call printf

        .final:
            xor rax, rax
            leave
            ret
