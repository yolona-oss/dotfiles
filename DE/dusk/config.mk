# dusk version
VERSION = 1.0

# Customize below to fit your system

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# FreeBSD (uncomment)
#X11INC = /usr/local/include
#X11LIB = /usr/local/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2
# FreeBSD (uncomment)
#FREETYPEINC = /usr/local/include/freetype2
# OpenBSD (uncomment)
#FREETYPEINC = ${X11INC}/freetype2
#KVMLIB = -lkvm

# Needed for the alpha patch
XRENDER = -lXrender

# Needed for the ipc patch
YAJLLIBS = -lyajl
YAJLINC = -I/usr/include/yajl

# This is needed for the swallow patch
XCBLIBS = -lX11-xcb -lxcb -lxcb-res

# This is needed for the winicon patch
IMLIB2LIBS = -lImlib2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC} ${YAJLINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}  ${XRENDER} ${XCBLIBS} ${KVMLIB} ${YAJLLIBS} ${IMLIB2LIBS}

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=200809L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
#CFLAGS   = -g -std=c99 -pedantic -Wall -O0 ${INCS} ${CPPFLAGS}
CFLAGS   = -march=znver1 -O2 -std=c99 -pedantic -Wall -Wno-deprecated-declarations ${INCS} ${CPPFLAGS}
LDFLAGS  = ${LIBS}

# Solaris
#CFLAGS = -fast ${INCS} -DVERSION=\"${VERSION}\"
#LDFLAGS = ${LIBS}

# compiler and linker
CC = cc
