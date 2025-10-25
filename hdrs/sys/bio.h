/*	HEADER FOR BLOCKED I/O OPERATIONS
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#ifndef __BIO__
#define __BIO__ 1

/*	codes for b_flag
 */
#define B_ASYNC	0000001
#define B_BUSY	0000002
#define B_DIRTY	0000004
#define B_ERROR	0000010
#define B_READ	0000020
#define B_TAPE	0000040
#define B_VALID	0000100
#define B_WANT	0000200
#define B_CHR	0000400
#define B_CTRL	0001000
#define B_MAP	0002000
#define B_RESRC	0004000
#define B_NOCHK	0010000
#define B_BLK	0020000

struct buf {
	BUF *f_next;
	BUF *f_prev;
	BUF *b_next;
	BUF *b_prev;
	BITS b_flag;
	DEV b_dev;
	ULONG b_phys;
	ULONG b_sort;
	ULONG b_seek;
	TEXT *b_addr;
	BYTES b_count;
	BYTES b_resid;
	BLOCK b_blkno;
	};

/*	the device control table
 */
struct devtab {
	BUF *d_next;
	BUF *d_prev;
	BUF *b_next;
	BUF *b_prev;
	TINY d_stat;
	TINY d_nerr;
	};

#endif
