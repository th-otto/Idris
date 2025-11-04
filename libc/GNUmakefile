CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar
ARFLAGS = rcs

SYSINC := -I$(dir $(shell $(CC) -print-prog-name=cc1))/include

CFLAGS = -Os -fomit-frame-pointer \
	-I. -I../hdrs -nostdinc -fno-builtin $(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

LIBA_OBJS = \
	abort.o \
	a_astat.o \
	asctime.o \
	atoi.o \
	atol.o \
	btoi.o \
	btol.o \
	btos.o \
	buybuf.o \
	calloc.o \
	clearerr.o \
	clock.o \
	ctime.o \
	free.o \
	frexp.o \
	fgetc.o \
	fgets.o \
	fopen.o \
	fputc.o \
	fputs.o \
	freopen.o \
	fseek.o \
	ftell.o \
	getc.o \
	getchar.o \
	isspace.o \
	isalnum.o \
	isalpha.o \
	iscntrl.o \
	isdigit.o \
	isgraph.o \
	islower.o \
	isprint.o \
	ispunct.o \
	isupper.o \
	isxdigit.o \
	putc.o \
	putchar.o \
	perror.o \
	feof.o \
	ferror.o \
	fflush.o \
	fread.o \
	fwrite.o \
	printf.o \
	fprintf.o \
	vprintf.o \
	vfprintf.o \
	sprintf.o \
	vsprintf.o \
	rewind.o \
	setbuf.o \
	scanf.o \
	sscanf.o \
	fscanf.o \
	vfscanf.o \
	vscanf.o \
	vsscanf.o \
	toupper.o \
	tolower.o \
	atan2.o \
	exp.o \
	fmod.o \
	raise.o \
	sin.o \
	cos.o \
	sqrt.o \
	$(empty)

LIBB_OBJS = \
	abs.o \
	b_astat.o \
	b_cstat.o \
	brk.o \
	chkio.o \
	chdir.o \
	close.o \
	cmain.o \
	cmpbuf.o \
	cpybuf.o \
	cpystr.o \
	creat.o \
	ctype.o \
	doclose.o \
	doread.o \
	dowrite.o \
	dup.o \
	error.o \
	fabs.o \
	fclose.o \
	filerr.o \
	_finit.o \
	fioerr.o \
	flush.o \
	fork.o \
	fstat.o \
	getmod.o \
	getenv.o \
	_getenv.o \
	geteuid.o \
	getpid.o \
	getuid.o \
	gtty.o \
	huge.o \
	kill.o \
	lenstr.o \
	link.o \
	lseek.o \
	lstat.o \
	onintr.o \
	onlist.o \
	open.o \
	parstype.o \
	pname.o \
	read.o \
	reaerr.o \
	rawmode.o \
	remove.o \
	_remove.o \
	rename.o \
	_rename.o \
	_round.o \
	sbreak.o \
	setuid.o \
	signal.o \
	sqr.o \
	sstat.o \
	stat.o \
	stty.o \
	syprof.o \
	system.o \
	_system.o \
	time.o \
	times.o \
	_tolower.o \
	_toupper.o \
	_trunc.o \
	uniqnm.o \
	unlink.o \
	unpack.o \
	ustat.o \
	va.o \
	wait.o \
	wrierr.o \
	write.o \
	xeq.o \
	xecv.o \
	$(empty)

LIBC_OBJS = \
	c_cstat.o \
	decode.o \
	encode.o \
	fileno.o \
	finit.o \
	getf.o \
	getfmt.o \
	getl.o \
	getlin.o \
	lfree.o \
	lower.o \
	malloc.o \
	putf.o \
	putfmt.o \
	usage.o \
	$(empty)

LIBPOSIX_OBJS = \
	access.o \
	alarm.o \
	chmod.o \
	chown.o \
	crypt.o \
	ctermid.o \
	cuserid.o \
	cwd.o \
	devname.o \
	dirent.o \
	dup2.o \
	execl.o \
	execle.o \
	execlp.o \
	execv.o \
	execve.o \
	execvp.o \
	fcntl.o \
	getcwd.o \
	getegid.o \
	getgid.o \
	getlinks.o \
	getlogin.o \
	getpass.o \
	getpgrp.o \
	getppid.o \
	ioctl.o \
	isatty.o \
	lockf.o \
	mkdir.o \
	mknod.o \
	pause.o \
	parent.o \
	pipe.o \
	pwdfil.o \
	rmdir.o \
	setgid.o \
	setpgrp.o \
	sleep.o \
	ttyname.o \
	umask.o \
	uname.o \
	utime.o \
	$(empty)

LIBM_OBJS = \
	range.o \
	domain.o \
	$(empty)

all: liba.68k libb.68k libc.68k libposix.68k libm.68k Crts.o Crtf.o Crtp.o

liba.68k: $(LIBA_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBA_OBJS)

libb.68k: $(LIBB_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBB_OBJS)

libc.68k: $(LIBC_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBC_OBJS)

libposix.68k: $(LIBPOSIX_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBPOSIX_OBJS)

libm.68k: $(LIBM_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBM_OBJS)

Crts.o: Crts.s
	cat $< | sed -e 's/^"/ .ascii "/' -e 's/a~/a./g' | $(AS) -c -o $@

Crtp.o: Crtp.s
	cat $< | sed -e 's/^"/ .ascii "/' -e 's/a~/a./g' | $(AS) -c -o $@

clean:
	$(RM) *.o *.68k
