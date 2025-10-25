#include "kern.h"
#include <sys/stat.h>
#include <sys/fio.h>


/*
 * lsize obtains the size of a file in bytes from the size0 and size1 fields
 * in the inode at pi. The inode is assumed to be in native byte order, such
 * as is returned as part of a stat (or fstat) system call.
 */
ULONG lsize(register struct inode *ino)
{
	return ((ULONG)ino->i_size0 << 16) | ino->i_size1;
}


struct inode *geti(DEV dev, INUM ino)
{
	(void)dev;
	(void)ino;
	return 0;
}


void getstat(register struct inode *ino, struct stat *st)
{
	register FINODE *f_ino;
	struct stat stbuf;
	register ULONG *t;
	
	f_ino = ireadb(ino->i_dev, ino->i_ino);
	t = &((FINODE *)iboff(f_ino, ino->i_ino))->n_actime; /* XXX different code */
	stbuf.st_atime = tflip(t[0]);
	stbuf.st_ctime = tflip(t[1]);
	stbuf.st_rdev = ino->i_mode & I_CHR ? ino->i_addr[0] : 0;
	stbuf._stU._stS._stS_c1 = 0;
	stbuf.st_size = lsize(ino);
	stbuf._stU._stS._stS_l2 = 0;
	stbuf._stU._stS._stS_l3 = 0;
	movbuf(&ino->i_dev, &stbuf.st_dev, /* FIXME: assumes these have same order and size */
		sizeof(stbuf.st_dev) +
		sizeof(stbuf.st_ino) +
		sizeof(stbuf.st_mode) +
		sizeof(stbuf.st_nlink) +
		sizeof(stbuf.st_uid) +
		sizeof(stbuf.st_gid) +
		sizeof(stbuf.st_size0) +
		sizeof(stbuf.st_size1));
	if (outbuf(&stbuf, st, sizeof(*st)) != 0)
		uerror(EFAULT);
	brelse(f_ino);
}


void *ireadb(DEV dev, INUM ino)
{
	(void)dev;
	(void)ino;
	return 0;
}


void brelse(void *buf)
{
	(void)buf;
}


void *iboff(void *buf, INUM ino)
{
	(void)ino;
	return buf;
}


struct fvar *mapfd(int fd)
{
	register struct fvar *f;
	register struct user *u = pu;

	if (fd >= 0 && fd < UFILES && (f = u->u_files[fd]) != NULL)
		return f;
	u->u_error = EBADF;
	return NULL;
}


void movbuf(const void *_src, void *_dst, BYTES _size)
{
	register const char *src = _src;
	register char *dst = _dst;
	register long size = _size;
	while (--size >= 0)
		*dst++ = *src++;
}
