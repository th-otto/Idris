CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

SYSINC := -I$(dir $(shell $(CC) -print-prog-name=cc1))/include

CFLAGS = -Os -fomit-frame-pointer \
	-I. -I../hdrs -nostdinc -fno-builtin $(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

LIBA_OBJS = \
	abort.o \
	a_astat.o \
	clock.o \
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
	perror.o \
	$(empty)

LIBB_OBJS = \
	abs.o \
	b_astat.o \
	b_cstat.o \
	brk.o \
	chdir.o \
	close.o \
	cmain.o \
	creat.o \
	dup.o \
	fabs.o \
	fork.o \
	fstat.o \
	getmod.o \
	getenv.o \
	_getenv.o \
	geteuid.o \
	getpid.o \
	getuid.o \
	gtty.o \
	kill.o \
	link.o \
	lseek.o \
	lstat.o \
	onintr.o \
	open.o \
	read.o \
	rawmode.o \
	remove.o \
	_remove.o \
	rename.o \
	_rename.o \
	sbreak.o \
	setuid.o \
	signal.o \
	sstat.o \
	stat.o \
	stty.o \
	system.o \
	time.o \
	times.o \
	uniqnm.o \
	unlink.o \
	wait.o \
	write.o \
	xeq.o \
	xecv.o \
	$(empty)

LIBC_OBJS = \
	c_cstat.o \
	decode.o \
	encode.o \
	fileno.o \
	lfree.o \
	malloc.o \
	usage.o \
	$(empty)

LIBPOSIX_OBJS = \
	access.o \
	alarm.o \
	chmod.o \
	chown.o \
	ctermid.o \
	cuserid.o \
	devname.o \
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

all: liba.68k libb.68k libc.68k libposix.68k Crts.o Crtf.o
# cannot be assembled by gas because of ~ in symbol names
# Crtp.o

liba.68k: $(LIBA_OBJS)
	rm -f $@
	$(AR) rcs $@ $(LIBA_OBJS)

libb.68k: $(LIBB_OBJS)
	rm -f $@
	$(AR) rcs $@ $(LIBB_OBJS)

libc.68k: $(LIBC_OBJS)
	rm -f $@
	$(AR) rcs $@ $(LIBC_OBJS)

libposix.68k: $(LIBPOSIX_OBJS)
	rm -f $@
	$(AR) rcs $@ $(LIBPOSIX_OBJS)

clean:
	rm -f *.o *.68k
