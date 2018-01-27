VERSION ?= 1.0

CFLAGS ?= -O2 -Wall -Werror -DVERSION=\"$(VERSION)\"
LDFLAGS ?= -lX11

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man/man1

all: xgetres

xgetres: xgetres.c
	$(CC) $(CFLAGS) $(LDFLAGS) $? -o $@

install: xgetres
	mkdir -p $(BINDIR)
	install $< $(BINDIR)
	mkdir -p $(MANDIR)
	install -m 644 xgetres.1 $(MANDIR)/xgetres.1

clean:
	rm -f xgetres

.PHONY: all install clean
