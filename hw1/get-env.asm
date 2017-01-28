; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   Environment variable query tool                               ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf           ; declare printf
extern getenv           ; getenv function to get an env

section .rodata
    var1 : db "'%s' Not found", 10, 0

section .text                               ; start of text section
    global main                             ; declare main as globally visible

    main:
	      push rbp                            ; set up main's stack frame
	      mov rbp, rsp                        ; on top of it's caller's frame

        mov r15, [rsi + 8]
        mov r14, rdx

        cmp rdi, 2
        jne .noArgument

        mov rdi, r15                        ; pass commandline argument to getenv
        call getenv                         ; call getenv

        test rax, rax
        jz .notFound

        mov rdi, rax                        ; pass return value of getenv to printf
        call printf

        jmp .end

        .notFound:
            mov rdi, var1
            mov rsi, r15
            call printf

        .noArgument:
            mov rdi, [r14 + 16]
            call printf

        .end:

    	  mov rax, 0                          ; set return value
    	  mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
    	  ret
