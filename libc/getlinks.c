#include <stdlib.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>

struct dirarray {
	int (*cmp)(unsigned int e1, unsigned int e2, struct dirent *arr);
	void (*swap)(unsigned int e1, unsigned int e2, struct dirent *arr);
	struct dirent *base;
};



static void sortarray(register int left, register int right, register struct dirarray *array)
{
	register int scanleft;
	register int scanright;
	
	while (left < right)
	{
		scanleft = left - 1;
		scanright = right;
		while (scanleft < scanright)
		{
			while (++scanleft < scanright && array->cmp(scanleft, right, array->base) <= 0)
				;
			while (scanleft < --scanright && array->cmp(scanright, right, array->base) >= 0)
				;
			if (scanleft < scanright)
				array->swap(scanleft, scanright, array->base);
		}
		if (scanleft != right)
			array->swap(scanleft, right, array->base);
		if ((scanleft - left) < (right - scanleft))
		{
			sortarray(left, scanleft - 1, array);
			left = scanleft + 1;
		} else
		{
			sortarray(scanleft + 1, right, array);
			right = scanleft - 1;
		}
	}
}


static int cmp_dirent(unsigned int e1, unsigned int e2, struct dirent *arr)
{
	register struct dirent *p1;
	register struct dirent *p2;
	
	p1 = arr + e1;
	p2 = arr + e2;
	if (p1->d_ino == 0)
		return 1;
	if (p2->d_ino == 0)
		return -1;
	return memcmp(p1->d_name, p2->d_name, sizeof(p1->d_name) - 1);
}


static void convert_dir(register struct dirent *entries, register struct idir *dir, int count)
{
	register unsigned char *p;

	while (--count >= 0)
	{
		memcpy(entries, dir, sizeof(*dir));
		entries->d_name[sizeof(entries->d_name) - 1] = '\0';
		p = (unsigned char *)&dir->d_ino;
		entries->d_ino = (p[1] << 8) | p[0];
		entries++;
		dir++;
	}
}


static void swap_dirent(unsigned int e1, unsigned int e2, struct dirent *arr)
{
	struct dirent tmp;
	register struct dirent *p1;
	register struct dirent *p2;
	
	p1 = arr + e1;
	p2 = arr + e2;
	memcpy(&tmp, p1, sizeof(struct dirent));
	memcpy(p1, p2, sizeof(struct dirent));
	memcpy(p2, &tmp, sizeof(struct dirent));
}


struct dirent *_getlinks(const char *pathname, unsigned int *pnentries, long size)
{
	register unsigned int nentries;
	register int fd;
	register size_t allocsize;
	register struct dirent *entries;
	struct idir *dir;
	struct dirarray array;
	
	nentries = (size_t)size / sizeof(struct idir);
	allocsize = nentries * sizeof(*entries);
	entries = malloc(allocsize);
	if (entries == NULL)
		return NULL;
	dir = (struct idir *)((char *)entries + nentries * sizeof(*entries) - nentries * sizeof(*dir));
	fd = open(pathname, O_RDONLY, 0);
	if (fd < 0 || read(fd, dir, size) != size)
	{
		/* was bug in original code: leaks fd if read fails */
		if (fd >= 0)
			close(fd);
		*pnentries = 0;
		free(entries);
		return NULL;
	}
	convert_dir(entries, dir, nentries);
	array.cmp = cmp_dirent;
	array.swap = swap_dirent;
	array.base = entries;
	sortarray(0, nentries - 1, &array);
	for (*pnentries = 0; *pnentries < nentries; (*pnentries)++)
	{
		if (entries[*pnentries].d_ino == 0)
			break;
	}
	close(fd);
	return entries;
}
