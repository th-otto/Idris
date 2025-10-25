/*	HEADER FOR CHARACTER I/O OPERATIONS
 *	copyright (c) 1979, 1986 by Whitesmiths, Ltd.
 */

#ifndef __CIO__
#define __CIO__ 1

/*	codes for t_stat
 */
#define T_BUSY	0001
#define T_CARR	0002
#define T_ESC	0004
#define T_OPEN	0010
#define T_STOP	0020
#define T_TIMER	0040
#define T_WCLOS	0100
#define T_WOPEN	0200
#define T_IWANT 0400
#define T_OWANT 01000
#define T_INIT	02000

/*	the character buffer structure
 */
#define CLIST	struct clist
struct clist {
	CLIST *c_next;
	TEXT c_info[16 - sizeof (BYTES)];
	};

/*	the character queue structure
 */
#define CHQ	struct chq
struct chq {
	UCOUNT c_num;
	TEXT *c_first;
	TEXT *c_last;
	};

/*	the tty control structure
 */
#define TTY		struct tty
struct tty {
	BITS t_speeds;	/* returned by stty */
	TEXT t_erase;	/* returned by stty */
	TEXT t_kill;	/* returned by stty */
	BITS t_flag;	/* returned by stty */
	UTINY t_min;
	UTINY t_time;
	BITS t_cflag;
	TEXT t_intr;
	UTINY t_tmo;
	BITS t_stat;
	CHQ t_rawq;
	CHQ t_outq;
	TTY *t_rdlist;
	VOID (*t_go)();
	DEV t_dev;
	COUNT t_ndel;
	COUNT t_col;
	COUNT t_prevcol;
	COUNT t_open;
	COUNT t_nin;
	UTINY t_brktim;
	};

#endif
