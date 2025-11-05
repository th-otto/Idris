CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar
ARFLAGS = rcs

SYSINC := -I$(dir $(shell $(CC) -print-prog-name=cc1))/include

CFLAGS = -Os -fomit-frame-pointer \
	-I. -I../hdrs -nostdinc -fno-builtin $(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

LIBI_OBJS = \
	chroot.o \
	clrsl.o \
	clrul.o \
	evclr.o \
	evget.o \
	evmon.o \
	evset.o \
	getcsw.o \
	getnpid.o \
	getsl.o \
	getul.o \
	mclose.o \
	mconnect.o \
	mcreat.o \
	mdiscon.o \
	mfree.o \
	mgetbuf.o \
	mgetprm.o \
	mount.o \
	mreceive.o \
	mrelbuf.o \
	mrm.o \
	msend.o \
	msetprm.o \
	mtimer.o \
	nice.o \
	pstat.o \
	pcntl.o \
	stime.o \
	sync.o \
	tsetsl.o \
	tsetul.o \
	umount.o \
	usrcall.o \
	xecl.o \
	xecv.o \
	$(empty)

all: libi.68k

libi.68k: $(LIBI_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBI_OBJS)

clean:
	$(RM) *.o *.68k
