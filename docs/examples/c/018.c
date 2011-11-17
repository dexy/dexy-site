#include <stdio.h>

int main()
{
    
    int c, in_space;

    in_space = 0;
    
    while ((c = getchar()) != EOF) {
        if (c != ' ') {
            if (in_space)
                putchar(' ');
            putchar(c);
        }

        in_space = (c == ' ');
    }

}
