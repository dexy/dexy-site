#include <stdio.h>
#define MAXBLANK 20

int strip();

int main()
{
    char blanks[MAXBLANK];

    while ( rstrip(blanks) )
        ;

    return 0;
}

int rstrip(char blanks[])
{
    int c, i, j, allblank;

    i = 0;
    allblank = 1;

    while ((c = getchar()) != EOF && c!='\n') {
        if (c == ' ' || c == '\t') {
            if (i < MAXBLANK-1) {
                blanks[i++] = c;
            }
        }
        else {
            allblank = 0;
            if (i > 0) {
                for (j = 0; j < i; j++)
                    putchar(blanks[j]);
                i = 0;
            }
            putchar(c);
        }
    }

    if (1-allblank)
        printf("*\n");

    return (c != EOF);
}

