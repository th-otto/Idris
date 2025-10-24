TOOLS = \
	readclock \
	date \
	settime \
	$(empty)

all: $(TOOLS)

readclock: readclock.o xbios.o
	$(CC) -o$@ readclock.o xbios.o

date: date.o
	$(CC) -o$@ date.o

settime: settime.o
	$(CC) -o$@ settime.o

xbios.o: xbios.s
	$(CC) +o xbios.s

clean:
	rm *.o $(TOOLS)
