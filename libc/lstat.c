#include <std.h>
#include <stdio.h>
#include <time.h>
#include "libc.h"

char _savtime[] = "EDT";
char _stdtime[] = "EST";
char _zone[] = "TZ";
char *_edt = _savtime;
char *_est = _stdtime;

char _rbuf[18];
FILE _stdout;
FILE _stdin;
FILE _stderr;
int _tfile;
int _fnext;
FILE *_pfile;
void *_stop;
const char *_ranerr;
const char *_memerr;
const char *_domerr;
size_t _htop;
size_t _heap;
size_t _hbot;
size_t _hinf[3];
size_t _hunk;
int _tzmins;
long _timezone;
int _tzinit;
int _dst;


void _lstat(void)
{
	_timezone = 5;
	_dst = 1;
	_domerr = "domain error";
	_memerr = "no memory";
	_ranerr = "range error";
	_stop = (void *)1;
	_pfile = &_stdout;

	_stderr.flist = NULL;
	_stderr.fd = STDERR;
	_stderr.flag = 0x208; /* FIXME */
	_stderr.nleft = 0;
	_stderr.bufsize = BUFSIZ;
	_stderr.loff = 0;
	_stderr.pnext = NULL;
	_stderr.buf = NULL;

	_stdin.flist = NULL;
	_stdin.fd = STDIN;
	_stdin.flag = 0x0004; /* FIXME */
	_stdin.nleft = 0;
	_stdin.bufsize = BUFSIZ;
	_stdin.loff = 0;
	_stdin.pnext = NULL;
	_stdin.buf = NULL;

	_stdout.flist = NULL;
	_stdout.fd = STDOUT;
	_stdout.flag = 0x0008; /* FIXME */
	_stdout.nleft = 0;
	_stdout.bufsize = BUFSIZ;
	_stdout.loff = 0;
	_stdout.pnext = NULL;
	_stdout.buf = NULL;
}
