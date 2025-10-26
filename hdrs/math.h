/*	MATHEMATICAL FUNCTIONS HEADER
 *	copyright (c) 1984, 1987 by Whitesmiths, Ltd.
 */

#ifndef __MATH__
#define __MATH__	1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

/*	function declarations
 */
int abs __((int i));
double acos __((double x));
double asin __((double x));
double atan __((double x));
double atan2 __((double y, double x));
double ceil __((double x));
double cos __((double x));
double cosh __((double x));
double exp __((double x));
double fabs __((double x));
double floor __((double x));
double fmod __((double x, double y));
double frexp __((double value, int *exp));
double ldexp __((double x, int exp));
double log __((double x));
double log10 __((double x));
double modf __((double value, double *pd));
double pow __((double x, double y));
double sin __((double x));
double sinh __((double x));
double sqrt __((double x));
double tan __((double x));
double tanh __((double x));

/*	largest double number
 */
extern double _huge;

/*	defines
 *	if EDOM and/or ERANGE change, also change dom.c and range.c!
 */
#ifndef __ERRNO__
#define EDOM	33
#define ERANGE	34
#endif
#define HUGE_VAL	_huge

#include <sys/os.h>

#ifdef _IDRIS
#define HUGE		HUGE_VAL
#endif

#endif
