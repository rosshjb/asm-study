#include <stdio.h>

int mytoupper(const char *instr, char *outstr) {
    char *orig_outstr = outstr;

    char cur;
    do {
        cur = *instr;
        if ((cur >= 'a') && (cur <= 'z'))
            cur = cur - ('a'-'A');
        *outstr++ = cur;
        instr++;
    } while (cur != '\0');

    return (outstr - orig_outstr);
}

#define BUFFERSIZE 250

const char *tst_str = "This is a test!";
char out_str[BUFFERSIZE];

int main() {
    mytoupper(tst_str, out_str);
    printf("Input: %s\nOutput: %s\n", tst_str, out_str);

    return 0;
}
