#include <stdio.h>

double fahr_to_celsius(double fahr)
{
    return (5.0/9.0) * (fahr - 32.0);
}

double celsius_to_fahr(double celsius)
{
    return (9.0/5.0) * celsius + 32;
}

int main()
{
    int fahr;

    for (fahr = 0; fahr < 300; fahr = fahr + 20)
        printf("%3d %6.f\n", fahr, fahr_to_celsius(fahr));
}

