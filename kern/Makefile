OBJS = \
	a.o \
	device.o \
	uerror.o \
	fstat.o \
	inode.o \
	_sytimes.o \
	outbuf.o \
	fppdev.o \
	mddev.o \
	memdev.o \
	condev.o \
	serdev.o \
	lpdev.o \
	fddev.o \
	hddev.o \
	ptmdev.o \
	ptsdev.o \
	socdev.o \
	msgdev.o \
	seldev.o \
	swap.o \
	$(empty)

# does not work?
# CFLAGS = -I../hdrs/

LIBS  =	/lib/libc.68k /lib/libb.68k /lib/libm.68k

all: xidris

xidris: $(OBJS)
	link -mk -o$@ -max0xffffffff -pc999999 \
		+text -b0xa100 -m0xffffffff +data -m0xffffffff \
		$(OBJS) $(LIBS)

.s.o:
	$(CC) +o $<

a.o: a.s
	
clean:
	-rm *.o xidris
