CC = cdriver -proto c.proto +o -v -dnostrict -dlincl -prefix ./
AS = as.68k
AR = lib
ARFLAGS = -c
RM = -rm

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

.s.o:
	$(AS) -o $@ $<

clean:
	$(RM) *.o *.68k
