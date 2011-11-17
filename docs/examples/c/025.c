#include <stdio.h>

#define MAX 74
#define START '0'

int main()
{
    int c, i, j;
    int nchar[MAX];
     
    for (i = 0; i < MAX; ++i) {
        nchar[i] = 0;    
/*        printf("Initializing space %d for char '%c'\n", i, START+i);   */
    }

    while ((c = getchar()) != EOF) {
        if (c >= START && c <= START + MAX)
            ++nchar[c-START];
    }
    
    for (i = 0; i < MAX; ++i) {
        printf("\n%c: ", START+i);
        for (j = 0; j < nchar[i]; ++j)
            printf("*");
    }

}
