#include <std.h>
#include <pcdecl.h>
#include <termio.h>
#include "libi.h"

const char *baudlist[NBAUD] = {
	"0",
	"50",
	"75",
	"110",
	"134.5",
	"150",
	"200",
	"300",
	"600",
	"1200",
	"1800",
	"2400",
	"4800",
	"9600",
	"19200",
	"38400"
};

/*
 * return code given speed text
 */
UCOUNT baudcode(const char *s)
{
	register short i;
	register const char **list;
	
	for (list = baudlist, i = 0; i < NBAUD; i++, list++)
	{
		if (_cmpstr(s, *list))
			break;
	}
	return i;
}

/*
 * return text speed given speed code
 */
const char *baudtext(UCOUNT c)
{
	return c < NBAUD ? baudlist[c] : NULL;
}
