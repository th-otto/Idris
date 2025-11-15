#
#	Makefile for Whitesmiths C preprocessor
#

# Cross compiler
CC = cdriver -proto c.proto

# Commands
CMDS = pp

all: $(CMDS)

.c.o:
	$(CC) +o $<

PPOBJ = p0eval.o p0lex.o p0main.o p0subs.o

pp:	$(PPOBJ)
	$(CC) -o $@ $(PPOBJ)

clean:
	$(RM) $(PPOBJ) $(CMDS)
