#include <std.h>
#include <signal.h>
#include <termio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <limits.h>

/*
 * getpass - get a password
 */
static unsigned short save_t_mode;
static struct sgtty tty;
static void (*old_sigint)(int);
static void (*old_sigpipe)(int);
static void (*old_sigquit)(int);
static char passbuf[PASS_MAX];


static void sigint(int sig)
{
	(void)sig;
	tty.t_mode = save_t_mode;
	stty(STDIN, &tty);
	exit(0);
}


char *getpass(const char *prompt)
{
	register char *ptr;
	register int len;
	char c;

	/*
	 * FIXME: should read from /dev/tty, not stdin
	 */	
	ptr = passbuf;
	if (gtty(STDIN, &tty) < 0)
	{
		save_t_mode = tty.t_mode;
	} else
	{
		save_t_mode = tty.t_mode;
		tty.t_mode &= ~M_ECHO;
		old_sigint = signal(SIGINT, sigint);
		old_sigpipe = signal(SIGPIPE, SIG_IGN);
		old_sigquit = signal(SIGQUIT, SIG_IGN);
		stty(STDIN, &tty);
		write(STDERR, prompt, strlen(prompt));
	}
	len = 0;
	while (read(STDIN, &c, 1) == 1 && c != '\n')
	{
		if (len < PASS_MAX)
			ptr[len++] = c;
	}
	if (save_t_mode != tty.t_mode)
	{
		write(STDERR, "\n", 1);
		tty.t_mode = save_t_mode;
		stty(STDIN, &tty);
		/* BUG: does not restore signals if echo was already off */
		signal(SIGINT, old_sigint);
		signal(SIGPIPE, old_sigpipe);
		signal(SIGQUIT, old_sigquit);
	}
	while (len < PASS_MAX)
		ptr[len++] = '\0';
	return ptr;
}
