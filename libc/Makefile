# Note: you must increase heap size of make to use this long list
LIBA_OBJS = \
	clock.o \
	$(empty)

LIBB_OBJS = \
	times.o \
	$(empty)

all: liba.68k libb.68k

liba.68k: $(LIBA_OBJS)
libb.68k: $(LIBB_OBJS)

.s.o:
	$(CC) +o $<

times.o: times.s

clean:
	rm *.o *.68k
