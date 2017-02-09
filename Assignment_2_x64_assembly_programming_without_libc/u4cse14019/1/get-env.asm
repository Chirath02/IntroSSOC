; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   Fibonacci calculator                                           ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

%define STDOUT 1
%define SYS_WRITE 1
%define SYS_EXIT 60

extern printf           ; declare printf
extern getenv           ; getenv function to get an env

section .rodata
  end : db 10, 0                         ; 10 for newline

section .text                            ; start of text section
    global _start                        ; declare main as globally visible

    _start:

    mov r15, rsp                         ; set r15 = top of stack pointer

    mov r13, 24                          ; start from the env on stack

    .loop:
        cmp qword[r15 + r13], 0          ; if end of environment variables
        je .exit

        mov rdi, [r15 + r13]             ; get each env string length
        call strlen
        mov r14, rax
                                         ; write(1, env_string, strlen(env_string))
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, [r15 + r13]
        mov rdx, r14
        syscall

        call endl                         ; endl function

        add r13, 8                         ; counter r13+8, r13 = rsp

        jmp .loop
ram retured
    .exit:                                ; exit syscall
        ; exit(0)
        xor rdi, rdi
        mov rax, SYS_EXIT
        syscall

    endl:
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, end
        mov rdx, 1
        syscall
        ret

    ; strlen(rdi), rdi = input string
    strlen:
        push rbp
        mov rbp, rsp


        xor rax, rax                    ; the length of the string

        .cmploop:
            cmp BYTE [rdi + rax], 0     ; check if current byte is null
            je .cmpdone                 ; if yes, done
            inc rax                     ; else increment length counter
            jmp .cmploop                ; and continue

        .cmpdone:
            leave
            ret
