BITS 64

extern printf                               ; declare that printf is defined elsewhere
extern atoi

section .rodata                             ; start of data section
    str1: db "Minimum : %d", 10, 0  ; string we wish to print out, always will be a pointer
    str2: db "No input given", 10, 0

section .text                               ; start of text section
    global main                             ; declare main as globally visible

    main:
        push rbp                            ; set up main's stack frame
        mov rbp, rsp                        ; on top of it's caller's frame

	cmp rdi, 2
	jl .noinput
	
	mov r15, rdi
	dec r15
	mov r14, rsi

	mov r13, 1
	
	mov rdi, qword[r14 + 8 * r13]
	call atoi
	mov r12, rax

	.loop:
		cmp r13, r15
		je .print
		inc r13
		mov rdi, qword[r14 + 8 * r13]
		call atoi
		cmp r12, rax
		jle .loop
		mov r12, rax
		jmp .loop


	.print:
		mov rdi, str1
		mov rsi, r12
		call printf
		jmp .exit

	.noinput:
		mov rdi, str2
		call printf

	.exit:

        mov rax, 0                          ; set return value
        mov rsp, rbp                        ; destroy main's stack frame and
        pop rbp                             ; restore main's caller's stack frame
        ret                                 ; return to main's caller
