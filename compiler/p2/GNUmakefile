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
CMDS = p2

all: $(CMDS)

P2OBJ = p2expr.o p2fmov.o p2gen.o p2jump.o p2main.o p2subs.o p2tab.o q2dbug.o util.o getflags.o

p2: $(P2OBJ)
	$(CC) $(CFLAGS) -o $@ $(P2OBJ) $(LDFLAGS)

util.o: util.c ../util/util.c
getflags.o: getflags.c ../util/getflags.c

clean:
	$(RM) $(CMDS) *.o
