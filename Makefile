# xdwm - xtended dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options xdwm

options:
	@echo xdwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

xdwm: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f xdwm ${OBJ} xdwm-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p xdwm-${VERSION}
	@cp -R LICENSE Makefile README config.def.h config.mk \
		xdwm.1 ${SRC} xdwm-${VERSION}
	@tar -cf xdwm-${VERSION}.tar xdwm-${VERSION}
	@gzip xdwm-${VERSION}.tar
	@rm -rf xdwm-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f xdwm ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/xdwm
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < xdwm.1 > ${DESTDIR}${MANPREFIX}/man1/xdwm.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/xdwm.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/xdwm
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/xdwm.1

.PHONY: all options clean dist install uninstall
