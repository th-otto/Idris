CC = cdriver -proto c.proto -dnostrict -dlincl

TOOLS = \
	readclock \
	date \
	false \
	true \
	ps \
	show0 \
	settime \
	echo \
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

echo: echo.o
	$(CC) -o$@ echo.o

xbios.o: xbios.s
	$(CC) +o xbios.s

clean:
	rm *.o $(TOOLS)
