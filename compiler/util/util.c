#include <stdlib.h>
#include <stdio.h>
#include "util.h"

BOOL lsfmt = FALSE;

/*	get a long in proper byte order
 */
uint32_t xstol(const unsigned char *s)
{
	uint32_t val;

	if (lsfmt)
	{
		s += 3;
		val = *s;
		val <<= 8;
		val |= *--s;
		val <<= 8;
		val |= *--s;
		val <<= 8;
		val |= *--s;
	} else
	{
		val = *s++;
		val <<= 8;
		val |= *s++;
		val <<= 8;
		val |= *s++;
		val <<= 8;
		val |= *s;
	}
	return val;
}


/*	pack a long into a buffer in correct byte order
 */
void ltoxs(unsigned char *b, uint32_t val)
{
	if (lsfmt)
	{
		b[0] = val;
		val >>= 8;
		b[1] = val;
		val >>= 8;
		b[2] = val;
		val >>= 8;
		b[3] = val;
	} else
	{
		b[3] = val;
		val >>= 8;
		b[2] = val;
		val >>= 8;
		b[1] = val;
		val >>= 8;
		b[0] = val;
	}
}


/*	get a short in proper byte order
 */
uint16_t xstos(const unsigned char *s)
{
	uint16_t val;

	if (lsfmt)
		val = s[0] | s[1] << 8;
	else
		val = s[0] << 8 | s[1];
	return val;
}


/*
 * convert integer to leading low-byte string
 */
void itols(unsigned char *s, uint16_t n)
{
	s[0] = n;
	s[1] = n >> 8;
}


/* convert leading low-byte string to integer */
uint16_t lstoi(const uint16_t *s)
{
	const unsigned char *us = (const unsigned char *)s;
	
	return (uint16_t)((us[1] << 8) | us[0]);
}


/*	pack a short into a buffer in correct byte order
 */
void stoxs(unsigned char *b, uint16_t val)
{
	if (lsfmt)
	{
		b[0] = val;
		b[1] = val >> 8;
	} else
	{
		b[1] = val;
		b[0] = val >> 8;
	}
}

/*
 * convert leading low-byte string to unsigned short
 */
uint16_t lstou(const unsigned char *s)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return (uint16_t)((us[1] << 8) | us[0]);
}


/*
 * return long from pdp-endian format
 */
int32_t lstol(const unsigned char *s)
{
	register const unsigned char *us = (const unsigned char *)s;
	
	return (int32_t)(((int32_t)((us[1] << 8) | us[0]) << 16) | ((us[3] << 8) | us[2]));
}


/*
 * convert long to pdp-endian format
 */
void ltols(unsigned char *pl, int32_t lo)
{
	pl[2] = lo;
	lo >>= 8;
	pl[3] = lo;
	lo >>= 8;
	pl[0] = lo;
	lo >>= 8;
	pl[1] = lo;
}


void *xmalloc(size_t n)
{
	void *ptr = malloc(n);
	if (ptr == NULL)
		abort();
	return ptr;
}


void *buybuf(const void *s, size_t n)
{
	const char *src;
	void *ptr;
	char *dst;
	
	ptr = xmalloc(n);
	src = s;
	dst = ptr;
	while (n != 0)
	{
		*dst++ = *src++;
		n--;
	}
	return ptr;
}


size_t getlin(char *s, size_t n)
{
	FILE *fp = stdin;
	size_t count;
	int c;

	count = 0;
	while (count < n)
	{
		c = fgetc(fp);
		if (c == EOF)
			break;
		count++;
		*s++ = c;
		if (c == '\n')
			break;
	}
	*s = '\0';
	return count;
}


BOOL _remark(const char *s1, const char *s2)
{
	fprintf(stderr, "%s: %s%s\n", _pname, s1 ? s1 : "", s2 ? s2 : "");
	return FALSE;
}

void _error(const char *s1, const char *s2)
{
	_remark(s1, s2);
	exit(1);
}
