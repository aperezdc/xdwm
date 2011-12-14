#
# Makefile
# Adrian Perez, 2011-12-14 11:51
#

DESTDIR ?= 
PREFIX ?= /usr/local

XSESSIONS_DIR = $(PREFIX)/share/xsessions
BINDIR        = $(PREFIX)/bin

all:
	@echo "Nothing to do"

install:
	install -m 755 -d $(DESTDIR)$(XSESSIONS_DIR)
	install -m 644 -t $(DESTDIR)$(XSESSIONS_DIR) xdwm.desktop
	install -m 755 -d $(DESTDIR)$(BINDIR)
	install -m 644 -t $(DESTDIR)$(BINDIR) xdwm-session

uninstall:
	rm -f $(DESTDIR)$(XSESSIONS_DIR)/xdwm.desktop
	rm -f $(DESTDIR)$(BINDIR)/xdwm-session

.PHONY: install uninstall

# vim:ft=make
#
