#include <string.h>

/*
 * find length of initial segment of s consisting entirely of characters from accept
 */
size_t strspn(register const char *s, const char *accept)
{
    register const char *sscan;
    register const char *ascan;

    for (sscan = s; *sscan != '\0'; sscan++)
    {
        for (ascan = accept; *ascan != '\0'; ascan++)
        {
            if (*sscan == *ascan)
                break;
        }
        if (*ascan == '\0')
            break;
    }
    return sscan - s;
}

