#include <stdio.h>

int dummy() {
    return 2;
}

int mytoupper(const char *instr, char *outstr) {
    char *orig_outstr = outstr;

    dummy();

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

#define BUFFERSIZE 10

int main() {
    const char *tst_str = "This is a test!xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxyyyyyyandevenlongerandlongerandlonger";
    char out_str[BUFFERSIZE];

    mytoupper(tst_str, out_str);
    printf("Input: %s\nOutput: %s\n", tst_str, out_str);

    return 0;
}
