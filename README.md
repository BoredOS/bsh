# Bored Shell (bsh)

This repository contains the interactive terminal shell (`bsh`) and primary shell scripts (`bshrc`, `startup.bsh`, `boot.bsh`) for BoredOS.

## Decoupled Building

This repository is designed to compile **either within the main BoredOS tree OR completely standalone**.

### 1. Integrated Build (Within BoredOS)
If built from the BoredOS root tree, the build system passes `BOREDOS_SDK` to the Makefile. It immediately compiles `bsh.elf` against the shared pre-built SDK without duplicate clones:
```bash
make BOREDOS_SDK=/path/to/shared/sdk
```

### 2. Standalone Build (Isolated Clone)
If cloned completely separately in isolation, running `make` will **automatically bootstrap the SDK**:
```bash
make
```
If `build/sdk` is missing, the Makefile automatically clones the pure standard library from `https://github.com/boredos/libc.git`, compiles it, installs it to `build/sdk`, and uses it to build `bsh.elf` standalone!

## Staging Installation
To stage the shell executable and script assets inside your BoredOS initrd root filesystem directory:
```bash
make DESTDIR=/path/to/initrd/root install
```
- Binary is routed to `/bin/bsh.elf`
- Script assets are routed to `/Library/bsh/`
