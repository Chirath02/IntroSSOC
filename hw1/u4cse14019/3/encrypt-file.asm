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
extern fgetc

section .rodata
    var1 : db "%s", 10, 0
    var2 : db "%c", 0
    var3 : db "r", 0
    var4 : db "File not Found", 10, 0

section .bss
    var5 : resb 100 + 1
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

        mov rdi, r15
        mov rsi, var3
        call fopen
        mov r15, rax                        ; r15 = rax = fopen(r15, var3)
        test rax, rax
        jz .fileNotFound

        mov rdi, r15
        call fgetc                          ; r13 = fgetc(r15)
        mov r13, rax

        .loop:

            cmp r13d, -1                      ; if r13 = EOF(-1) end
            je .end
            add r13, r14
            cmp r13d, 90                      ; if r13 >= 90 : r13 -= 26

            jle .cont
            sub r13, 65
            mov eax, r13d
            mov ebx, 26
            xor edx, edx
            div ebx
            mov r13d, edx                    ;edx = eax % ebx and eax = eax / ebx
            add r13, 65
            .cont:

                mov rsi, r13
                mov rdi, var2
                call printf
                mov rdi, r15
                call fgetc
                mov r13, rax                  ; r13 = fgetc(r15)
                jmp .loop

        .fileNotFound:
            mov rdi, var4
            call printf

        .end:

    	  xor rax, rax                          ; set return value
    	  mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
    	  ret
