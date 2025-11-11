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
CMDS = pp

all: $(CMDS)

PPOBJ = p0eval.o p0lex.o p0main.o p0subs.o util.o getflags.o

pp: $(PPOBJ)
	$(CC) $(CFLAGS) -o $@ $(PPOBJ) $(LDFLAGS) -lm

clean:
	$(RM) $(CMDS) *.o
