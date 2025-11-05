#include <string.h>

/*
 * find length of initial segment of s consisting entirely of characters not from reject
 */
size_t strcspn(register const char *s, const char *reject)
{
    register const char *sscan;
    register const char *rscan;

    for (sscan = s; *sscan != '\0'; sscan++)
    {
        for (rscan = reject; *rscan != '\0';)
        {
            if (*sscan == *rscan++)
                break;
        }
        if (*rscan != '\0')
        	break;
    }
    return sscan - s;
}
