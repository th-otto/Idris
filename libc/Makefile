CC = cdriver -proto c.proto +o -v -dnostrict -dlincl -prefix ./
AS = as.68k
AR = lib

LIBA_OBJS = \
	clock.o \
	perror.o \
	abort.o \
	$(empty)

LIBB_OBJS = \
	times.o \
	$(empty)

LIBC_OBJS = \
	fileno.o \
	$(empty)

LIBPOSIX_OBJS = \
	access.o \
	alarm.o \
	chmod.o \
	chown.o \
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
	getpgrp.o \
	getppid.o \
	ioctl.o \
	isatty.o \
	mkdir.o \
	mknod.o \
	pause.o \
	pipe.o \
	setgid.o \
	setpgrp.o \
	sleep.o \
	umask.o \
	$(empty)

all: liba.68k libb.68k libc.68k libposix.68k Crts.o Crtf.o Crtp.o

liba.68k: $(LIBA_OBJS)
	-rm $@
	$(AR) -c $@ $(LIBA_OBJS)

libb.68k: $(LIBB_OBJS)
	-rm $@
	$(AR) -c $@ $(LIBB_OBJS)

libc.68k: $(LIBC_OBJS)
	-rm $@
	$(AR) -c $@ $(LIBC_OBJS)

libposix.68k: $(LIBPOSIX_OBJS)
	rm -f $@
	$(AR) -c $@ $(LIBPOSIX_OBJS)

.s.o:
	$(AS) -o $@ $<

clean:
	rm *.o *.68k
