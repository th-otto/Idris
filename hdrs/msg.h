/*	HEADER FOR USER INTERFACE TO MESSAGE SYSTEM
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

/*	ms error codes
 */
#define MEBADEV		1000
#define MEBADCH		1001
#define MEMAXCON	1002
#define MEMAXPROC	1003
#define MEHEAP		1004
#define MEXIST		1005
#define MEBADPRM	1006
#define MENORX		1007
#define MENOMSYS	1008
#define MESFAIL		1009
#define MENOBUFS	1010
#define MENOQ		1011

/*	ms status bits
 */
#define	MST_REM	0x1
#define	MST_RDY	0x2

/*	ms flag bits
 */
#define MSF_CREATE	0x01
#define MSF_CLOSING	0x02
#define MSF_TIMING	0x04
#define MSF_WHEAP	0x08
#define MSF_WBUFS	0x10

/*	function codes for mgetprm(), msetprm()
 */
#define	MP_MAXPROC	1
#define MP_MAXTIMER	2
#define	MP_MAXCON	3
#define	MP_MAXQUE	4
#define	MP_STATUS	5
#define	MP_MGETPRM	6

/*	function bits for msend(), mreceive()
 */
#define MSG_WAIT   0x01
#define MSG_TEST   0x02
#define MSG_COPY   0x04
#define MSG_KEEP   0x08
#define MSG_SELECT 0x10
#define MSG_SENT   0x20

/*	status bits for mreceive()
 */
#define	MP_LOST	0x01
#define	MT_LOST 0x02
#define ME_LOST 0x04
#define MH_LOST 0x08
#define MQ_LOST 0x10

/*	function codes and flags for evmon()
 */
#define EV_DMON     0x00
#define EV_ALL	    0x01
#define EV_SOME     0x02
#define EV_ONE	    0x03
#define EV_YES	    0x04
#define EV_NAND     0x05
#define EV_NOR	    0x06
#define EV_NJONE    0x07
#define EV_TYPE     0x07
#define EV_INIT	    0x08
#define EV_POST	    0x10
#define EV_NOTEST	0x20
#define EV_ONESHOT	0x40

/*	function codes for stty svc's
 */
#define	MS_MCLOSE	0
#define	MS_MCREATE	1
#define	MS_MCONNECT	2
#define	MS_MDISCON	3
#define	MS_MFREE	4
#define	MS_MGETBUF	5
#define	MS_MGETPRM	6
#define	MS_MOPEN	7
#define	MS_MRECEIVE 8
#define	MS_MRELBUF	9
#define	MS_MREMOVE	10
#define	MS_MSEND	11
#define	MS_MSETPRM	12
#define	MS_MTIMER	13
#define	MS_EVCLR	14
#define	MS_EVGET	15
#define	MS_EVMON	16
#define	MS_EVSET	17

/*	stty svc
 */
typedef struct {
	UCOUNT	msi_fc;
	BYTES	*msi_pa;
} MSI;

/*	mreceive buffer
 */
typedef struct {
	BYTES mr_chan;
	BYTES mr_size;
	TEXT *mr_buf;
} MRBUF;

/*	evmon buffer
 */
typedef struct {
	COUNT eb_ed;
	BITS eb_mask, eb_mode, eb_init;
	COUNT eb_mchan;
} EVBUF;

typedef struct {
	BYTES sd_size;
	BYTES sd_start;
	TEXT *sd_buf;
} SDSTAT;

/*
 * system calls
 */
int mgetprm(int fd, int mode);
int msetprm(int fd, int mode);
int _mcreat(int fd, int arg1, int arg2, int arg3);
int _mrm(int fd);
int clrsl(int, int);
int tsetsl(int, int);

/*
 * library functions
 */
int sdclose(int fd);
int sdmap(int fd);
int sdopen(const char *filename);
BYTES sdsize(int fd);
int sdstat(int fd, SDSTAT *stat);
size_t sdstart(int fd);
int sdpalloc(const char *filename, size_t start, size_t size);
int sdcreate(const char *filename, const char *control, size_t o16, size_t size);
int sdremove(const char *filename);

int mopen(const char *filename);
int mcreate(const char *filename, int arg1, int arg2, int arg3);
