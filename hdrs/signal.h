/*	SIGNAL HANDLING
 *	copyright (c) 1985, 1987 by Whitesmiths, Ltd.
 */

#ifndef __SIGNAL__
#define __SIGNAL__	1

/*	set up default compiler version if none given
 */
#ifndef _CVERSION
#define _CVERSION	300
#endif

#if _CVERSION < 300
#define void char
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

int raise __((int sig));

/*
typedef unsigned int sig_atomic_t;
 */

/*	SIGNAL NUMBERS
 */
#define SIG_ERR		((void (*)())-1)	/* error */
#define SIG_DFL		(void (*)())0		/* default */
#define SIG_IGN		(void (*)())1		/* no signal */
#define SIGHUP		1		/* hangup */
#define SIGINT		2		/* interrupt */
#define SIGQUIT		3		/* quit */
#define SIGILL		4		/* Illegal instruction trap */
#define SIGTRAP		5		/* trace trap */
#define SIGIOT		6		/* IOT instruction */
#define SIGEMT		7		/* EMT instruction */
#define SIGFPE		8		/* floating point exception */
#define SIGKILL		9		/* kill */
#define SIGBUS		10		/* bus error */
#define SIGSEGV		11		/* memory management violation */
#define SIGSYS		12		/* bad argument to system call */
#define SIGPIPE		13		/* write on a pipe with no readers */
#define SIGALRM		14		/* alarm clock */
#define SIGTERM		15		/* software termination */
#define SIGUSR1		16		/* user defined signal 1 */
#define SIGUSR2		17		/* user defined signal 2 */
#define SIGABRT		SIGBUS	/* signal returned by abort() */
#define NSIG		19

/* old WSL signal names
 */
#define SIGILIN		SIGILL
#define SIGTRC		SIGTRAP
#define SIGRNG		SIGIOT	/* arithmatic range error */
#define SIGDOM		SIGEMT	/* arithmatic domain error */
#define SIGFPT		SIGFPE
#define SIGSEG		SIGSEGV
#define SIGSVC		SIGUSR1	/* system service trap */
#define SIGXXX		0xff	/* temporary signal inhibit */

/*	function declarations
 */
int kill __((int pid, int signo));
void (*signal __((int signo, void (*pfunc)(int sig))))(int sig);

#endif
