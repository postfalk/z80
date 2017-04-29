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
L z80pcb U101
U 1 1 576A08A0
P 10850 3440
F 0 "U101" H 10850 3440 60  0000 C CNN
F 1 "z80pcb" H 10850 3440 60  0000 C CNN
F 2 "kicad:z80systemboard" H 10850 3440 60  0000 C CNN
F 3 "" H 10850 3440 60  0000 C CNN
	1    10850 3440
	1    0    0    -1  
$EndComp
$Comp
L 16550 U1
U 1 1 576A0977
P 6000 3760
F 0 "U1" H 5150 5360 50  0000 L CNN
F 1 "16550" H 6600 5360 50  0000 L CNN
F 2 "Housings_DIP:DIP-40_W15.24mm" H 6000 3760 50  0000 C CIN
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
L 74LS138 U2
U 1 1 576A0D11
P 8580 2630
F 0 "U2" H 8680 3130 50  0000 C CNN
F 1 "74LS138" H 8730 2081 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm" H 8580 2630 50  0000 C CNN
F 3 "" H 8580 2630 50  0000 C CNN
	1    8580 2630
	1    0    0    -1  
$EndComp
Text GLabel 7980 2780 0    60   Input ~ 0
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
L VCC #PWR01
U 1 1 576A10B7
P 10150 1040
F 0 "#PWR01" H 10150 890 50  0001 C CNN
F 1 "VCC" H 10150 1190 50  0000 C CNN
F 2 "" H 10150 1040 50  0000 C CNN
F 3 "" H 10150 1040 50  0000 C CNN
	1    10150 1040
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 576A1322
P 10150 5840
F 0 "#PWR02" H 10150 5590 50  0001 C CNN
F 1 "GND" H 10150 5690 50  0000 C CNN
F 2 "" H 10150 5840 50  0000 C CNN
F 3 "" H 10150 5840 50  0000 C CNN
	1    10150 5840
	1    0    0    -1  
$EndComp
Text GLabel 9180 2280 2    60   Input ~ 0
uart_cs
Text GLabel 5000 3760 0    60   Input ~ 0
uart_cs
$Comp
L XO-14S X1
U 1 1 576A1F0F
P 8550 4740
F 0 "X1" H 8310 5100 60  0000 C CNN
F 1 "XO-14S" H 8550 4370 60  0000 C CNN
F 2 "Oscillators:KXO-200" H 8550 4740 60  0000 C CNN
F 3 "" H 8550 4740 60  0000 C CNN
	1    8550 4740
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 576A1FC6
P 7950 4550
F 0 "#PWR03" H 7950 4400 50  0001 C CNN
F 1 "VCC" H 7950 4700 50  0000 C CNN
F 2 "" H 7950 4550 50  0000 C CNN
F 3 "" H 7950 4550 50  0000 C CNN
	1    7950 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 576A21AC
P 7950 4930
F 0 "#PWR04" H 7950 4680 50  0001 C CNN
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
Text GLabel 10150 6190 0    60   Input ~ 0
reset
Text GLabel 5000 5160 0    60   Input ~ 0
reset
Text GLabel 10150 5240 0    60   Input ~ 0
iorq
Text GLabel 7980 2980 0    60   Input ~ 0
iorq
$Comp
L serial_bort_interface U100
U 1 1 5777F6E9
P 3160 3120
F 0 "U100" H 3160 3120 60  0000 C CNN
F 1 "serial_port_interface" H 3160 3120 60  0000 C CNN
F 2 "kicad:serial_to_usb_large" H 3160 3120 60  0000 C CNN
F 3 "" H 3160 3120 60  0000 C CNN
	1    3160 3120
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR07
U 1 1 5777FCC2
P 2910 2770
F 0 "#PWR07" H 2910 2520 50  0001 C CNN
F 1 "GND" H 2910 2620 50  0000 C CNN
F 2 "" H 2910 2770 50  0000 C CNN
F 3 "" H 2910 2770 50  0000 C CNN
	1    2910 2770
	-1   0    0    1   
$EndComp
Text GLabel 7000 2860 2    60   Input ~ 0
cts
Text GLabel 2910 2820 0    60   Input ~ 0
cts
Text GLabel 7000 4060 2    60   Input ~ 0
tx
Text GLabel 2910 2970 0    60   Input ~ 0
tx
Text GLabel 7000 3960 2    60   Input ~ 0
rx
Text GLabel 2910 2920 0    60   Input ~ 0
rx
Text GLabel 7000 3260 2    60   Input ~ 0
dtr
Text GLabel 2910 3020 0    60   Input ~ 0
dtr
$Comp
L GND #PWR08
U 1 1 57781892
P 6000 5460
F 0 "#PWR08" H 6000 5210 50  0001 C CNN
F 1 "GND" H 6000 5310 50  0000 C CNN
F 2 "" H 6000 5460 50  0000 C CNN
F 3 "" H 6000 5460 50  0000 C CNN
	1    6000 5460
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR09
U 1 1 57781A45
P 6000 2060
F 0 "#PWR09" H 6000 1910 50  0001 C CNN
F 1 "VCC" H 6000 2210 50  0000 C CNN
F 2 "" H 6000 2060 50  0000 C CNN
F 3 "" H 6000 2060 50  0000 C CNN
	1    6000 2060
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 4660 4700 4660
Wire Wire Line
	4560 4760 4700 4760
Wire Wire Line
	4700 4760 5000 4760
Wire Wire Line
	7000 4960 7000 5160
$Comp
L VCC #PWR010
U 1 1 576A1DB5
P 4730 3660
F 0 "#PWR010" H 4730 3510 50  0001 C CNN
F 1 "VCC" H 4730 3810 50  0000 C CNN
F 2 "" H 4730 3660 50  0000 C CNN
F 3 "" H 4730 3660 50  0000 C CNN
	1    4730 3660
	1    0    0    -1  
$EndComp
Wire Wire Line
	4730 3660 5000 3660
Wire Wire Line
	4790 3560 5000 3560
$Comp
L VCC #PWR011
U 1 1 576A1B73
P 4790 3560
F 0 "#PWR011" H 4790 3410 50  0001 C CNN
F 1 "VCC" H 4790 3710 50  0000 C CNN
F 2 "" H 4790 3560 50  0000 C CNN
F 3 "" H 4790 3560 50  0000 C CNN
	1    4790 3560
	1    0    0    -1  
$EndComp
Wire Wire Line
	5000 4960 4700 4960
Wire Wire Line
	4700 4960 4700 4760
Connection ~ 4700 4760
$Comp
L C C1
U 1 1 57796E04
P 8380 1090
F 0 "C1" H 8405 1190 50  0000 L CNN
F 1 "100nF" H 8405 990 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 8418 940 50  0000 C CNN
F 3 "" H 8380 1090 50  0000 C CNN
	1    8380 1090
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 57796E73
P 8380 1240
F 0 "#PWR012" H 8380 990 50  0001 C CNN
F 1 "GND" H 8380 1090 50  0000 C CNN
F 2 "" H 8380 1240 50  0000 C CNN
F 3 "" H 8380 1240 50  0000 C CNN
	1    8380 1240
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR013
U 1 1 57796E99
P 8380 940
F 0 "#PWR013" H 8380 790 50  0001 C CNN
F 1 "VCC" H 8380 1090 50  0000 C CNN
F 2 "" H 8380 940 50  0000 C CNN
F 3 "" H 8380 940 50  0000 C CNN
	1    8380 940 
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 57797882
P 8690 1090
F 0 "C2" H 8715 1190 50  0000 L CNN
F 1 "100nF" H 8715 990 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Disc_D3_P2.5" H 8728 940 50  0000 C CNN
F 3 "" H 8690 1090 50  0000 C CNN
	1    8690 1090
	1    0    0    -1  
$EndComp
Wire Wire Line
	8690 940  8380 940 
Wire Wire Line
	8690 1240 8380 1240
$Comp
L GND #PWR?
U 1 1 578C0BEF
P 4560 4770
F 0 "#PWR?" H 4560 4520 50  0001 C CNN
F 1 "GND" H 4560 4620 50  0000 C CNN
F 2 "" H 4560 4770 50  0000 C CNN
F 3 "" H 4560 4770 50  0000 C CNN
	1    4560 4770
	1    0    0    -1  
$EndComp
Wire Wire Line
	4560 4760 4560 4770
$Comp
L GND #PWR?
U 1 1 578C0D65
P 4400 4660
F 0 "#PWR?" H 4400 4410 50  0001 C CNN
F 1 "GND" H 4400 4510 50  0000 C CNN
F 2 "" H 4400 4660 50  0000 C CNN
F 3 "" H 4400 4660 50  0000 C CNN
	1    4400 4660
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 4660 4700 4660
$EndSCHEMATC
