#include <stdio.h>

extern int mytoupper(const char *, char *);

#define MAX_BUFFSIZE 255

int main() {
    const char *str = "This is a test.";
    char outBuf[MAX_BUFFSIZE];

    int len = mytoupper(str, outBuf);
    printf("Before str: %s\n", str);
    printf("After  str: %s\n", outBuf);
    printf("str len   : %d\n", len);

    return 0;
}
