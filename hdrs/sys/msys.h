/*	HEADER FOR MESSAGE SYSTEM
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */
#include <alloc.h>

/*	misc defs
 */
#define	NOLIMIT	(-1)
#define	DGRAN	16
#define PMSG	1		/* priority for sleeping */
#define NOMSG	0		/* channel 0 */
#define ECHAN	(-1)	/* dummy event channel */
#define TTIME	34133

/*	message system data structures
 */
typedef struct chan CHAN;
typedef struct emon EMON;
typedef struct event EVENT;
typedef struct mbmap MBMAP;
typedef struct mcon MCON;
typedef struct mproc MPROC;
typedef struct msg MSG;
typedef struct msgd MSGD;
typedef struct msghdr MSGHDR;
typedef struct mstat MSTAT;
typedef struct snwait SNWAIT;
typedef struct tcon TCON;

/*	channel header
 */
struct chan {
	MCON *ch_mcon;
	struct proc *ch_wlist;
};

/*	monitor per event per channel
 */
struct emon {
	EMON *em_next;
	COUNT em_chan;
	BITS em_mask;
	BITS em_mode;
};

/*	event header
 */
struct event {
	EMON *ev_emon;
	BITS ev_word;
};

/*	memory buffer controller
 */
struct mbmap {
	MBMAP *mb_next;
	PHYS mb_phys;
	BYTES mb_size;
	PID mb_pid;
};

/*	connection controller per mproc per channel
 */
struct mcon {
	MCON *mc_next;
	MPROC *mc_mproc;
	UCOUNT mc_nmsg;
	UCOUNT mc_maxmsg;
	COUNT mc_chan;
};

/*	message list head per receiving process
 */
struct mproc {
	MPROC *mp_next;
	MSG *mp_top;
	MSG *mp_bot;
	struct proc *mp_wlist;
	PID mp_pid;
	UCOUNT mp_conref;
	TINY mp_stat;
	TBOOL mp_sleep;
};

/*	message controller
 */
struct msg {
	MSG *ms_next;
	SNWAIT *ms_pw;
	BYTES ms_buf;
	BYTES ms_size;
	MCON *ms_mcon;
};

/*	message system controller per msg device
 */
struct msgd {
	COUNT msg_open;
	MSGHDR *msg_base;
};

/*	message system header
 */
struct msghdr {
	MSGHDR **mh_hdr;
	BYTES mh_mheap;
	BYTES mh_msize;
	MBMAP *mh_mblist;
	MPROC *mh_plist;
	struct proc *mh_wlist;
	BYTES mh_gran;
	CHAN *mh_chantab;
	EVENT *mh_evtab;
	HEAPCTL mh_heap;
	ONUNIT mh_timercb;
	UCOUNT mh_curcon;
	UCOUNT mh_maxcon;
	UCOUNT mh_curproc;
	UCOUNT mh_maxproc;
	UCOUNT mh_state;
	UCOUNT mh_nchan;
	UCOUNT mh_maxtimer;
	UCOUNT mh_nevent;
	UCOUNT mh_maxque;
	BITS mh_flags;
};

/*	header for msgread()
 */
struct mstat {
	BYTES mstat_ptr;
	BYTES mstat_size;
	BYTES mstat_vers;
	BYTES mstat_open;
	BYTES mstat_total;
};

/*	resgistration per sending process waiting
 */
struct snwait {
	struct proc *sw_wlist;
	UCOUNT sw_ref;
};

/*	timer registration per channel (pointed to by onunit)
 */
struct tcon {
	TCON *tc_next;
	LONG tc_count;
	LONG tc_freq;
	COUNT tc_chan;
};
