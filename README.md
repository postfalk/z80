**Arduino driven Z80 development**

The basic idea of the project is to use an Arduino to support the development of a z80 computer system. The Arduino stands in as ...

a) reset generator  
b) clock  
c) ROM for the lowest 64byte 0000h-003Fh  

The z80 code is fed from a C array to PORTD, PORTB (with 6pins on an Arduino UNO R3) as address bus, and PORTC simulates the control bus (RD --> PIN4, MRQ --> PIN2, RESET <-- PIN3, CLOCK <-- Pin5). 

The z80 board is basically a Arduino shield (even though much bigger and the Arduino is plucked upside down on top of it). In order to run the board without the Arduino, I created a circuit on an Arduino shield PCB with a reset and a clock circuit.

The Arduino emulation runs on somewhat over 600khz since all pinMode operations have been stripped out the Arduino code.

After Arduino reset, the Aruino code will perform a z80 reset as well. 

The clock speed can be modified by inserting Arduino delays in the code which is very useful for debugging. ```Serial.println``` proved als very useful even though it might conflict with z80 data bus on PORT D. For this reason it needs to be placed strategically (e.g. at the high phase of the clock cycle). 

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

***EEPROM***

I got a very cheap, very universal EEPROM programmer called MiniPro TL866xx. It works perfectly with following project: 
Install the project if you want to use this project to directly write XPROMS with the code below.

https://github.com/vdudouyt/

Tested with XICOR 28C64. The python code below assumes this 8k by 8byte device. Change code accordingly for other devices or more flexible use.

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

Since we have currently only a simple 1 bit address decoder (OR) on address pin 7 only two devices can be addressed. TODO: Use 74HCT238 to increase this number to 8.

***Example code in this project***

*piobasics.asm*

Just turns bit 0 at port B on if addresses are configured as above. (any speed, originally 1 to 10hz :) )

*pioextended.asm*

Blinks bit 0 at port B if addresses are configured as above (optimized for, i.e. visible at 600kHz clock). Also requires RAM at ffffh for sub routine call. 
