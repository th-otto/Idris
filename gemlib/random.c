#include <stdlib.h>

long random(void)
{
	return rand();
}

void srandom(unsigned int seed)
{
	srand(seed);
}
