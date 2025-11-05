#include <string.h>

/*
 * find first occurence of any char from breakat in s
 */
char *strpbrk(register const char *s, const char *breakat)
{
    register const char *bscan;

    for (; *s != '\0'; s++)
    {
        for (bscan = breakat; *bscan != '\0';)
        {
            if (*s == *bscan++)
                return (char *) s;
        }
    }
    return NULL;
}


