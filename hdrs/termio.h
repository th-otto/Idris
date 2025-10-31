/*	TERMINAL I/O CONTROL
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __TERMIO__
#define __TERMIO__ 1

/*	index to c_cc
 */
#define	VINTR	0
#define	VQUIT	1
#define	VERASE	2
#define	VKILL	3
#define	VEOF	4
#define	VEOL	5
#define	VRESRV	6	/* black hole */
#define	VSWTCH	7
#define SWTCH	VSWTCH	/* SVID */
#define	VMIN	VEOF
#define	VTIME	VEOL
#define VSTART	VRESRV
#define VSTOP	VRESRV
#define VEOL2	VRESRV

#define	NCC	8

/*	character codes
 */
#define	CNUL	0
#define	CDEL	0377
#define	CESC	'\\'
#define	CINTR	0177
#define	CQUIT	034		/* CTL-\ */
#define	CERASE	'\b'
#define	CKILL	'\25'	/* CTL-U */
#define	CEOF	04		/* CTL-D */
#define	CSTART	021		/* CTL-S */
#define	CSTOP	023		/* CTL-Q */
#define	CSWTCH	032		/* CTL-Z */
#define	CNSWTCH	0
#define CALERT	007
#define CEOT	CEOF
#define CDELIM	CDEL
#define CGO		CSTART

/*	codes for c_iflag
 */
#define	IGNBRK	0000001
#define	BRKINT	0000002
#define	IGNPAR	0000004
#define	PARMRK	0000010
#define	INPCK	0000020
#define	ISTRIP	0000040
#define	INLCR	0000100
#define	IGNCR	0000200
#define	ICRNL	0000400
#define	IUCLC	0001000
#define	IXON	0002000
#define	IXANY	0004000
#define	IXOFF	0010000

/*	codes for c_oflag
 */
#define	OPOST	0000001
#define	OLCUC	0000002
#define	ONLCR	0000004
#define	OCRNL	0000010
#define	ONOCR	0000020
#define	ONLRET	0000040
#define	OFILL	0000100
#define	OFDEL	0000200
#define	NLDLY	0000400
#define	NL0	0
#define	NL1		0000400
#define	CRDLY	0003000
#define	CR0	0
#define	CR1		0001000
#define	CR2		0002000
#define	CR3		0003000
#define	TABDLY	0014000
#define	TAB0	0
#define	TAB1	0004000
#define	TAB2	0010000
#define	TAB3	0014000
#define	BSDLY	0020000
#define	BS0	0
#define	BS1		0020000
#define	VTDLY	0040000
#define	VT0	0
#define	VT1		0040000
#define	FFDLY	0100000
#define	FF0	0
#define	FF1		0100000

/*	codes for c_cflag
 */
#define	CBAUD	0000017
#define	B0		0000000
#define	B50		0000001
#define	B75		0000002
#define	B110	0000003
#define	B134	0000004
#define	B150	0000005
#define	B200	0000006
#define	B300	0000007
#define	B600	0000010
#define	B1200	0000011
#define	B1800	0000012
#define	B2400	0000013
#define	B4800	0000014
#define	B9600	0000015
#define	B19200	0000016
#define	B38400	0000017
#define	CSIZE	0000060
#define	CS5		0
#define	CS6		0000020
#define	CS7		0000040
#define	CS8		0000060
#define	CSTOPB	0000100
#define	CREAD	0000200
#define	PARENB	0000400
#define	PARODD	0001000
#define	HUPCL	0002000
#define	CLOCAL	0004000
#if 0	/* JOB CTL */
#define LOBLK	010000
#endif
#define EXTA	B19200
#define EXTB	B38400
#define CONTROL	(PARODD|PARENB|CSTOPB|CSIZE|CBAUD)

/*	codes for c_lflag
 */
#define	ISIG	0000001
#define	ICANON	0000002
#define	XCASE	0000004
#define	ECHO	0000010
#define	ECHOE	0000020
#define	ECHOK	0000040
#define	ECHONL	0000100
#define	NOFLSH	0000200

#define	SSPEED	9	/* default speed: 1200 baud */
#define	NBAUD	16

/*	ioctl data structure
 */
struct termio {
	unsigned short	c_iflag;	/* input modes */
	unsigned short	c_oflag;	/* output modes */
	unsigned short	c_cflag;	/* control modes */
	unsigned short	c_lflag;	/* line discipline modes */
	unsigned char	c_line;		/* line discipline */
	unsigned char	c_cc[NCC];	/* control chars */
};

/*	ioctl request codes
 */
#define	TCGETS	2
#define TCGETA	TCGETS
#define	TCSETS	3
#define TCSETA	TCSETS
#define	TCSETSW	4
#define TCSETAW	TCSETSW
#define	TCSETSF	5
#define TCSETAF	TCSETSF
#define	TCSBRK	6
#define	TCXONC	7
#define	TCFLSH	8
#define	TCDRAIN	9
#define TCEXCL	10
#define TCNXCL	11
#define TCNREAD	12
#define TCGETXY 13

/*	TCSTTY/TCGTTY struct/modes/flags
 */
#define TCSTTY	0
#define TCGTTY	1

/*	codes for t_mode
 */
#define M_RARE	0001
#define M_HUP	0001
#define M_XTABS	0002
#define M_LCASE	0004
#define M_ECHO	0010
#define M_CRMOD	0020
#define M_RAW	0040
#define M_ODDP	0100
#define M_EVENP	0200
#define M_NL1	000400
#define M_NL2	001000
#define M_NL3	001400
#define M_HT1	002000
#define M_HT2	004000
#define M_HT3	006000
#define M_CR1	010000
#define M_CR2	020000
#define M_CR3	030000
#define M_FF1	040000
#define M_BS1	0100000
#define M_EVEN	M_EVENP
#define M_ODD	M_ODDP
#define M_CRTLF	M_CRMOD

/*	masks for t_speeds
 */
#define	S_ISPEED	0x000f
#define S_IBREAK	0x0010
#define S_ILOST		0x0020
#define S_IMASK4	0x0040
#define S_IREADY	0x0080
#define S_OSPEED	0x0f00
#define S_OBREAK	0x1000
#define S_ONXON		0x2000
#define S_OMASK4	0x4000
#define S_OREADY	0x8000

struct sgtty {
	unsigned short t_speeds;
	char t_erase, t_kill;
	unsigned short t_mode;
};

#if 0	/* line discipline */

#define TCDSET	14
#define LDOPEN	15
#define LDCLOSE	16
#define LDCHG	17
#define LDGETT	18
#define LDSETT	19

#define TERM_NONE	0
#define TERM_TEC	1
#define TERM_V61	2
#define TERM_V10	3
#define TERM_TEX	4
#define TERM_D40	5
#define TERM_H45	6
#define TERM_D42	7

#define TM_NONE		0000
#define TM_SNL		0001
#define TM_ANL		0002
#define TM_LCF		0004
#define TM_CECHO	0010
#define TM_CINVIS	0020
#define TM_SET		0200

struct termcb {
	char st_flgs;
	char st_termt;
	char st_crow;
	char st_ccol;
	char st_vrow;
	char st_lrow;
};

#endif

int ioctl(int fd, int cmd, void *arg);
int gtty(int fd, struct sgtty *t);
int stty(int fd, struct sgtty *t);

#endif
