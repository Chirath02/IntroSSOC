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

        mov r14, rdi                ; move argc to r14
        mov r15, rsi                ; move argv to r15

        cmp rdi, 1                  ; check if any arguments are passed
        je .noArguments             ; jump if no arguments are passed

        mov r13, 1               ; set r11 = 1

        .loop:
            cmp r13, r14
            je .end
            add r13, 1
            add r15, 8
            mov rdi, var1
            mov rsi, [r15]
            call printf

            jmp .loop

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
