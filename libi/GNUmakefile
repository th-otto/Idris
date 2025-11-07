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
	_mcreat.o \
	mdiscon.o \
	mfree.o \
	mgetbuf.o \
	mgetprm.o \
	mount.o \
	mreceive.o \
	mrelbuf.o \
	_mrm.o \
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
	\
	asure.o \
	baud.o \
	bsearch.o \
	cpyi.o \
	create.o \
	cwd.o \
	clrbuf.o \
	dir.o \
	_defenv.o \
	devname.o \
	ename.o \
	getblk.o \
	getlinks.o \
	inblk.o \
	inode.o \
	ioff.o \
	isdir.o \
	lsize.o \
	logname.o \
	parent.o \
	perm.o \
	putblk.o \
	qsort.o \
	putenv.o \
	setenv.o \
	\
	sdclose.o \
	sdcreate.o \
	sdpalloc.o \
	sdmap.o \
	sdopen.o \
	sdsize.o \
	sdstat.o \
	sdstart.o \
	sdremove.o \
	mcreate.o \
	mopen.o \
	mesg.o \
	$(empty)

all: libi.68k

libi.68k: $(LIBI_OBJS)
	$(RM) $@
	$(AR) $(ARFLAGS) $@ $(LIBI_OBJS)

clean:
	$(RM) *.o *.68k
