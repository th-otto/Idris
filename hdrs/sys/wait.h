#ifndef __TYPES__
#include <sys/types.h>
#endif

/* If WIFEXITED(STATUS), the low-order 8 bits of the status.  */
#define	WEXITSTATUS(status)	(((status) & 0xff00) >> 8)

/* If WIFSIGNALED(STATUS), the terminating signal.  */
#define	WTERMSIG(status)	((status) & 0x7f)

/* If WIFSTOPPED(STATUS), the signal that stopped the child.  */
#define	WSTOPSIG(status)	WEXITSTATUS(status)

/* Nonzero if STATUS indicates normal termination.  */
#define	WIFEXITED(status)	(WTERMSIG(status) == 0)

/* Nonzero if STATUS indicates termination by a signal.  */
#define WIFSIGNALED(status) (((status) & 0xff) != 0)

/* Nonzero if STATUS indicates the child is stopped.  */
#define	WIFSTOPPED(status)	(((status) & 0xff) == 0x7f)

/* Nonzero if STATUS indicates the child dumped core.  */
#define	WCOREDUMP(status)	((status) & 0x80)

/* wait - wait for child to terminate */
pid_t wait(int *status);
