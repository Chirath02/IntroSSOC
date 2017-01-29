; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   Environment variable query tool                                ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf
extern atoi

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

        mov r13, 1                  ; set r13 = 1

        .loop:
            mov QWORD[t1], 0        ; t1 = 0
            mov QWORD[t2], 1        ; t2 = 1
            cmp r13, r14            ; r13 wiht argc
            je .end

            add r13, 1              ; r13++
            add r15, 8              ; argv[i]

            mov rdi, [r15]
            call atoi               ; convert string to int

            mov r12, rax            ; r12 = int from atoi

            mov rdi, var1           ; set 1st parameter for printf

            test r12, r12
            js .negative            ; if negative

            jmp .cont

            .negative:
                mov rsi, -1         ; print -1
                call printf
                jmp .loop

            .cont:

            cmp r12, 1              ; if 1, print 0
            jne .next
            mov rsi, [t1]
            call printf
            jne .loop              ; continue the loop

            .next:
                cmp  r12, 2         ; if 2, print 1
                jne .next2
                mov rsi, [t2]
                call printf
                jne .loop           ; continue the loop

                .next2:
                    mov r11, 0          ; r11 = 0
                    mov r10, 2          ; r12 = 2
                    .loop2:
                        cmp r12, r10    ; check r10 <= r12
                        je .loopend
                        add r10, 1      ; r10++
                        mov r11, [t1]
                        add r11, [t2]   ; r11 = t1 + t2

                        mov r9, [t2]
                        mov [t1], r9    ; t1 = t2
                        mov [t2], r11
                        jmp .loop2

                  .loopend:
                        mov rsi, r11
                        call printf
                        jmp .loop

            mov r12, rax

            call printf             ; print argv[i]

            jmp .loop

        .noArguments:
            mov rdi, var1
            mov rsi, -1
            call printf             ; no arguments print -1
            jmp .end

        .end:
              xor rax, rax
              mov rsp, rbp                        ; destroy main's stack frame and
              pop rbp                             ; restore main's caller's stack frame
          	  ret
