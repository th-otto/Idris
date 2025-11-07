#include <std.h>
#include <pcdecl.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <dirent.h>

#ifndef dmajor
#define dmajor(dev) ((unsigned short) (dev) >> 8)
#define dminor(dev) ((dev) & 0xff)
#endif

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif


/*
 * get device name
 */
BOOL _devname(char *s, register UCOUNT mdev, register BOOL cspec)
{
	unsigned short major_num;
	register mode_t mode;
	register short minor_num;
	register int fd;
	struct dirent entry;
	struct stat st;
	char buf[NAME_MAX + 6];
	const char *filename = cspec ? "/dev/cnames" : "/dev/bnames"; /* 84 */

	memset(s, 0, NAME_MAX);
	fd = open(filename, O_RDONLY, S_IXOTH);
	if (fd >= 0)
	{
		major_num = 0;
		minor_num = 0;
		for (;;)
		{
			if (dmajor(mdev) == major_num && dminor(mdev) == minor_num)
			{
				strcpy(buf, "/dev/");
				/* minor_num used as buf index here */
				minor_num = 5;
				while (minor_num < (short)sizeof(buf) - 1 && read(fd, &buf[minor_num], 1) == 1 &&
					buf[minor_num] != '\n' &&
					buf[minor_num] != ' ')
				{
					minor_num++;
				}
				buf[minor_num] = '\0';
				if (stat(buf, &st) >= 0 && (mode = st.st_mode) != 0 && st.st_rdev == mdev)
				{
					if (cspec ? S_ISCHR(mode) : S_ISBLK(mode))
					{
						strcpy(s, &buf[5]);
						close(fd);
						return TRUE;
					}
				}
				close(fd);
				break;
			}
			if (read(fd, buf, 1) != 1)
			{
				close(fd);
				break;
			}
			if (buf[0] == '\n')
			{
				major_num++;
				minor_num = 0;
			} else if (buf[0] == ' ')
			{
				minor_num++;
			}
		}
	}

	fd = open("/dev", O_RDONLY, S_IXOTH);
	if (fd < 0)
	{
		_putstr(STDERR, "can't open /dev\n", NULL);
		return FALSE;
	}
	strcpy(buf, "/dev/");
	buf[sizeof(buf) - 1] = '\0';
	while (read(fd, &entry, sizeof(entry) - 1) == sizeof(entry) - 1)
	{
		entry.d_name[NAME_MAX] = '\0';
		strcpy(&buf[5], entry.d_name);
		if (stat(buf, &st) >= 0 && (mode = st.st_mode) != 0 && st.st_rdev == mdev)
		{
			if (cspec ? S_ISCHR(mode) : S_ISBLK(mode))
			{
				strcpy(s, entry.d_name);
				close(fd);
				return TRUE;
			}
		}
	}
	close(fd);
	return FALSE;
}
