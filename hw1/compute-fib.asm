; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   Environment variable query tool                                ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf

section .rodata
    var1 : db "%d", 10, 0

section .data
    t1 : dq 0
    t2 : dq 1
    i : dq 0

section .text
    global main

    main:
        push rbp
        mov rbp, rsp

        cmp rdi, 1
        je .noArguments

        mov r14, rdi
        mov r15, rsi

        xor r11, r11

        loop:
            cmp QWORD[r14], i
            je .end
            add i, 1

            jmp loop

        call .end

        .noArguments:
            mov rdi, var1
            mov rsi, -1
            call printf
            jmp .end

      .end:
            xor rax, rax
            mov rsp, rbp                        ; destroy main's stack frame and
            pop rbp                             ; restore main's caller's stack frame
        	  ret
