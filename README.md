**Arduino driven Z80 development**

The basic idea of the project is to use an Arduino to support the development of a z80 computer system. The Arduino stands in as ...

a) reset generator

b) clock

c) ROM for the lowest 64byte 0000h-003Fh

The z80 code is fed from a C array to PORTD, PORTB (with 6pins on an Arduino UNO R3) as address bus, and PORTC simulates the control bus (RD --> PIN4, MRQ --> PIN2, RESET <-- PIN3, CLOCK <-- Pin5). 

The z80 board is basically a Arduino shield (even though much bigger and the Arduino is plucked upside down on top of it). In order to run the board without the Arduino, I created a circuit on an Arduino shield PCB with a reset and a clock circuit.

The Arduino emulation runs on somewhat over 600khz since all pinMode operations have been stripped out the Arduino code.

***Prerequisites***

There is actually a Z80 assembler in the Ubuntu universe repos!!! If you are using Ubuntu you are all set for now.

```
sudo apt-get install z80asm 
```

will work on Ubuntu. Otherwise make sure z80asm is in your executable path. There is also a de-assembler for binaries (z80dasm).

***Assemble and generate Arduino code***

```
python assemble.py -i test.asm
```


In order to review binary hex code install bless:

```
sudo apt-get install bless
```

Notes:

Linux programmer for EPROM programmer

https://github.com/vdudouyt/minipro

***Current configuration***

The circuit follows very closely http://www.z80.info/gfx/z80test.gif.

Differences: 

- I am using an actual less modern and more original ZILOG z80 PIO.

*Addresses*:

Memory: 
0000h - 003Fh   Arduino ROM emulation
or 
0000h - 7FFFh   Space for ROM

8000h - FFFFh   (static) RAM

I/O:
00h - 03h   PIO
  00h         PORT A - ctrl
  01h         PORT A - data
  02h         PORT B - ctrl
  03h         PORT B - data
80h -         available

Since there is a simple 1 bit address decoder (OR) on address pin 7 only two devices can be addressed. TODO: Use 74HCT238 to increase this number to 8.

