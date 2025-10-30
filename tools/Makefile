CC = cdriver -proto c.proto -dnostrict -dlincl

TOOLS = \
	readclock \
	date \
	ps \
	show0 \
	settime \
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

xbios.o: xbios.s
	$(CC) +o xbios.s

clean:
	rm *.o $(TOOLS)
