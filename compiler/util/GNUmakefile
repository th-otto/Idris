#
#	Makefile for Whitesmiths utilities
#

#CROSS=m68k-atari-mint-
CC = $(CROSS)gcc
AR = $(CROSS)ar


CFLAGS = -Os -fomit-frame-pointer \
	-I. -I../ihdrs -D_PROTO=1 \
	-Wstrict-prototypes -Wmissing-prototypes -Wall -W -Werror
LDFLAGS =

# Commands
CMDS = hex lib lord rel

all: $(CMDS)

HEXOBJ = hex.o util.o getflags.o

hex: $(HEXOBJ)
	$(CC) $(CFLAGS) -o $@ $(HEXOBJ) $(LDFLAGS)

LIBOBJ = lib.o util.o getflags.o getin.o

lib: $(LIBOBJ)
	$(CC) $(CFLAGS) -o $@ $(LIBOBJ) $(LDFLAGS)

LORDOBJ = lord.o util.o getflags.o

lord: $(LORDOBJ)
	$(CC) $(CFLAGS) -o $@ $(LORDOBJ) $(LDFLAGS)

RELOBJ = rel.o util.o getflags.o getin.o

rel: $(RELOBJ)
	$(CC) $(CFLAGS) -o $@ $(RELOBJ) $(LDFLAGS)

clean:
	$(RM) $(CMDS) *.o
