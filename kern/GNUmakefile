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


CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

SYSINC := -I$(shell $(CC) -print-prog-name=cc1)/../include

CFLAGS = -Os \
	-I. -I../hdrs -nostdinc -fno-builtin -I$(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Wundef -Werror
LDFLAGS = -nostdlib -nostartfiles

all: xidris

xidris: $(OBJS)
	$(CC) -o $@ $(LDFLAGS) $(OBJS)

$(OBJS): kern.h

clean:
	rm -f *.o xidris
