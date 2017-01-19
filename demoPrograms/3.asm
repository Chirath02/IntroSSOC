BITS 64

extern printf
extern scanf

section .data                ; section - logical unit in a program, can be changed
    var1 :    dq 1           ; dp - declare qword(8 bytes)

section .rodata              ; read only data
    var2 :    db "%d", 10, 0 ; db - declare byte 

section .text                ; contains only executable code
    global main              ; global main basically means that the symbol should be visible to the linker because other object files will use it.

    main:
        push rbp             ; setting up the stack frame for main 
        mov rbp, rsp         ; stack frame never grows - as there is no change in rbp and rsp in the entire main

        .label1:             ; print 1 to 10
            mov rsi, QWORD [var1] ;[] - deference QWORD bytes of data
            mov rdi, var2
            call printf
            inc QWORD [var1]
            cmp QWORD [var1], 10
            jg .label2       ; jumb if greater than 10 ,exit contition
            jmp .label1      ; jumb

        .label2:
            xor rax, rax    ; rax = 0 (return 0), non zero means - execution was not correct-
            leave
            ret
