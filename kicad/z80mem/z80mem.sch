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
LIBS:z80mem-cache
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
L z80pcb U3
U 1 1 57531120
P 10550 3500
F 0 "U3" H 10550 3500 60  0000 C CNN
F 1 "z80pcb" H 10550 3500 60  0000 C CNN
F 2 "kicad:z80systemboard" H 10550 3500 60  0000 C CNN
F 3 "" H 10550 3500 60  0000 C CNN
	1    10550 3500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 57531665
P 9710 5900
F 0 "#PWR01" H 9710 5650 50  0001 C CNN
F 1 "GND" H 9710 5750 50  0000 C CNN
F 2 "" H 9710 5900 50  0000 C CNN
F 3 "" H 9710 5900 50  0000 C CNN
	1    9710 5900
	1    0    0    -1  
$EndComp
$Comp
L MS628128 U1
U 1 1 5753173A
P 7610 2320
F 0 "U1" H 7610 3520 50  0000 C CNN
F 1 "MS628128" H 7680 1120 50  0000 C CNN
F 2 "Housings_DIP:DIP-32_W15.24mm" H 7610 2320 50  0000 C CNN
F 3 "" H 7610 2320 50  0000 C CNN
	1    7610 2320
	1    0    0    -1  
$EndComp
$Comp
L 2764 U2
U 1 1 5753185F
P 7610 4970
F 0 "U2" H 7360 5970 50  0000 C CNN
F 1 "2764" H 7610 3970 50  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm" H 7610 4970 50  0000 C CNN
F 3 "" H 7610 4970 50  0000 C CNN
	1    7610 4970
	1    0    0    -1  
$EndComp
Text GLabel 8310 4070 2    60   Input ~ 0
d0
Text GLabel 8310 4170 2    60   Input ~ 0
d1
Text GLabel 8310 4270 2    60   Input ~ 0
d2
Text GLabel 8310 4370 2    60   Input ~ 0
d3
Text GLabel 8310 4470 2    60   Input ~ 0
d4
Text GLabel 8310 4570 2    60   Input ~ 0
d5
Text GLabel 8310 4670 2    60   Input ~ 0
d6
Text GLabel 8310 4770 2    60   Input ~ 0
d7
Text GLabel 9850 4100 0    60   Input ~ 0
d0
Text GLabel 9850 4200 0    60   Input ~ 0
d1
Text GLabel 9850 4300 0    60   Input ~ 0
d2
Text GLabel 9850 4400 0    60   Input ~ 0
d3
Text GLabel 9850 4500 0    60   Input ~ 0
d4
Text GLabel 9850 4600 0    60   Input ~ 0
d5
Text GLabel 9850 4700 0    60   Input ~ 0
d6
Text GLabel 9850 4800 0    60   Input ~ 0
d7
Text GLabel 9850 2400 0    60   Input ~ 0
a0
Text GLabel 9850 2500 0    60   Input ~ 0
a1
Text GLabel 9850 2600 0    60   Input ~ 0
a2
Text GLabel 9850 2700 0    60   Input ~ 0
a3
Text GLabel 9850 2800 0    60   Input ~ 0
a4
Text GLabel 9850 2900 0    60   Input ~ 0
a5
Text GLabel 9850 3000 0    60   Input ~ 0
a6
Text GLabel 9850 3100 0    60   Input ~ 0
a7
Text GLabel 9850 3200 0    60   Input ~ 0
a8
Text GLabel 9850 3300 0    60   Input ~ 0
a9
Text GLabel 9850 3400 0    60   Input ~ 0
a10
Text GLabel 9850 3500 0    60   Input ~ 0
a11
Text GLabel 9850 3600 0    60   Input ~ 0
a12
Text GLabel 9850 3700 0    60   Input ~ 0
a13
Text GLabel 9850 3800 0    60   Input ~ 0
a14
Text GLabel 9850 3900 0    60   Input ~ 0
a15
Text GLabel 6910 4070 0    60   Input ~ 0
a0
Text GLabel 6910 4170 0    60   Input ~ 0
a1
Text GLabel 6910 4270 0    60   Input ~ 0
a2
Text GLabel 6910 4370 0    60   Input ~ 0
a3
Text GLabel 6910 4470 0    60   Input ~ 0
a4
Text GLabel 6910 4570 0    60   Input ~ 0
a5
Text GLabel 6910 4670 0    60   Input ~ 0
a6
Text GLabel 6910 4770 0    60   Input ~ 0
a7
Text GLabel 6910 4870 0    60   Input ~ 0
a8
Text GLabel 6910 4970 0    60   Input ~ 0
a9
Text GLabel 6910 5070 0    60   Input ~ 0
a10
Text GLabel 6910 5170 0    60   Input ~ 0
a11
Text GLabel 6910 5270 0    60   Input ~ 0
a12
$Comp
L VCC #PWR02
U 1 1 57532AE0
P 9850 1000
F 0 "#PWR02" H 9850 850 50  0001 C CNN
F 1 "VCC" H 9850 1150 50  0000 C CNN
F 2 "" H 9850 1000 50  0000 C CNN
F 3 "" H 9850 1000 50  0000 C CNN
	1    9850 1000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR03
U 1 1 57532C25
P 6280 5470
F 0 "#PWR03" H 6280 5320 50  0001 C CNN
F 1 "VCC" H 6280 5620 50  0000 C CNN
F 2 "" H 6280 5470 50  0000 C CNN
F 3 "" H 6280 5470 50  0000 C CNN
	1    6280 5470
	1    0    0    -1  
$EndComp
Text GLabel 9850 5600 0    60   Input ~ 0
rd
Text GLabel 6910 5870 0    60   Input ~ 0
rd
$Comp
L 74LS32 U4
U 1 1 57539D72
P 1470 5310
F 0 "U4" H 1470 5360 50  0000 C CNN
F 1 "74LS32" H 1470 5260 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1470 5310 50  0000 C CNN
F 3 "" H 1470 5310 50  0000 C CNN
	1    1470 5310
	1    0    0    -1  
$EndComp
Text GLabel 870  5210 0    60   Input ~ 0
a15
Text GLabel 870  5410 0    60   Input ~ 0
a14
$Comp
L 74LS32 U4
U 2 1 5753A115
P 1470 5940
F 0 "U4" H 1470 5990 50  0000 C CNN
F 1 "74LS32" H 1470 5890 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1470 5940 50  0000 C CNN
F 3 "" H 1470 5940 50  0000 C CNN
	2    1470 5940
	1    0    0    -1  
$EndComp
Text GLabel 870  6040 0    60   Input ~ 0
mreq
Text GLabel 9850 5400 0    60   Input ~ 0
mreq
$Comp
L 74LS32 U4
U 4 1 5753B687
P 1360 3250
F 0 "U4" H 1360 3300 50  0000 C CNN
F 1 "74LS32" H 1360 3200 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 1360 3250 50  0000 C CNN
F 3 "" H 1360 3250 50  0000 C CNN
	4    1360 3250
	1    0    0    -1  
$EndComp
$Comp
L 74LS32 U4
U 3 1 5753BB5C
P 4900 4630
F 0 "U4" H 4900 4680 50  0000 C CNN
F 1 "74LS32" H 4900 4580 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 4900 4630 50  0000 C CNN
F 3 "" H 4900 4630 50  0000 C CNN
	3    4900 4630
	1    0    0    -1  
$EndComp
Text GLabel 760  3150 0    60   Input ~ 0
a6
Text GLabel 760  3350 0    60   Input ~ 0
a7
Text GLabel 9850 5300 0    60   Input ~ 0
iorq
$Comp
L 7400 U6
U 1 1 5753C5C1
P 3350 4100
F 0 "U6" H 3350 4150 50  0000 C CNN
F 1 "7400" H 3350 4000 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 3350 4100 50  0000 C CNN
F 3 "" H 3350 4100 50  0000 C CNN
	1    3350 4100
	1    0    0    -1  
$EndComp
$Comp
L 7400 U6
U 2 1 5753C8C6
P 3340 4670
F 0 "U6" H 3340 4720 50  0000 C CNN
F 1 "7400" H 3340 4570 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 3340 4670 50  0000 C CNN
F 3 "" H 3340 4670 50  0000 C CNN
	2    3340 4670
	1    0    0    -1  
$EndComp
Text GLabel 2740 4770 0    60   Input ~ 0
reset
Text GLabel 9850 6250 0    60   Input ~ 0
reset
Text GLabel 6910 3070 0    60   Input ~ 0
mreq
Text GLabel 6910 3270 0    60   Input ~ 0
rd
Text GLabel 9850 5700 0    60   Input ~ 0
wr
Text GLabel 6910 3370 0    60   Input ~ 0
wr
$Comp
L 74LS138 U7
U 1 1 5754484B
P 2720 2900
F 0 "U7" H 2820 3400 50  0000 C CNN
F 1 "74LS138" H 2870 2351 50  0000 C CNN
F 2 "Housings_DIP:DIP-16_W7.62mm" H 2720 2900 50  0000 C CNN
F 3 "" H 2720 2900 50  0000 C CNN
	1    2720 2900
	1    0    0    -1  
$EndComp
Text GLabel 2120 3150 0    60   Input ~ 0
a5
Text GLabel 2120 2750 0    60   Input ~ 0
a4
Text GLabel 2120 2650 0    60   Input ~ 0
a3
Text GLabel 2120 2550 0    60   Input ~ 0
a2
$Comp
L VCC #PWR04
U 1 1 57545761
P 2120 3050
F 0 "#PWR04" H 2120 2900 50  0001 C CNN
F 1 "VCC" H 2120 3200 50  0000 C CNN
F 2 "" H 2120 3050 50  0000 C CNN
F 3 "" H 2120 3050 50  0000 C CNN
	1    2120 3050
	1    0    0    -1  
$EndComp
$Comp
L 7400 U6
U 3 1 57546011
P 4140 2650
F 0 "U6" H 4140 2700 50  0000 C CNN
F 1 "7400" H 4140 2550 50  0000 C CNN
F 2 "Housings_DIP:DIP-14_W7.62mm" H 4140 2650 50  0000 C CNN
F 3 "" H 4140 2650 50  0000 C CNN
	3    4140 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 1000 9850 1100
Wire Wire Line
	9710 5900 9850 5900
Wire Wire Line
	6280 5470 6910 5470
Wire Wire Line
	2070 5310 2070 5600
Wire Wire Line
	2070 5600 870  5600
Wire Wire Line
	870  5600 870  5840
Wire Wire Line
	3950 4100 3950 4400
Wire Wire Line
	2740 4400 4300 4400
Wire Wire Line
	2740 4400 2740 4570
Wire Wire Line
	3940 4670 3940 4460
Wire Wire Line
	3940 4460 3650 4460
Wire Wire Line
	3650 4460 3650 4340
Wire Wire Line
	3650 4340 2750 4340
Wire Wire Line
	2750 4340 2750 4200
Wire Wire Line
	4300 4400 4300 4530
Connection ~ 3950 4400
Wire Wire Line
	2070 5940 2170 5940
Wire Wire Line
	2170 5940 2170 5060
Wire Wire Line
	2170 5060 4300 5060
Wire Wire Line
	4300 5060 4300 4730
Wire Wire Line
	5500 3170 5500 5770
Wire Wire Line
	5500 5770 6910 5770
Connection ~ 5500 4630
Wire Wire Line
	5500 3170 6910 3170
Wire Wire Line
	2120 3250 1960 3250
Wire Wire Line
	3320 2550 3540 2550
Wire Wire Line
	3500 2550 3500 2750
Wire Wire Line
	3500 2750 3540 2750
Connection ~ 3500 2550
Wire Wire Line
	4740 2650 4740 3620
Wire Wire Line
	4740 3620 2750 3620
Wire Wire Line
	2750 3620 2750 4000
$EndSCHEMATC
