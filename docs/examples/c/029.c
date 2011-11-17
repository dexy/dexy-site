#include <stdio.h>
#define MAXLINE 80 /* maximum input line size */

int mygetline(char line[], int maxline);
void copy(char to[], char from[]);

/* print longest input line */

int main()
{
    int len; /* current line length */
    int max; /* maximum length seen so far */
    char line[MAXLINE];
    char longest[MAXLINE];

    max = 0;
    while ((len = mygetline(line, MAXLINE)) > 0)
        if (len > max) {
            max = len;
            copy(longest, line);
        }
    if (max > 0) {
        printf("\n\nThe longest line of input, at %d characters, was\n%s", max, longest);
        if (max > MAXLINE)
            printf("...\n"); /* show this was truncated */
    }

    return 0;
}

int mygetline(char s[], int lim)
{
    int c, i;
    for (i = 0; (c=getchar()) != EOF && c!='\n'; ++i)
        if (i < lim - 1)
            s[i] = c;
    if (c == '\n') {
        if (i < lim - 1)
            s[i] = c;
        ++i;
    }
    s[i] = '\0';
    return i;
}

void copy(char to[], char from[])
{
    int i;

    i = 0;
    while ((to[i] = from[i]) != '\0')
        ++i;
}

