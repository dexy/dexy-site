#include <stdio.h>

int main()
{
    int c, already;

    while ((c = getchar()) != EOF) {
        already = 0;

        if (c == '\t')  {
            printf("\\t");
            already = 1;
        }

        if (c == '\b') {
            printf("\\b");
            already = 1;
        }

        if (c == '\\') {
            printf("\\\\");
            already = 1;
        }

        if (1 - already)
            putchar(c);
    }

}
