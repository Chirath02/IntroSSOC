; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   File encryption                                           ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf           ; declare printf
extern getenv           ; getenv function to get an env
extern fclose
extern fopen
extern fread
extern memset
extern atoi

section .rodata
    var1 : db "%s", 10, 0
    var2 : db "%d", 10, 0

section .bss
    var5 : resb 20 + 1
    var6 : resq 1

section .text                               ; start of text section
    global main                             ; declare main as globally visible

    main:
	      push rbp                            ; set up main's stack frame
	      mov rbp, rsp                        ; on top of it's caller's frame

        mov r15, rsi                        ; r15 = argv[]
        mov rdi, [r15 + 16]
        call atoi

        mov r15, [r15 + 8]                  ; r15 = filename
        mov r14, rax                        ; r14 = int(argv[2]), shift




    	  mov rax, 0                          ; set return value
    	  mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
    	  ret