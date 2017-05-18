#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


int main() {
    char buf[64];
    uint64_t variable = 0x1234567812345678;

    scanf("%[^\n]", buf);
    if (variable == 0x4141414141414141) {
        system("cat flag.txt");
    }
    else {
        printf("Value of variable: 0x%" PRIx64 "\n", variable);
    }
    return 0;
}
