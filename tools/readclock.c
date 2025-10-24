#include <stdio.h>
#include <termio.h>
#include <fcntl.h>

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
	unsigned short dostime;
	unsigned short dosdate;
	short year;
	register short month;
	short day;
	short hour;
	register short min;
	short sec;
	long datetime;
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
	readtime(fd, buf);
	sum = 0;
	for (i = 0; i < 6; i++)
	{
		sum += buf[i];
	}
	if (sum == 0)
	{
		datetime = Gettime();
		dosdate = (datetime >> 16) & 0xffff;
		dostime = datetime & 0xffff;
		year = ((dosdate >> 9) & 0x7f) + 1980;
		month = (dosdate >> 5) & 0x0f;
		day = dosdate & 0x1f;
		hour = (dostime >> 11) & 0x1f;
		min = (dostime >> 5) & 0x3f;
		sec = (dostime << 1) & 0x3e;
	} else
	{
		year = decodebcd(buf[0]);
		if (year < 80)
			year += 2000;
		else
			year += 1900;
		month = decodebcd(buf[1]);
		day = decodebcd(buf[2]);
		hour = decodebcd(buf[3]);
		min = decodebcd(buf[4]);
		sec = decodebcd(buf[5]);
	}
	if (month < 1 || month > 12)
	{
		printf("!!!bad month conversion for <%d>!!!\n", month);
		return 1;
	}

	if (argc > 1)
	{
		printf("%04d%02d%02d%02d%02d\n", year, month, day, hour, min);
	} else
	{
		printf("%s %d, %04d at %02d:%02d:%02d\n", monthtab[month - 1], day, year, hour, min, sec);
	}
		
	return 0;
}
