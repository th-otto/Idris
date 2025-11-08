CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AS = $(CROSS)as
AR = $(CROSS)ar

SYSINC := -I$(dir $(shell $(CC) -print-prog-name=cc1))/include

CFLAGS = -Os -fomit-frame-pointer \
	-I. -I../hdrs -nostdinc -fno-builtin $(SYSINC) -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror

TOOLS = \
	show0 \
	ps \
	false \
	true \
	$(empty)

all: $(TOOLS)

readclock: readclock.o xbios.o
	$(CC) -o$@ readclock.o xbios.o

date: date.o
	$(CC) -o$@ date.o

settime: settime.o
	$(CC) -o$@ settime.o

show0: show0.o
	$(CC) -o$@ show0.o

ps: ps.o
	$(CC) -o$@ ps.o

false: false.o
	$(CC) -o$@ false.o

true: true.o
	$(CC) -o$@ true.o

xbios.o: xbios.s
	$(CC) +o xbios.s

clean:
	rm *.o $(TOOLS)
