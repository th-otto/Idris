OBJS = \
	flop.o \
	ioatari.o \
	$(empty)


CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

CFLAGS = -Os \
	-I. -I../hdrs -nostdinc -fno-builtin -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

all: cboot

cboot: $(OBJS)
	@:

clean:
	rm -f *.o cboot
