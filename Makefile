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
	install -m 755 rastertozj $(DESTDIR)/usr/libexec/cups/filter/
	install -m 644 ppd/zj58.ppd $(DESTDIR)/Library/Printers/PPDs/Contents/Resources/

clean:
	-rm -f rastertozj
	-rm -f rastertozj.o
	-rm -rf ppd

uninstall:
	rm -f /usr/libexec/cups/filter/rastertozj
	rm -f /Library/Printers/PPDs/Contents/Resources/zj58.drv
