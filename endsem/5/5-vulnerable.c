#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUF_SIZE 256


void print_flag() {
    system("cat flag.txt");
    _exit(0);
}


int main()
{
    char buf[BUF_SIZE];
    printf("Welcome to simple echo server!\n");
    printf("I print back any input you give me and exit.\n");
    scanf("%[^\n]", buf);
    printf("%s\n", buf);
    return 0;
}
