#include <stdio.h>
#define MAXLINE 100

int readline(char line[], int max);
void reverse(char original[], char reversed[]);

int main()
{
    char original[MAXLINE];
    char reversed[MAXLINE];
    
    while (readline(original, MAXLINE)) {
        reverse(original, reversed);
        printf("reversed: %s\n", reversed);
    }

    return 0;
}

int readline(char line[], int max)
{
    int c, i;
    i = 0;
    while ((c = getchar()) != EOF && c != '\n' && i < MAXLINE-1) {
        line[i++] = c;
    }
    line[i] = '\0';

    return c != EOF;
}

void reverse(char original[], char reversed[])
{
    int i, len;

    len = 0;
    while ( original[len++] != '\0' )
        ;

    for (i = 0; i < len - 1; i++) {
        reversed[i] = original[len-i-2];
    }

    reversed[len-1] = '\0';
}
