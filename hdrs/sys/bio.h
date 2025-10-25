/*	HEADER FOR BLOCKED I/O OPERATIONS
 *	copyright (c) 1979 by Whitesmiths, Ltd.
 */
#ifndef __BIO__
#define __BIO__ 1

/*	codes for b_flag
 */
#define B_ASYNC	0x0001
#define B_BUSY	0x0002
#define B_DIRTY	0x0004
#define B_ERROR 0x0008
#define B_READ	0x0010
#define B_TAPE	0x0020
#define B_VALID	0x0040
#define B_WANT	0x0080
#define B_CHR	0x0100
#define B_CTRL	0x0200
#define B_MAP	0x0400
#define B_RESRC	0x0800
#define B_NOCHK	0x1000
#define B_BLK	0x2000

struct buf {
	/*  0 */ BUF *f_next;
	/*  4 */ BUF *f_prev;
	/*  8 */ BUF *b_next;
	/* 12 */ BUF *b_prev;
	/* 16 */ BITS b_flag;
	/* 18 */ DEV b_dev;
	/* 20 */ ULONG b_phys;
	/* 24 */ ULONG b_sort;
	/* 28 */ ULONG b_seek;
	/* 32 */ TEXT *b_addr;
	/* 36 */ BYTES b_count;
	/* 38 */ BYTES b_resid;
	/* 40 */ BLOCK b_blkno;
	/* 42 */
};

/*	the device control table
 */
struct devtab {
	/*  0 */ BUF *d_next;
	/*  4 */ BUF *d_prev;
	/*  8 */ BUF *b_next;
	/* 12 */ BUF *b_prev;
	/* 16 */ TINY d_stat;
	/* 17 */ TINY d_nerr;
	/* 18 */
};

#endif
