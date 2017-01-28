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
extern memset
extern atoi
extern fscanf
extern strlen

section .rodata
    var1 : db "%s", 10, 0
    var2 : db "%d", 10, 0
    var3 : db "r", 0
    var4 : db "File not Found", 10, 0

section .bss
    var5 : resb 200 + 1
    var6 : resq 1
    var7 : resb 1

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


        mov rdx, 200
        xor rsi, rsi
        mov rdi, var5
        call memset

        mov rdi, r15
        mov rsi, var1
        mov rdx, BYTE[var5]
        call fscanf                           ; fscanf(r15, "%s", var5)
        mov r13, var5                         ; r13 = value from fscanf

        mov rdi, var5
        call strlen

        mov r12, rax

        .loop:
            cmp r12, 0
            jz .end

            mov r11, [r13]

            ; mov rdi, r11
            ; call atoi
            ; mov r11, rax

            ;add r11, r14
            mov rdi, var2
            mov rsi, r11
            call printf

            inc r13
            dec r12
            jmp .loop

        jmp .end

        .fileNotFound:
            mov rdi, var4
            call printf

        .end:

    	  xor rax, rax                          ; set return value
    	  mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
    	  ret
