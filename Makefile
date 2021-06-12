# Adapted from tree-sitter/tree-sitter/Makefile
# VERSION := 0.6.3

# install directory layout
PREFIX ?= /usr/local
INCLUDEDIR ?= $(PREFIX)/include
LIBDIR ?= $(PREFIX)/lib
PCLIBDIR ?= $(LIBDIR)/pkgconfig

# collect sources
# ifneq ($(AMALGAMATED),1)
# 	SRC := $(wildcard lib/src/*.c)
# 	# do not double-include amalgamation
# 	SRC := $(filter-out lib/src/lib.c,$(SRC))
# else
# 	# use amalgamated build
# 	SRC := lib/src/lib.c
# endif
# OBJ := $(SRC:.c=.o)

LIB_TO_BE := libtree-sitter-ffi-lang
BUILDDIR := ./build

PULLDIR := ./lib/pull
	
# define default flags, and override to append mandatory flags
CFLAGS ?= -O3 -Wall -Wextra -Werror
override CFLAGS += -std=gnu99 -fPIC -Ilib/src -Ilib/include

# for .c cpp warning: add -xc++ ???

# override CC = clang++ ???

# ABI versioning
SONAME_MAJOR := 0
SONAME_MINOR := 0

# OS-specific bits
ifeq ($(shell uname),Darwin)
	SOEXT = dylib
	SOEXTVER_MAJOR = $(SONAME_MAJOR).dylib
	SOEXTVER = $(SONAME_MAJOR).$(SONAME_MINOR).dylib
	LINKSHARED += -dynamiclib -Wl,-install_name,$(LIBDIR)/$(LIB_TO_BE).$(SONAME_MAJOR).dylib
else
	SOEXT = so
	SOEXTVER_MAJOR = so.$(SONAME_MAJOR)
	SOEXTVER = so.$(SONAME_MAJOR).$(SONAME_MINOR)
	LINKSHARED += -shared -Wl,-soname,$(LIB_TO_BE).so.$(SONAME_MAJOR)
endif
ifneq (,$(filter $(shell uname),FreeBSD NetBSD DragonFly))
	PCLIBDIR := $(PREFIX)/libdata/pkgconfig
endif

### make LANGS a param in erb???
# LANGS := json bash c embedded_template html java javascript make markdown python ruby rust

PARSER_SRC := $(wildcard $(PULLDIR)/*/src/parser.c)
# PARSER_SRC := $(foreach lang,$(LANGS),$(wildcard $(PULLDIR)/$(lang)/src/parser.c))
PARSER_OBJ := $(PARSER_SRC:.c=.o)

SCANNER_SRC := $(wildcard $(PULLDIR)/*/src/scanner.cc)
# SCANNER_SRC := $(foreach lang,$(LANGS),$(wildcard $(PULLDIR)/$(lang)/src/scanner.cc))
SCANNER_OBJ := $(SCANNER_SRC:.cc=.o)

all: $(LIB_TO_BE).a $(LIB_TO_BE).$(SOEXTVER) 
	
%parser.o: %parser.c
	clang++ -c $^ -o $@
%scanner.o: %scanner.cc
	clang++ -c $^ -o $@

OBJ := $(PARSER_OBJ) $(SCANNER_OBJ) 

$(LIB_TO_BE).a: $(OBJ)
	install -d '$(BUILDDIR)'
	$(AR) rcs $(BUILDDIR)/$@ $^

$(LIB_TO_BE).$(SOEXTVER): $(OBJ)
	install -d '$(BUILDDIR)'
	clang++ $(LDFLAGS) $(LINKSHARED) $^ $(LDLIBS) -o $(BUILDDIR)/$@
# 	$(CC) $(LDFLAGS) $(LINKSHARED) $^ $(LDLIBS) -o $(BUILDDIR)/$@
	ln -sf $@ $(BUILDDIR)/$(LIB_TO_BE).$(SOEXT)
	ln -sf $@ $(BUILDDIR)/$(LIB_TO_BE).$(SOEXTVER_MAJOR)

clean:
	rm -rf $(PULLDIR)/*/src/*.o $(BUILDDIR) # what about gem???
	
# tidy just rm intermediate .o files, not built lib
tidy:
	rm -rf $(PULLDIR)/*/src/*.o


install: $(BUILDDIR)/$(LIB_TO_BE).a $(BUILDDIR)/$(LIB_TO_BE).$(SOEXTVER) 
	install -d '$(DESTDIR)$(LIBDIR)'
	install -m755 $(BUILDDIR)/$(LIB_TO_BE).a '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).a
	install -m755 $(BUILDDIR)/$(LIB_TO_BE).$(SOEXTVER) '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).$(SOEXTVER)
	ln -sf '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).$(SOEXTVER) '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).$(SOEXTVER_MAJOR)
	ln -sf '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).$(SOEXTVER) '$(DESTDIR)$(LIBDIR)'/$(LIB_TO_BE).$(SOEXT)
	
