VERSION ?= 1.0

CFLAGS ?= -O2 -Wall -Werror -DVERSION=\"$(VERSION)\"
LDFLAGS ?= -lX11

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/man/man1

all: xgetres

xgetres: xgetres.c
	$(CC) $(CFLAGS) $(LDFLAGS) $? -o $@

install: xgetres
	mkdir -p $(DESTDIR)$(BINDIR)
	install $< $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(MANDIR)
	install -m 644 xgetres.1 $(DESTDIR)$(MANDIR)/xgetres.1

clean:
	rm -f xgetres

.PHONY: all install clean
