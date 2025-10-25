/*	STANDARD I/O HEADER
 *	copyright (c) 1984, 1987 by Whitesmiths, Ltd.
 */

#ifndef __STDIO__
#define __STDIO__	1

/*	set up prototyping
 */
#ifndef __
#ifdef _PROTO
#define __(a)	a
#else
#define __(a)	()
#endif
#endif

/*	set up types not already set up
 */
#ifndef __STDARG__
#include <stdarg.h>
#endif
#ifndef __STDEFS__
#ifndef __STDLIB__
#ifndef __STRING__
typedef unsigned int size_t;
#endif
#endif
#endif

/*	the FILE structure
 */
typedef struct _file
{
	struct _file *flist;	/* chain used to flush buffers */
	short fd;				/* file descriptor */
	unsigned short flag;	/* flag bits */
	int nleft;				/* reading, # of chars undelivered in buffer */
							/* writing, # of chars put in buffer to output */
	int bufsize;			/* size of buffer (default BUFSIZ) */
	long loff;				/* addr used by ftell (text files - read only) */
	unsigned char *pnext;	/* ptr to next char to deliver */
	unsigned char *buf;		/* ptr to allocated buffer */
} FILE;

/*	function declarations
 */
FILE *fopen __((const char *pathname, const char *type));
FILE *freopen __((const char *pathname, const char *type, FILE *stream));
FILE *tmpfile __((void));
char *fgets __((char *s, int n, FILE *stream));
char *gets __((char *s));
char *perror __((const char *s));
char *tmpnam __((char *s));
int fclose __((FILE *stream));
int feof __((FILE *stream));
int ferror __((FILE *stream));
int fflush __((FILE *stream));
int fgetc __((FILE *stream));
int fprintf __((FILE *stream, const char *format, ...));
int fputc __((int c, FILE *stream));
int fputs __((const char *s, FILE *stream));
int fread __((void *ptr, size_t size, int nelem, FILE *stream));
int fscanf __((FILE *stream, const char *format, ...));
int fseek __((FILE *stream, long offset, int ptrname));
int fwrite __((const void *ptr, size_t size, int nelem, FILE *stream));
int printf __((const char *format, ...));
int puts __((const char *s));
int remove __((const char *s));
int rename __((const char *old, const char *new));
int scanf __((const char *format, ...));
int setvbuf __((FILE *stream, char *buf, int type, int size));
int sprintf __((char *s, const char *format, ...));
int sscanf __((char *s, const char *format, ...));
int ungetc __((int c, FILE *stream));
int vfprintf __((FILE *stream, const char *format, va_list arg));
int vprintf __((const char *format, va_list arg));
int vsprintf __((char *s, const char *format, va_list arg));
long ftell __((FILE *stream));
void clearerr __((FILE *stream));
void rewind __((FILE *stream));
void setbuf __((FILE *stream, char *buf));

/*	include system dependent information
 */
#ifdef _OS
#include _OS
#else
#define _CASES		2
#define _CLKTICK	60
#define _EXLEN		127
#define _MAXFILE	20
#define _SLLEN		511
#define _TMPMAX		25
#define _TMPSIZ		14
#define	FCHR_MAX	16777215	/* 2^25 - 1 */
#define	CHILD_MAX	32767
#define	LOCK_MAX	200
#define	LINK_MAX	255
#define	LONG_BIT	32
#define	NAME_MAX	14
#define	PASS_MAX	8
#define	PID_MAX		32767
#define	PATH_MAX	255
#define	PIPE_BUF	512
#define	PIPE_MAX	4096
#define	PROC_MAX	32767
#define	STD_BLK		512

#define OPEN_MAX    _MAXFILE
#endif

char *ctermid __((char *s));
char *cuserid __((char *s));
FILE *fdopen __((int fd, const char *type));
int fileno __((FILE *pf));

#if 0
int getw __((FILE *pf));
int pclose __((FILE *pf));
FILE *popen __((const char *cmd, const char *type));
int putw __((int word, FILE *pf));
char *tempnam __((const char *dir, const char *prefix));
#endif

/*	global variable references
 */
extern FILE *stderr;
extern FILE *stdin;
extern FILE *stdout;

/*	system parameters
 */
#define _IOFBF		1
#define _IOLBF		2
#define _IONBF		3
#define BUFSIZ 		512
#define EOF		 	-1
#define L_tmpnam	_TMPSIZ
#ifdef _IDRIS
#define L_ctermid	10
#define L_cuserid	20
#define P_tmpdir	"/tmp/"
#endif
#ifndef __UNISTD__
#define SEEK_SET	0
#define	SEEK_CUR	1
#define SEEK_END	2
#endif
#define SYS_OPEN	_MAXFILE
#define TMP_MAX		_TMPMAX

/*	flag values used in getc and putc (020 and 040) should track values in
 *	READING and WRITING respectively in stioli.h
 */

/*	macros
 */
#ifndef NULL
#define NULL (void *)0
#endif
#define getc(pf)	(((pf)->flag & 020 && 0 < (pf)->nleft) ? \
					(--(pf)->nleft, *(pf)->pnext++) : fgetc(pf))
#define getchar()	(getc(stdin))
#define putc(c, pf)	(((pf)->flag & 040 && (c) != '\n' && \
					(pf)->nleft < (pf)->bufsize) ? \
					((pf)->buf[(pf)->nleft++] = (c)) : fputc(c, pf))
#define putchar(c)	(putc(c, stdout))

#endif
