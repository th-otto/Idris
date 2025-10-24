#ifndef _SYS_SELECT_H
# define _SYS_SELECT_H 1

#ifndef __TIMEH__
#include <time.h>
#endif
#ifndef __SYS_TIME__
#ifndef __SOCKET__
#include <sys/time.h> /* for struct timeval */
#endif
#endif

/* It's easier to assume 8-bit bytes than to get CHAR_BIT.  */
#define __NFDBITS	(8 * (int) sizeof (fd_mask))
#define	__FDELT(d)	((d) / __NFDBITS)
#define	__FDMASK(d)	((fd_mask) 1 << ((d) % __NFDBITS))

typedef unsigned long int fd_mask;

/* Maximum number of file descriptors in `fd_set'.  */
#define	FD_SETSIZE		32

/* Representation of a set of file descriptors.  */
typedef struct
  {
    /* XPG4.2 requires this member name.  Otherwise avoid the name
       from the global namespace.  */
    fd_mask fds_bits[FD_SETSIZE / __NFDBITS];
# define __FDS_BITS(set) ((set)->fds_bits)
  } fd_set;

/* Access macros for `fd_set'.  */
#define FD_SET(d, s)     (__FDS_BITS(s)[__FDELT(d)] |= __FDMASK(d))
#define FD_CLR(d, s)     (__FDS_BITS(s)[__FDELT(d)] &= ~__FDMASK(d))
#define FD_ISSET(d, s)   ((__FDS_BITS(s)[__FDELT(d)] & __FDMASK(d)) != 0)
#if FD_SETSIZE <= 32
#define FD_ZERO(s) (__FDS_BITS(s)[0] = 0)
#else
#define FD_ZERO(s) memset((char *)(s), 0, sizeof(*(s)))
#endif

int select(int __nfds, fd_set *__readfds, fd_set *__writefds, fd_set *__exceptfds, struct timeval *__timeout);

#endif /* sys/select.h */
