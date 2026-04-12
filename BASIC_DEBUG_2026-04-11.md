# BASIC Bring-Up Notes (2026-04-11)

This note summarizes the debugging and bring-up work done for NASCOM BASIC on the Falk Z80 SBC.

## Summary

- The UART path is working.
- ROM boot is working.
- RAM from `8000h` to `FFFFh` passed a serial read/write pattern test.
- The original BASIC workspace base in `basic.asm` was wrong for this machine and was fixed.
- The remaining BASIC startup issue is not caused by bad RAM or by the workspace being in ROM.

## System facts confirmed today

### Memory map

The project README documents this layout:

- `0000h-7FFFh`: ROM space
- `8000h-FFFFh`: static RAM

This matters because Microsoft/NASCOM BASIC needs its workspace in writable RAM.

### UART setup

The serial interface being used by the ROM wrapper is the TL16C550A on ports `80h-87h`.

The current wrapper and the smoke test both use:

- data register: `80h`
- divisor latch low: `80h`
- divisor latch high: `81h`
- line control register: `83h`
- line status register: `85h`

The code initializes the UART for `9600 8-N-1` by:

1. writing `80h` to `83h` to enable divisor latch access
2. writing `0Ch` to `80h`
3. writing `00h` to `81h`
4. writing `03h` to `83h`

## BASIC workspace issue

### Original problem

`basic.asm` originally used:

```asm
WRKSPC  .EQU    7066H
```

That places the BASIC workspace in ROM on this machine.

This explains broken behavior such as arithmetic producing nonsense values, because state like:

- `FPREG`
- expression evaluator scratch state
- print buffer
- program/input workspace

must live in writable RAM.

### Fix applied

`basic.asm` now uses:

```asm
WRKSPC  .EQU    8045H
```

That matches the machine memory map and the older `bas32K.asm` variant.

## Source changes made

### `zasm/basic.asm`

- Changed the BASIC workspace from `7066h` to `8045h`.
- Added temporary serial trace markers for startup debugging.

### `zasm/intfalk.asm`

- Changed the include to use `basic.asm` directly instead of `bas32K.asm`.
- Added a temporary jump marker before entering BASIC.

## Toolchain findings

### Wrong assembler

The Homebrew-installed `z80asm` is not compatible with this source format. It fails on directives and syntax such as:

- `.EQU`
- `.ORG`
- `.BYTE`
- `#include`
- `.END`

### Correct assembler

The project-local `zasm` works:

```sh
/Users/falk/workspace/z80/zasm/zasm
```

A fresh assembly of the combined BASIC ROM succeeded with that tool.

## ROM artifacts created

These files were created during today’s debugging session:

### `zasm/intfalk_fresh_rom.bin`

Freshly assembled combined BASIC ROM, padded to 8 KB for EEPROM programming.

Burn with:

```sh
minipro -p X28C64 -w /Users/falk/workspace/z80/z80/zasm/intfalk_fresh_rom.bin
```

### `zasm/intfalk_smoke_rom.bin`

Minimal UART smoke-test ROM.

Purpose:

- verify reset vector
- verify ROM execution
- verify UART transmit path
- verify terminal settings

Observed result:

- This ROM worked.

### `zasm/intfalk_probe_rom.bin`

Early BASIC startup probe ROM with serial markers.

Purpose:

- verify that execution reaches BASIC
- determine how far cold start proceeds

Observed result:

- BASIC reached the `MSIZE` / memory-top prompt path.

### `zasm/intfalk_probe2_rom.bin`

Deeper BASIC startup probe ROM with later-stage markers.

Purpose:

- isolate failures in:
  - program pointer clearing
  - sign-on banner printing
  - free-memory number formatting
  - final prompt handoff

### `zasm/ramtest_serial_rom.bin`

Serial RAM tester.

Purpose:

- verify RAM from `8000h` upward with `55h`/`AAh` patterns
- report highest good address

Observed result:

- `PASS to FFFF`

This is an important result. It strongly suggests that the remaining BASIC startup problem is not caused by bad RAM or incomplete RAM decoding.

## Probe interpretation

The first probe produced markers showing the wrapper and BASIC reached:

- wrapper jump marker: `J`
- BASIC `STARTB`: `S`
- BASIC `CSTART`: `C`
- BASIC `INIT`: `I`
- workspace copy completed: `Y`
- `CLREG` returned: `R`
- memory prompt path: `M`
- top-of-memory path: `T`

That means:

- the wrapper-to-BASIC handoff works
- BASIC workspace relocation works
- RAM scanning/top-of-memory setup runs
- the machine gets much farther than the original no-output symptom suggested

## Current diagnosis

At the end of today’s work:

- serial hardware is working
- combined ROM boot is working
- full RAM test passes
- the wrong BASIC workspace address was fixed

So the remaining issue is likely in the later cold-start path of BASIC after RAM setup, such as:

- banner printing
- free-memory formatting/printing
- transition into the normal prompt path

It does **not** currently look like:

- dead UART
- bad EEPROM image format
- bad RAM
- broken reset vector
- wrong BASIC workspace base

## Useful commands

### Assemble with the correct assembler

```sh
/Users/falk/workspace/z80/zasm/zasm /Users/falk/workspace/z80/z80/zasm/intfalk.asm /Users/falk/workspace/z80/z80/zasm/intfalk_fresh.bin
```

### Burn the latest full BASIC ROM

```sh
minipro -p X28C64 -w /Users/falk/workspace/z80/z80/zasm/intfalk_fresh_rom.bin
```

### Burn the UART smoke test

```sh
minipro -p X28C64 -w /Users/falk/workspace/z80/z80/zasm/intfalk_smoke_rom.bin
```

### Burn the RAM test

```sh
minipro -p X28C64 -w /Users/falk/workspace/z80/z80/zasm/ramtest_serial_rom.bin
```

## Next steps

If BASIC still does not come up cleanly, continue from the later startup path with probe markers around:

- `CLRPTR`
- `PRS` of the BASIC sign-on message
- `PRNTHL`
- the transition to `PRNTOK`

That is now the shortest path to finding the remaining bug.
