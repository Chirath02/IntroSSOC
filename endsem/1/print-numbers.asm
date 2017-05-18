BITS 64

extern printf

section .rodata
	var1 : db "%d", 10, 0 
section .bss

section .text                             
    global main                           

    main:
	push rbp                     
	mov rbp, rsp                      
	
	mov r15, 100
	.loop:
		mov rdi, var1
		mov rsi, r15
		call printf

		sub r15, 2
		cmp r15, 0
		je .end
		jmp .loop

	.end:
	xor rax, rax
	leave
	ret
