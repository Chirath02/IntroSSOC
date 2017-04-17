#include <stdio.h>

void g1() {
    asm(".intel_syntax noprefix");
    asm("pop rdi");
    asm("pop rsi");
    asm("ret");
}

int main(void)
{
    char buf[256];
    printf("Enter input: ");
    scanf("%[^\n]", buf);
    printf("%s\n", buf);
    return 0;
}
