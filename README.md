**Arduino driven Z80 development**

The basic idea of this project is to use an Arduino to support the development of a z80 computer system and debug any of its components in the process. The Arduino stands in as ...

a) reset generator  
b) clock  
c) ROM for the lowest 64byte 0000h-003Fh  

The z80 code is fed from a C array to PORTD, PORTB (with 6pins on an Arduino UNO R3) as address bus, and PORTC simulates the control bus (RD --> PIN4, MRQ --> PIN2, RESET <-- PIN3, CLOCK <-- Pin5). The array index correspondends directly with the z80 system address.

The z80 board is more or less configured as an Arduino shield (even though bigger, the Arduino is plucked in upside down on top of it). In order to run the board without the Arduino, I created a circuit on an Arduino shield PCB with the reset and clock circuit. Thus, it is possible to go back and forth between normal computer operation and running debug code from Arduino.

The Arduino emulation runs somewhat over 600khz after stripping all pinMode routines out of the Arduino code. (I wonder whether the ```if ... else ...``` control structure could be replaced with bitwise logic as well).

After Arduino reset, the Aruino code will perform a z80 reset as well (which needs at least 4 clock cycles). 

The clock speed can be modified by inserting Arduino delays in the code which is very useful for debugging. ```Serial.println``` proved also very useful even though it might conflict with z80 data bus on PORT D. For this reason it needs to be placed strategically (e.g. at the high phase of the clock cycle). 

***Prerequisites***

There is a Z80 assembler in the Ubuntu universe repos!!! If you are using Ubuntu you are all set for now.

```
sudo apt-get install z80asm 
```

Otherwise make sure z80asm is in your executable path. There is also a de-assembler for binaries (z80dasm).

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

- I am using the more original ZILOG z80 PIO.

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

*d88.asm*

***Documentation Links***

Zilog User Manual: http://www.zilog.com/appnotes_download.php?FromPage=DirectLink&dn=UM0080&ft=User%20Manual&f=YUhSMGNEb3ZMM2QzZHk1NmFXeHZaeTVqYjIwdlpHOWpjeTk2T0RBdmRXMHdNRGd3TG5Ca1pnPT0=
