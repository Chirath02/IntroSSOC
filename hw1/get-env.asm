; Author    :   Chirath R                                                      ;
; Date      :   32/01/2017                                                     ;
; Program   :   print "Hello world" using printf                               ;
; Note      :   This program was tested on debain 8.6 64 bit using             ;
;               nasm 2.11.05 and gcc 4.9.2.                                    ;
;                                                                              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64

extern printf
extern getenv                  ; declare that printf is defined elsewhere

section .rodata                             ; start of data section
    hello_world: db "Hello, world!", 10, 0  ; string we wish to print out, always will be a pointer

    section .text                               ; start of text section
        global main                             ; declare main as globally visible

    main:
	push rbp                            ; set up main's stack frame
	mov rbp, rsp                        ; on top of it's caller's frame

	mov r11, [rdx]

	.label:
		mov rdi, r11
		call printf
		add r11, 8
		jmp .label



	mov rax, 0                          ; set return value
	mov rsp, rbp                        ; destroy main's stack frame and
	pop rbp                             ; restore main's caller's stack frame
	ret
