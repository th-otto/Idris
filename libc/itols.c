#include <wslxa.h>

/*
 * convert integer to leading low-byte string
 */
TEXT *itols(register TEXT *s, COUNT n)
{
	s[0] = n;
	s[1] = n >> 8;
	return s;
}
