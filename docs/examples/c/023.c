#include <stdio.h>

/* print as histogram */

int main()
{
    int c, i, j, nwhite, nother;
    int ndigit[10];

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
    for (i = 0; i < 10; ++i) {
        printf("%c: ", '0'+i);
        for (j = 0; j < ndigit[i]; ++j) {
            printf("*");
        }
        printf("\n");
    }

    /* Print white space */
    printf(" : ");
    for (j = 0; j < nwhite; ++j) {
        printf("*");
    }
    printf("\n");

    /* Print others */
    printf("o: ");
    for (j = 0; j < nother; ++j) {
        printf("*");
    }
    printf("\n");
}

