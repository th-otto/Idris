LIBA_OBJS = \
	clock.o \
	$(empty)

LIBB_OBJS = \
	times.o \
	$(empty)

CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
Ar = $(CROSS)ar

CFLAGS = -Os \
	-I. -I../linux -nostdinc -fno-builtin -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

all: liba.68k libb.68k

liba.68k: $(LIBA_OBJS)
	rm -f $@
	ar rcs $@ $(OBJS)

libb.68k: $(LIBB_OBJS)
	rm -f $@
	ar rcs $@ $(OBJS)

clean:
	rm -f *.o *.68k
