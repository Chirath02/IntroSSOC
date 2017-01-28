; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   Fibonacci calculator                                           ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf           ; declare printf
extern getenv           ; getenv function to get an env

section .rodata
    var1 : db "'%s' Not found", 10, 0
    var2 : db "%s", 10, 0

section .text                               ; start of text section
    global main                             ; declare main as globally visible

    main:
	      push rbp                            ; set up main's stack frame
	      mov rbp, rsp                        ; on top of it's caller's frame

        mov r15, [rsi + 8]                  ; keep value of 2nd commandline argument
        mov r14, rdx                        ; mov environment strings to r14

        cmp rdi, 2                          ; if no arguments are passed go to end
        jne .noArgument

        mov rdi, r15                        ; pass commandline argument to getenv
        call getenv                         ; call getenv

        test rax, rax                       ; if env not found go to end
        jz .end

        mov rdi, rax                        ; pass return value of getenv to printf
        call printf

        jmp .end


        .noArgument:                        ; print all envs
            mov r13, [r14]
            cmp r13, 0
            je .end
            mov rdi, var2
            mov rsi, r13
            call printf
            add r14, 8
            jmp .noArgument

        .end:

    	  mov rax, 0                          ; set return value
    	  mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
    	  ret
