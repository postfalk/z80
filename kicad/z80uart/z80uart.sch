EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:z80-cache
LIBS:z80uart-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L z80pcb U?
U 1 1 576A08A0
P 10850 3440
F 0 "U?" H 10850 3440 60  0000 C CNN
F 1 "z80pcb" H 10850 3440 60  0000 C CNN
F 2 "" H 10850 3440 60  0000 C CNN
F 3 "" H 10850 3440 60  0000 C CNN
	1    10850 3440
	1    0    0    -1  
$EndComp
$Comp
L 16550 U?
U 1 1 576A0977
P 6000 3760
F 0 "U?" H 5150 5360 50  0000 L CNN
F 1 "16550" H 6600 5360 50  0000 L CNN
F 2 "DIP-40" H 6000 3760 50  0000 C CIN
F 3 "" H 6000 3760 50  0000 C CNN
	1    6000 3760
	1    0    0    -1  
$EndComp
Text GLabel 10150 4040 0    60   Input ~ 0
d0
Text GLabel 10150 4140 0    60   Input ~ 0
d1
Text GLabel 10150 4240 0    60   Input ~ 0
d2
Text GLabel 10150 4340 0    60   Input ~ 0
d3
Text GLabel 10150 4440 0    60   Input ~ 0
d4
Text GLabel 10150 4540 0    60   Input ~ 0
d5
Text GLabel 10150 4640 0    60   Input ~ 0
d6
Text GLabel 10150 4740 0    60   Input ~ 0
d7
Text GLabel 5000 2360 0    60   Input ~ 0
d0
Text GLabel 5000 2460 0    60   Input ~ 0
d1
Text GLabel 5000 2560 0    60   Input ~ 0
d2
Text GLabel 5000 2660 0    60   Input ~ 0
d3
Text GLabel 5000 2760 0    60   Input ~ 0
d4
Text GLabel 5000 2860 0    60   Input ~ 0
d5
Text GLabel 5000 2960 0    60   Input ~ 0
d6
Text GLabel 5000 3060 0    60   Input ~ 0
d7
Text GLabel 5000 3260 0    60   Input ~ 0
a0
Text GLabel 5000 3360 0    60   Input ~ 0
a1
Text GLabel 5000 3460 0    60   Input ~ 0
a2
Text GLabel 10150 2340 0    60   Input ~ 0
a0
Text GLabel 10150 2440 0    60   Input ~ 0
a1
Text GLabel 10150 2540 0    60   Input ~ 0
a2
$Comp
L 74LS138 U?
U 1 1 576A0D11
P 8580 2630
F 0 "U?" H 8680 3130 50  0000 C CNN
F 1 "74LS138" H 8730 2081 50  0000 C CNN
F 2 "" H 8580 2630 50  0000 C CNN
F 3 "" H 8580 2630 50  0000 C CNN
	1    8580 2630
	1    0    0    -1  
$EndComp
Text GLabel 7980 2980 0    60   Input ~ 0
a7
Text GLabel 7980 2880 0    60   Input ~ 0
a6
Text GLabel 7980 2480 0    60   Input ~ 0
a5
Text GLabel 7980 2380 0    60   Input ~ 0
a4
Text GLabel 7980 2280 0    60   Input ~ 0
a3
Text GLabel 10150 2640 0    60   Input ~ 0
a3
Text GLabel 10150 2740 0    60   Input ~ 0
a4
Text GLabel 10150 2840 0    60   Input ~ 0
a5
Text GLabel 10150 2940 0    60   Input ~ 0
a6
Text GLabel 10150 3040 0    60   Input ~ 0
a7
$Comp
L VCC #PWR?
U 1 1 576A1041
P 7980 2780
F 0 "#PWR?" H 7980 2630 50  0001 C CNN
F 1 "VCC" H 7980 2930 50  0000 C CNN
F 2 "" H 7980 2780 50  0000 C CNN
F 3 "" H 7980 2780 50  0000 C CNN
	1    7980 2780
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 576A10B7
P 10150 1040
F 0 "#PWR?" H 10150 890 50  0001 C CNN
F 1 "VCC" H 10150 1190 50  0000 C CNN
F 2 "" H 10150 1040 50  0000 C CNN
F 3 "" H 10150 1040 50  0000 C CNN
	1    10150 1040
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 576A1322
P 10160 5840
F 0 "#PWR?" H 10160 5590 50  0001 C CNN
F 1 "GND" H 10160 5690 50  0000 C CNN
F 2 "" H 10160 5840 50  0000 C CNN
F 3 "" H 10160 5840 50  0000 C CNN
	1    10160 5840
	1    0    0    -1  
$EndComp
Text GLabel 9180 2380 2    60   Input ~ 0
uart_cs
Text GLabel 5000 3760 0    60   Input ~ 0
uart_cs
$Comp
L VCC #PWR?
U 1 1 576A1B73
P 4790 3560
F 0 "#PWR?" H 4790 3410 50  0001 C CNN
F 1 "VCC" H 4790 3710 50  0000 C CNN
F 2 "" H 4790 3560 50  0000 C CNN
F 3 "" H 4790 3560 50  0000 C CNN
	1    4790 3560
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 576A1DB5
P 4730 3660
F 0 "#PWR?" H 4730 3510 50  0001 C CNN
F 1 "VCC" H 4730 3810 50  0000 C CNN
F 2 "" H 4730 3660 50  0000 C CNN
F 3 "" H 4730 3660 50  0000 C CNN
	1    4730 3660
	1    0    0    -1  
$EndComp
$Comp
L XO-14S X?
U 1 1 576A1F0F
P 8550 4740
F 0 "X?" H 8310 5100 60  0000 C CNN
F 1 "XO-14S" H 8550 4370 60  0000 C CNN
F 2 "" H 8550 4740 60  0000 C CNN
F 3 "" H 8550 4740 60  0000 C CNN
	1    8550 4740
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 576A1FC6
P 7950 4550
F 0 "#PWR?" H 7950 4400 50  0001 C CNN
F 1 "VCC" H 7950 4700 50  0000 C CNN
F 2 "" H 7950 4550 50  0000 C CNN
F 3 "" H 7950 4550 50  0000 C CNN
	1    7950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 576A21AC
P 7950 4930
F 0 "#PWR?" H 7950 4680 50  0001 C CNN
F 1 "GND" H 7950 4780 50  0000 C CNN
F 2 "" H 7950 4930 50  0000 C CNN
F 3 "" H 7950 4930 50  0000 C CNN
	1    7950 4930
	1    0    0    -1  
$EndComp
Text GLabel 9230 4830 2    60   Input ~ 0
clock
Text GLabel 5000 3960 0    60   Input ~ 0
clock
Text GLabel 10150 5540 0    60   Input ~ 0
rd
Text GLabel 10150 5640 0    60   Input ~ 0
wr
Text GLabel 5000 4860 0    60   Input ~ 0
rd
Text GLabel 5000 4560 0    60   Input ~ 0
wr
$Comp
L VCC #PWR?
U 1 1 576A28D7
P 4700 4650
F 0 "#PWR?" H 4700 4500 50  0001 C CNN
F 1 "VCC" H 4700 4800 50  0000 C CNN
F 2 "" H 4700 4650 50  0000 C CNN
F 3 "" H 4700 4650 50  0000 C CNN
	1    4700 4650
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 576A2ABD
P 4560 4750
F 0 "#PWR?" H 4560 4600 50  0001 C CNN
F 1 "VCC" H 4560 4900 50  0000 C CNN
F 2 "" H 4560 4750 50  0000 C CNN
F 3 "" H 4560 4750 50  0000 C CNN
	1    4560 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	4790 3560 5000 3560
Wire Wire Line
	4730 3660 5000 3660
Wire Wire Line
	5000 4660 4700 4660
Wire Wire Line
	4700 4660 4700 4650
Wire Wire Line
	5000 4760 4560 4760
Wire Wire Line
	4560 4760 4560 4750
Wire Wire Line
	7000 4960 7000 5160
Text GLabel 10150 6190 0    60   Input ~ 0
reset
Text GLabel 5000 5160 0    60   Input ~ 0
reset
$EndSCHEMATC
