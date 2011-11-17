#include <stdio.h>

main()
{
    int c, not_eof;
    
    not_eof = 1;

    while (not_eof) {
        c = getchar();
        not_eof = (c != EOF);
        printf("value of not_eof is %d\n", not_eof);
    }
}

