#include <stdio.h>
#include <termio.h>
#include <fcntl.h>
#include <time.h>

long trap_14_w(short n);
#define Gettime() trap_14_w(23)

unsigned char pktlentab[10] = { 7, 5, 2, 2, 2, 2, 6, 2, 1, 1 };

const char *monthtab[12] = {
	"Jan",
	"Feb",
	"Mar",
	"Apr",
	"May",
	"Jun",
	"Jul",
	"Aug",
	"Sep",
	"Oct",
	"Nov",
	"Dec",
};

void Raw_On(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode |= M_RAW;
	ioctl(fd, TCSTTY, &t);
}


void Echo_Off(int fd)
{
	struct sgtty t;
	
	ioctl(fd, TCGTTY, &t);
	t.t_mode &= ~M_ECHO;
	ioctl(fd, TCSTTY, &t);
}


void readtime(register int fd, register unsigned char *buf)
{
	unsigned char ikbdbuf[256];
	short inpkt;
	short pktlen;
	register int count;
	register unsigned char *outptr;
	register unsigned char *pktptr;
	register int c;
	register int pkttype;
	
	inpkt = 0;
	for (;;)
	{
		while ((count = read(fd, ikbdbuf, 256)) <= 0)
			;
		pktptr = ikbdbuf;
		for (;;)
		{
			if (count-- == 0)
				break;
			c = *pktptr++ & 0xff;
			if (!inpkt)
			{
				if (c >= 246) /* multi-byte packet answer */
				{
					pkttype = c;
					pktlen = pktlentab[c - 246];
					outptr = buf;
					inpkt = 1;
				}
			} else if (inpkt == 1)
			{
				*outptr++ = c;
				if (--pktlen == 0)
				{
					inpkt = 0;
					if (pkttype == 252) /* found time response */
						return;
				}
			}
		}
	}
}


#define MUL10(x) ((((x) << 2) + (x)) << 1)

static int decodebcd(int val)
{
	register int tens;
	tens = ((val >> 4) & 0x0f);
	return (val & 0x0f) + MUL10(tens);
}


int main(int argc, char **argv)
{
	register int fd;
	struct tm tm;
	time_t t;
	int isdst;
	unsigned char buf[32];
	register int sum;
	register int i;

	fd = open("/dev/clock", O_RDWR);
	if (fd < 0)
	{
		printf("Unable to open '/dev/clock'!\n");
		return 1;
	}
	Raw_On(fd);
	Echo_Off(fd);
	write(fd, "\x1c", 1); /* request IKBD time */
	for (i = 0; i < 32; i++)
		buf[i] = 0;
	readtime(fd, buf);
	sum = 0;
	for (i = 0; i < 6; i++)
	{
		sum += buf[i];
	}
	if (sum == 0)
	{
		printf("cannot read ikbd time\n");
		return 1;
	}

	t = time(0);
	ltime(&tm, t);
	isdst = tm.tm_isdst;

	tm.tm_year = decodebcd(buf[0]);
	if (tm.tm_year < 80)
		tm.tm_year += 100;
	else
		tm.tm_year += 0;
	tm.tm_mon = decodebcd(buf[1]) - 1;
	tm.tm_mday = decodebcd(buf[2]);
	tm.tm_hour = decodebcd(buf[3]);
	tm.tm_min = decodebcd(buf[4]);
	tm.tm_sec = decodebcd(buf[5]);

	if (tm.tm_mon < 0 || tm.tm_mon > 11)
	{
		printf("!!!bad month conversion for <%d>!!!\n", tm.tm_mon);
		return 1;
	}

	t = ultime(&tm);
	ltime(&tm, t);
	if (!isdst && tm.tm_isdst)
	{
		t -= 3600;
		ltime(&tm, t);
	} else if (isdst && !tm.tm_isdst)
	{
		t += 3600;
		ltime(&tm, t);
	}

	if (stime(t) < 0)
	{
		printf("must be superuser to set date\n");
		return 1;
	}
	
	t = time(0);
	ltime(&tm, t);

	if (argc > 1)
	{
		printf("%04d%02d%02d%02d%02d\n", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min);
	} else
	{
		printf("%s %d, %04d at %02d:%02d:%02d\n", monthtab[tm.tm_mon], tm.tm_mday, tm.tm_year + 1900, tm.tm_hour, tm.tm_min, tm.tm_sec);
	}

	return 0;
}
