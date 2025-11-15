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
CMDS = p1 p1pr

all: $(CMDS)

P1OBJ = p1data.o p1expr.o p1func.o p1gets.o p1main.o p1puts.o p1red.o p1subs.o p1type.o util.o getflags.o
P1PROBJ = p2pgcode.o p2pgexpr.o p2pgtbod.o p2pmain.o p2pops.o p2subs.o util.o getflags.o

p1: $(P1OBJ)
	$(CC) $(CFLAGS) -o $@ $(P1OBJ) $(LDFLAGS)

p1pr: $(P1PROBJ)
	$(CC) $(CFLAGS) -o $@ $(P1PROBJ) $(LDFLAGS)

$(P1OBJ): p1.h ../ihdrs/int1.h ../ihdrs/int01.h ../ihdrs/int12.h ../ihdrs/int012.h
$(P1PROBJ): int2p.h ../ihdrs/int12.h ../ihdrs/int012.h

util.o: util.c ../util/util.c
getflags.o: getflags.c ../util/getflags.c

clean:
	$(RM) $(CMDS) *.o
