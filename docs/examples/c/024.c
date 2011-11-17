#include <stdio.h>

/* print as vertical histogram */

int main()
{
    int c, i, j, nwhite, nother;
    int ndigit[10];
    int sum;

    nwhite = nother = 0;

    for (i = 0; i < 10; ++i) {
        ndigit[i] = 0;
    }

    while ((c = getchar()) != EOF)
        if ( c >= '0' && c <= '9')
            ++ndigit[c-'0'];
        else if (c == ' ' || c == '\n' || c == '\t')
            ++nwhite;
        else
            ++nother;

    printf("\n");

    /* print headers */
    for (i = 0; i < 10; i++) {
        printf("%c\t", '0'+i);
    }
    printf(" \to\t\n");

    sum = 1;
    j = 0;
    while (sum > 0) {
        sum = 0;

        /* print histogram for digit counters */
        for (i = 0; i < 10; i++) {
            if (ndigit[i] > j) {
                printf("*");
                ++sum;
            }
            printf("\t");
        }

        if (nwhite > j) {
            printf("*");
            ++sum;
        }
        printf("\t");

        if (nother > j) {
            printf("*");
            ++sum;
        }
        printf("\t");

        printf("\n");
        ++j;
    }
}

