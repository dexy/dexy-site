#include <stdio.h>
#define MAXLINE 60

int mygetline(char line[], int maxline);

int main()
{
    char line[MAXLINE];
    
    while (mygetline(line, MAXLINE))
        ;
    
    return 1;
}

int mygetline(char line[], int maxline)
{
    int c, i;

    for (i = 0; (c = getchar()) != EOF && c != '\n'; i++) {
        if (i < MAXLINE-1)
            line[i] = c;
        if (i == MAXLINE-1) {
            line[i] = '\0';
            printf("\n\nThis line has more than %d chars:\n", MAXLINE);
            printf(line);
        }
        if (i >= MAXLINE-1)
            putchar(c);
    }
    
    return c != EOF;
}
