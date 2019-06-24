VERSION ?= 1.0

CPPFLAGS := -DVERSION=\"$(VERSION)\" $(CPPFLAGS)
CFLAGS ?= -O2 -Wall -Werror
LDFLAGS := -lX11 $(LDFLAGS)

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man/man1

all: xgetres

xgetres: xgetres.c
	$(CC) $(CPPFLAGS) $(CFLAGS) $? -o $@ $(LDFLAGS)

install: xgetres
	mkdir -p $(BINDIR)
	install -D $< $(BINDIR)
	mkdir -p $(MANDIR)
	install -Dm 644 xgetres.1 $(MANDIR)/xgetres.1

clean:
	rm -f xgetres

.PHONY: all install clean
