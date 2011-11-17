#include <stdio.h>

/* print Fahrenheit-Celsius table
 * for celsius = -20, -10, .., 150 */

main()
{
    float fahr, celsius;
    int lower, upper, step;

    lower = -20;
    upper = 150;
    step = 10;

    celsius = lower;
    
    printf("%3s\t%6s\n", "C", "F");
    while (celsius <= upper) {
        fahr = (9.0/5.0) * celsius + 32.0;
        printf("%3.0f\t%6.1f\n",  celsius, fahr);
        celsius = celsius + step;
    }
}
