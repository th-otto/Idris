/* ======================================================================= */
/*                               socket.h                                  */
/* ======================================================================= */

#ifndef __SOCKET__
#define __SOCKET__ 1

#ifndef __STDEFS__
#include <stddef.h>
#endif

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

/* ----------------------------------------------------------------------- */
/* changing these three constants requires recompiling drivers and main.c  */
/* ----------------------------------------------------------------------- */
#define NUM_SOC     32                   /* number of socket devices       */
#define NUM_SEL     32                   /* number of select devices       */
#define SBUF_SIZE  128                   /* size of socket buffer chunks   */

/* ----------------------------------------------------------------------- */
/* these must fit in 'COUNT' (16-bits)                                     */
/* ----------------------------------------------------------------------- */
#define BAS_IOCTL (        0x5a00)       /* base offset for ioctl commands */
#define SOC_IOCTL (BAS_IOCTL+0x00)       /* socket emulation ioctl         */
#define SEL_IOCTL (BAS_IOCTL+0x10)       /* select emulation ioctl         */
#define FIONREAD  (BAS_IOCTL+0x20)       /* FIONREAD ioctl command         */
#define PROC_FREE (BAS_IOCTL+0x30)       /* Detach a process               */
#define FIONBIO   (BAS_IOCTL+0x40)       /* set/clr non-blocking I/O       */

#define EWOULDBLOCK EAGAIN               /* map to 'IDRIS' error           */

#define SOC_BIND    0x239f5a51           /* socket bind    command         */
#define SOC_LISTEN  0x239f5a52           /* socket listen  command         */
#define SOC_CONNECT 0x239f5a53           /* socket connect command         */
#define SOC_ACCEPT  0x239f5a54           /* socket accept  command         */

/* ----------------------------------------------------------------------- */
/* ioctl interface to driver commands, used in drivers and library code    */
/* ----------------------------------------------------------------------- */

struct soc_req                        /* interface to socket commands      */
    {
    unsigned long command         ;   /* bind, listen, connect, accept     */
    unsigned long value           ;   /* connection address, listen count, */
    } ;                               /* connection fd, or return status   */

struct soc_buf                        /* socket data buffer structure */
    {
    struct soc_bufs *next         ;   /* data chain or free pointer        */
    unsigned short length         ;   /* length of data stored             */
    unsigned short offset         ;   /* offset for partial reads          */
    unsigned short flags          ;   /* flag to link contig bufs          */
    unsigned char  buf[SBUF_SIZE] ;   /* actual data                       */
    } ;

struct sel_buf                        /* ioctl interface to select command */
    {
    int max                       ;   /* max select bit for    descriptors */
    unsigned long  rd_msk         ;   /* select mask for read  descriptors */
    unsigned long  wr_msk         ;   /* select mask for write descriptors */
    unsigned long  ex_msk         ;
    unsigned long  timer          ;
    } ;

/* ------------------------------------------------------------------------ */
/* BSD emulation structures, some work but ones marked as 'DUMMY' are       */
/* only useful to help code compile, generally ok as long as 'AF_UNIX'      */
/* domain only is really used.                                              */
/* ------------------------------------------------------------------------ */

#ifdef _IDRIS
struct timeval { long  tv_sec   ; long tv_usec ; } ;   /* for 'select'      */
#else
#include <sys/time.h>
#endif
struct iovec   { char *iov_base ; int  iov_len ; } ;   /* 'writev', 'readv' */

#define AF_UNSPEC   0                                              /* DUMMY */
#define AF_IDRIS    1
#define AF_UNIX     AF_IDRIS
#define AF_INET     2                                              /* DUMMY */

#define SOCK_STREAM 1

struct sockaddr_un { short sun_family ; char sun_path[109] ; } ;
struct sockaddr    { short  sa_family ; char  sa_data[ 14] ; } ;  /* DUMMY */

struct in_addr                                                    /* DUMMY */
	{
	union
		{
		struct { unsigned char  s_b1, s_b2, s_b3, s_b4 ; } S_un_b ;
		struct { unsigned short s_w1, s_w2             ; } S_un_w ;
		unsigned long S_addr ;
		} S_un ;
	} ;

struct sockaddr_in                                                /* DUMMY */
    {
    short          sin_family  ;
    unsigned short sin_port    ;
	struct in_addr sin_addr    ;
	char           sin_zero[8] ;
    } ;

struct hostent                                                    /* DUMMY */
    {
    char  *h_name      ;
    char **h_aliases   ;
    int    h_addrtype  ;
    int    h_length    ;
    char **h_addr_list ;
    } ;

#define h_addr h_addr_list[0]                                     /* DUMMY */

int ioctl(int fd, int cmd, void *arg);

struct hostent *gethostbyname(const char *name);                                 /* DUMMY */

typedef int socklen_t;

ARGINT readv(int fd, const struct iovec *iov, int iovcnt);
ARGINT writev(int fd, const struct iovec *iov, int iovcnt);
int socket(int domain, int type, int protocol);
int bind(int socket, const struct sockaddr *address, socklen_t address_len);
int listen(int socket, int backlog);
int connect(int socket, const struct sockaddr *address, socklen_t address_len);
int accept(int socket, struct sockaddr *address, socklen_t *address_len);

long Recv_Message(int fd, void *buf, long count);
long Send_Message(int fd, const void *buf, long count);
int Close_Message(int fd);
long _XFIONREAD(int fd);

int gethostname(char *name, size_t len);
int getpeername(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
int setsockopt(int sockfd, int level, int optname, const void *optval, socklen_t optlen);
unsigned short htons(unsigned short hostshort);
unsigned long htonl(unsigned long hostlong);

#define htons(x) x
#define htonl(x) x

/* ======================================================================= */
/*                               Module End                                */
/* ======================================================================= */

#endif  /* __SOCKET__ */
