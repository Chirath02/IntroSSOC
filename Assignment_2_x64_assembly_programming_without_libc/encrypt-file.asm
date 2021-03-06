; Author    :   Chirath R                                                      ;
; Date      :   17/02/2017                                                     ;
; Program   :   XOR encryption                                           ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

%define STDOUT 1

; Macros for syscalls
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define SYS_EXIT 60

%define O_RDONLY 0

%define BUF_SIZE 200

section .rodata
  end : db 10, 0                         ; 10 for newline

section .bss
    buffer : resb BUF_SIZE

section .text                            ; start of text section
    global _start                        ; declare main as globally visible

    _start:

    mov r15, rsp                         ; set r15 = top of stack pointer
    cmp QWORD[r15], 3                    ; Check if there are 2 arguments
    jne .exit

    ; open(filename, 0, 0)
    mov rax, SYS_OPEN
    mov rdi, QWORD[r15 + 16]
    mov rsi, O_RDONLY
    mov rdx, 0
    syscall

    mov r14, rax                          ; file pointer

    ; read(fd, buffer, 200)
    mov rax, SYS_READ
    mov rdi, r14
    mov rsi, buffer
    mov rdx, BUF_SIZE
    syscall

    mov rdi, buffer
    call strlen1

    mov r13, rax
    mov r15, [r15 + 24]


    mov rdi, r15
    call strlen
    mov r10, rax
    xor r9, r9

    xor r12, r12
    mov r11, r13

    ; mov rax, SYS_WRITE
    ; mov rdi, STDOUT
    ; mov rsi, r15
    ; mov rdx, 3
    ; syscall

    ; r12 = r9 = 0
    ; r11 = r13 = srtlen(string)
    ; r10 = strlen(key) - 1

    .outer_loop:
        cmp r9, r10
        jne .cont
        xor r9, r9
            .cont:
              cmp r11, 0
              je .print
              mov r8b, BYTE[r15 + r9]             ; r8b = current key char
              xor BYTE[buffer + r12], r8b         ; xor with curret char and key
              dec r11
              inc r12
              inc r9
              jmp .outer_loop


    .print:
        mov rax, SYS_WRITE
        mov rdi, STDOUT
        mov rsi, buffer
        mov rdx, r13
        syscall
        jmp .exit

        ; close(filedescriptor)
        mov rax, SYS_CLOSE              ; close file
        mov rdi, r14
        syscall

        call endl

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


      strlen1:
          push rbp
          mov rbp, rsp

          xor rax, rax                    ; the length of the string

          .cmploop:
              cmp BYTE [rdi + rax], 0     ; check if current byte is null
              je .cmpdone                 ; if yes, done
              inc rax                     ; else increment length counter
              jmp .cmploop                ; and continue

          .cmpdone:
              inc rax
              cmp BYTE [rdi + rax], 0     ; check if current byte is null
              jne .cmploop
              dec rax
              leave
              ret
