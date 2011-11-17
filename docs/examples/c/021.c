#include <stdio.h>

#define IN 0 /* inside a word */
#define OUT 1 /* outside a word */

/* print input 1 word per line */
int main()
{
    int c, state;

    state = OUT;

    while ((c = getchar()) != EOF) {
        if (c == ' ' || c == '\n' || c == '\t') {
            state = OUT;
        } else if (state == OUT) {
            state = IN;
            putchar('\n');
            putchar(c);
        } else {
            putchar(c);
        }
    }
}

