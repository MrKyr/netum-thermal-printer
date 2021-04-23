CC=gcc
RM=rm -f
CFLAGS=-Wl,-rpath,/usr/lib -Wall -fPIC -O3
LDFLAGS=
LDLIBS=-lcupsimage -lcups

SRCS=rastertozj.c
OBJS=$(subst .c,.o,$(SRCS))

.PHONY: install

all: rastertozj ppd

rastertozj: $(OBJS)
	gcc $(LDFLAGS) -o rastertozj rastertozj.o $(LDLIBS)

rastertozj.o: rastertozj.c
	gcc $(CFLAGS) -c rastertozj.c

ppd:
	ppdc zj.drv

install:
	install -m 755 rastertozj $(DESTDIR)/usr/lib/cups/filter/
	mkdir -p $(DESTDIR)/usr/share/cups/model/zjiang
	install -m 644 ppd/zj58.ppd $(DESTDIR)/usr/share/cups/model/zjiang/

clean:
	-rm -f rastertozj
	-rm -f rastertozj.o
	-rm -rf ppd

uninstall:
	rm -f /usr/lib/cups/filter/rastertozj
	rm -f /usr/share/cups/model/zjiang
