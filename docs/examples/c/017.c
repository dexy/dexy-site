#include <stdio.h>

int main() 
{
    int c, nb, nt, nl;

    nb = 0;
    nt = 0;
    nl = 0;

    while ((c = getchar()) != EOF) {
        if (c=='\n')
            ++nl;
        if (c=='\t')
            ++nt;
        if (c==' ')
            ++nb;
    }
    
    printf("\n\n");
    printf("tabs\t%d\n", nt);
    printf("spaces\t%d\n", nb);
    printf("lines\t%d\n", nl);
}
