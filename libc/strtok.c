#include <string.h>

static char *scanpoint;

/*
 * extract tokens from strings
 */
char *strtok(char *s, const char *delim)
{
	register char *scan;
	
	if (s != NULL)
		scanpoint = s;
	if (scanpoint == NULL || *scanpoint == '\0')
		return NULL;
	scan = scanpoint + strspn(scanpoint, delim);
	scanpoint = scan + strcspn(scan, delim);
	if (*scan == '\0')
		return NULL;
	if (*scanpoint == '\0')
		return scan;
	*scanpoint++ = '\0';
	return scan;
}
