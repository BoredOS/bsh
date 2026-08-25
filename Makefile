# Copyright (c) 2026 Christiaan (chris@boreddev.nl)
# Bored Shell Makefile (Supports Standalone & Integrated builds)

CC = x86_64-boredos-gcc

DESTDIR ?= $(abspath build/dist)

CFLAGS  = -Wall -Wextra -std=gnu11 -O2 -fno-stack-protector \
          -fno-stack-check -m64 -march=x86-64

LDFLAGS = -Wl,-z,max-page-size=0x1000 -Wl,-dynamic-linker,/usr/lib/ld.so -Wl,-rpath,/usr/lib:/lib

APPS    = bsh.elf

OBJS = obj/bsh.o obj/utf-8.o

all: $(APPS)

bsh.elf: $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

obj/%.o: src/%.c
	@mkdir -p obj
	$(CC) $(CFLAGS) -c $< -o $@

install: all
	mkdir -p $(DESTDIR)/bin
	cp $(APPS) $(DESTDIR)/bin/
	mkdir -p $(DESTDIR)/Library/AppData/org.boredos.bsh
	cp assets/* $(DESTDIR)/Library/AppData/org.boredos.bsh/

clean:
	rm -rf obj build $(APPS)
