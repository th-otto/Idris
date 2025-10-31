#include <ansxwr.h>
#include <wslxa.h>
#include <tvec.h>
#include <time.h>
#include <sys/stat.h>
#include <who.h>

extern char *_edt;
extern char *_est;

static int cflag;
static int iflag;
static int tflag;
static unsigned int addmins;
static unsigned int yrs;
static char *fmt;
static int exit_code;
static char devnamebuf[16];

static char mon[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
static char datestr[] = "Thu Jan 01 00:00:00 1970 ";

char *dig2(register char *str, register int val)
{
	*str++ = (val / 10) + '0';
	*str++ = (val % 10) + '0';
	return str;
}


static int alldig(register const char *str)
{
	register int alldigits;
	
	alldigits = 0;
	while (*str != '\0')
	{
		if (*str >= '0' && *str <= '9')
		{
			str++;
			alldigits++;
		} else
		{
			return 0;
		}
	}
	return alldigits;
}


char *myctime(register struct tm *timep, register char *buf)
{
	register char *str;
	
	str = dig2(buf, timep->tm_year);
	str = dig2(str, timep->tm_mon + 1);
	str = dig2(str, timep->tm_mday);
	str = dig2(str, timep->tm_hour);
	str = dig2(str, timep->tm_min);
	*str = '\0';
	return buf;
}


#if 0 /* already in c-library */
int d_mth(int month, int year)
{
	if (month != 1)
		return mon[month];
	if ((year & 3) != 0)
		return 28;
	return 29;
}


int d_yr(int year)
{
	if ((year & 3) != 0)
		return 365;
	return 366;
}
#endif


void parsedat(char *str, struct _tvec *tv)
{
	unsigned int alldigits;
	register int count;
	
	alldigits = alldig(str);
	if (alldigits > 12 || alldigits == 0)
		usage("expects [yy]yymmddhhmm\n");
	count = alldigits & 1 ? 1 : 2;
	switch (alldigits)
	{
	case 11:
	case 12:
		btoi(str, count + 2, &tv->yr, 10);
		tv->yr -= 1900;
		if (tv->yr < 70 || tv->yr > 2106)
			usage("year must be between 1970 and 2106 inclusive\n");
		str += count + 2;
		count = 2;
		goto domonth;
	case 9:
	case 10:
		btoi(str, count, &tv->yr, 10);
		if (tv->yr < 70)
			usage("year must be between 70 and 99 inclusive\n");
		str += count;
		count = 2;
		/* fall through */
	domonth:
	case 7:
	case 8:
		btoi(str, count, &tv->mth, 10);
		tv->mth--;
		if (tv->mth >= 12)
			usage("month must be between 1 and 12 inclusive\n");
		str += count;
		count = 2;
		/* fall through */
	case 5:
	case 6:
		btoi(str, count, &tv->dmth, 10);
		if (tv->dmth == 0 || tv->dmth > d_mth(tv->mth, tv->yr))
			usage("day must be between 1 and 28-31 as appropriate\n");
		str += count;
		count = 2;
		/* fall through */
	case 3:
	case 4:
		btoi(str, count, &tv->hrs, 10);
		if (tv->hrs >= 24)
			usage("hours must be between 0 and 23 inclusive\n");
		str += count;
		count = 2;
		/* fall through */
	case 1:
	case 2:
		btoi(str, count, &tv->mins, 10);
		if (tv->mins >= 60)
			usage("minutes must be between 0 and 59 inclusive\n");
		str += count;
		count = 2;
		break;
	}
	tv->secs = 0;
}



int settime(time_t oldtime, time_t newtime)
{
	int fd;
	struct stat st;
	WHO buf;
	WHO buf2;

	if (stime(newtime) < 0)
		return 0;
	fill(&buf, sizeof(buf), 0);
	if (fstat(STDERR, &st) >= 0 && devname(devnamebuf, st.st_rdev, 1) != 0)
	{
		cpystr(buf.w_tty, devnamebuf, NULL);
	} else
	{
		cpystr(buf.w_tty, "?", NULL);
	}
	_cpybuf(buf.w_uname, "old:time", 8);
	_cpybuf(&buf2, &buf, sizeof(buf));
	_cpybuf(buf2.w_uname, "new", 3);
	buf.w_time = oldtime;
	buf2.w_time = newtime;
	if ((fd = open(HSTFILE, 1)) >= 0)
	{
		lseek(fd, 0, 2);
		write(fd, &buf, sizeof(buf));
		write(fd, &buf2, sizeof(buf2));
		close(fd);
	}
	return 1;
}


static char *rdstr(int fd, register char *buf, register int maxlen)
{
	register char *ptr;
	
	ptr = buf;
	for (;;)
	{
		if (read(fd, ptr, 1) != 1)
			break;
		if (*ptr == '\n')
			break;
		if (ptr != buf || (*ptr >= ' ' && *ptr < 0x7f))
		{
			if (maxlen > 0)
			{
				ptr++;
				maxlen--;
			}
		}
	}
	*ptr = '\0';

	return buf;
}


int main(unsigned int argc, char **argv)
{
	int dstf;
	int fd;
	struct _tvec tv;
	time_t newtime;
	time_t oldtime;
	char *buf;
	
	if (argc <= 1)
		tflag = 1;
	getflags(&argc, &argv, "c,f*,i,t,y#,+#:F <yymmddhhmm>",
		&cflag,
		fmt,
		&iflag,
		&tflag,
		&yrs,
		&addmins);
	
	if (cflag && tflag)
		usage("takes only one of -[c t]\n");
	
	oldtime = time(0);
	ltime(&tv, oldtime);
	dstf = tv.dstf;
	
	if (yrs != 0 && ((yrs < 100 && yrs >= 70) || (yrs >= 1970 && yrs < 2106)))
	{
		tv.yr = yrs < 100 ? yrs : yrs - 1900;
	} else if (yrs != 0)
	{
		usage("year must be between 70 and 99 or 1970 and 2105 inclusive\n");
	}
	
	if (iflag)
	{
		rdstr(STDIN, datestr, 26);
		parsedat(datestr, &tv);
	} else if (argc != 0)
	{
		parsedat(*argv, &tv);
	}
	
	newtime = ultime(&tv);
	newtime += addmins * 60;
	ltime(&tv, newtime);
	if (!dstf && tv.dstf)
	{
		newtime -= 3600;
		ltime(&tv, newtime);
	} else if (dstf && !tv.dstf)
	{
		newtime += 3600;
		ltime(&tv, newtime);
	}
	
	if (!tflag && !cflag)
	{
		if (!settime(oldtime, newtime))
		{
			_remark("must be superuser to set date", NULL);
			exit_code = 1;
		}
	}
	
	if (cflag)
	{
		putstr(STDOUT, myctime((struct tm *)&tv, datestr), "\n", NULL);
	} else if (fmt == 0)
	{
		putstr(STDOUT, atime(&tv, datestr), tv.dstf ? _edt : _est, "\n", NULL);
	} else
	{
		buf = alloc(512);
		strftime(buf, 511, fmt, (struct tm *)&tv);
		putstr(STDOUT, buf, "\n", NULL);
		free(buf);
	}
	
	if (!tflag && !cflag && exit_code == 0)
	{
		if ((fd = creat(DATEFIL, 1)) >= 0)
		{
			putstr(fd, atime(&tv, datestr), tv.dstf ? _edt : _est, "\n", NULL);
			close(fd);
		}
		sync();
	}
	
	return exit_code;
}
