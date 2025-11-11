#include "libc.h"

double _dtens[] = {
	1.0E00,
	1.0E01,
	1.0E02,
	1.0E04,
	1.0E08,
	1.0E16,
	1.0E32,
	1.0E64,
	1.0E128,
	1.0E256
};

short _maxprec = 17;
short _ntens = sizeof(_dtens) / sizeof(_dtens[0]);
double _dzero;
