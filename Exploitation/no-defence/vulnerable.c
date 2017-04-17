#include <stdio.h>

int main(void)
{
    char buf[256];
    printf("Enter input: ");
    scanf("%[^\n]", buf);
    printf("%s\n", buf);
    return 0;
}
