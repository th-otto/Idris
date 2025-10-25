LIBA_OBJS = \
	clock.o \
	perror.o \
	abort.o \
	$(empty)

LIBB_OBJS = \
	times.o \
	$(empty)

CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

SYSINC := -I$(dir $(shell $(CC) -print-prog-name=cc1))/include

CFLAGS = -Os \
	-I. -I../hdrs -nostdinc -fno-builtin $(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

all: liba.68k libb.68k

liba.68k: $(LIBA_OBJS)
	rm -f $@
	$(AR) rcs $@ $(OBJS)

libb.68k: $(LIBB_OBJS)
	rm -f $@
	$(AR) rcs $@ $(OBJS)

clean:
	rm -f *.o *.68k
