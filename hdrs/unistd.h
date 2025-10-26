/*  USR GROUP STANDARD CONSTANTS AND STRUCTURES
 *	copyright (c) 1985 by Whitesmiths, Ltd.
 */

#ifndef __UNISTD__
#define __UNISTD__ 1

#ifndef __TYPES__
#include <sys/types.h>
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

#ifndef __STDEFS__
#ifndef __STDLIB__
#ifndef __STRING__
typedef unsigned int size_t;
#endif
#endif
#endif

/* CONSTANTS FOR THE LOCKF FUNCTION
 */

#ifndef __LOCKF__
#define __LOCKF__ 1
/* constants for "access" function
 */
#define R_OK	4	/* Test for read permission */
#define W_OK	2	/* Test for write permission */
#define X_OK	1	/* Test for execute permission */
#define F_OK	0	/* Test for file exists */

/* constants for "lockf" 
 */
#define F_ULOCK	0	/* Unlock locked region */
#define F_LOCK	1	/* Lock a region for exclusive use */
#define F_TLOCK	2	/* Test and lock a region */
#define F_TEST	3	/* Test for locked region */

/*	lock types
 */
#define F_UNLCK		0
#define F_RDLCK		1
#define F_WRLCK		2

/*	file lock structure
 */
struct flock {
	unsigned int	l_sysid;
	unsigned int	l_proc;
	unsigned long	l_start;
	unsigned long	l_len;
	unsigned char	l_type;
	unsigned char	l_whence;
	short			l_pid;
};

#endif

#ifndef __STDIO__
/* constants for "lseek"
 */
#define SEEK_SET	0	/* Set file pointer to 'offset' */
#define SEEK_CUR	1	/* Set file pointer to current + 'offset' */
#define SEEK_END	2	/* Set file to EOF plus 'offset' */
#endif

#define BSEEK_SET	3	/* SEEK_SET with 'offset' as STD_BLK byte blocks */
#define BSEEK_CUR	4	/* SEEK_CUR with 'offset' as STD_BLK byte blocks */
#define BSEEK_END	5	/* SEEK_END with 'offset' as STD_BLK byte blocks */ 

/* Path names 
 */
#define GF_PATH		"/adm/passwd"		/* path of group file */
#define PF_PATH		"/adm/passwd"		/* path of password file */
#define IN_PATH		"/lib/hdrs/"		/* path of <...> files */

#define IEEE1003	"198601"

long write __((int fd, const void *buf, long count));
long read __((int fd, void *buf, long count));
unsigned int sleep __((unsigned int seconds));
int getdtablesize __((void));
int open __((const char *pathname, int flags, ...));
int creat __((const char *pathname, int mode));
int close __((int fd));
int link __((const char *path1, const char *path2));
off_t lseek __((int fd, off_t offset, int whence));
int unlink __((const char *pathname));
int chdir __((const char *path));
pid_t getpid __((void));
pid_t getppid __((void));
int access __((const char *pathname, int mode));
unsigned int alarm __((unsigned int seconds));
int chmod __((const char *pathname, mode_t mode));
int chown __((const char *pathname, uid_t owner, gid_t group));
int dup2 __((int oldfd, int newfd));
int execv __((const char *path, const char **args));
int execl __((const char *pathname, const char *arg, ...));
int execle __((const char *pathname, const char *arg, ... /*, NULL, char *const envp[] */));
int execlp __((const char *file, const char *arg, ...));
int execvp __((const char *file, const char *argv[]));
int execvpe __((const char *file, const char *argv[], const char *envp[]));
int execve __((const char *pathname, const char **args, const char **env));
char *getlogin __((void));
char *getcwd __((char *buf, size_t size));
pid_t getpgrp __((void));
int isatty __((int fd));
uid_t getuid __((void));
uid_t geteuid __((void));
gid_t getgid __((void));
gid_t getegid __((void));
int pause __((void));
int pipe __((int pipefd[2]));
int setpgrp __((void));

int _cwd __((char *tbuf));

#endif /* __UNISTD__ */
