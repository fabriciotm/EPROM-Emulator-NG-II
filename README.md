![](https://img.shields.io/badge/Status-Prototyp-red)



# EPROM Emulator NG II

Based on the project by Kris Sekula:

**GitHub**: https://github.com/Kris-Sekula/EPROM-EMU-NG

**Website**: https://mygeekyhobby.com/2020/07/05/eprom-emulator/

**User-Group**: https://groups.io/g/eprom-emu-ng



I developed a version where the TTL logic was replaced by a CPLD. This made the circuit much smaller. 

Instead of the Arduino Nano I directly integrated an ATMega32u4. This is flashed with the bootloader of the Arduino Micro (Using a simple ISP programmer). After that, the firmware can be flashed via USB at any time using the Arduino IDE.

For the CPLD part a JTAG programmer is needed at the moment. A simple open source JTAG tool based on the FTDI FT2232H is sufficient. With the help of [OpenOCD](http://openocd.org/) the SVF file can be flashed. The Xilinx tools are not needed for this.

To go with it, I designed a case that can be made on a 3D printer. For this purpose, I have kept the housing as simple as possible.



# BOM



| No#  | Designator           | Part                                           | Description                                                  |
| ---- | -------------------- | ---------------------------------------------- | ------------------------------------------------------------ |
| 1    | U1                   | Alliance Memory AS6C1008-55STIN                | SRAM Memory, 1048576bit, 2.7  5.5 V, 55ns 32-Pin STSOP       |
| 2    | U2                   | ATMEL ATMEGA32U4-AU                            | MCU, 8BIT, MEGAAVR, 16MHZ, TQFP-44                           |
| 3    | U3                   | Xilinx XC95144XL-10TQ100C                      | IC CPLD 144MC 10NS 100TQFP                                   |
| 4    | U4                   | MaxLinear SPX5205M5-L-3-3/TR                   | LDO Regulator Pos 3.3V 0.15A 5-Pin SOT-23 T/R                |
| 5    | U5                   | Microchip 25LC512-I/SN                         | IC, SM, EEPROM, SERIAL, 512K, SOIC8                          |
| 6    | Q1                   | ON SEMICONDUCTOR MMBT4403LT1G                  | Bipolar (BJT) Single Transistor, PNP, General Purpose, SOT-23-3 |
| 7    | Q2                   | ON SEMICONDUCTOR MMBT4401                      | Bipolar (BJT) Single Transistor, NPN, General Purpose, SOT-23-3 |
| 8    | D2                   | STMICROELECTRONICS TMMBAT48FILM                | Small Signal Schottky Diode, MiniMELF                        |
| 9    | D3                   | WÜRTH ELEKTRONIK 151033RS03000                 | LED, 3MM,  RED, Pitch 2.54mm                                 |
| 10   | D4                   | WÜRTH ELEKTRONIK 151033GS03000                 | LED, 3MM,  GREEN, Pitch 2.54mm                               |
| 11   | D6, D8               | WÜRTH ELEKTRONIK 150060YS55040                 | LED YELLOW DIFFUSED 0603 SMD                                 |
| 12   | D7                   | MCC SS14FL-TP                                  | DIODE SCHOTTKY 40V 1A DO221AC                                |
| 13   | DZ1                  | STMICROELECTRONICS USBLC6-2SC6                 | TVS DIODE 5.25V 17V SOT23-6                                  |
| 14   | Y1                   | Raltron Electronics R2016-16.000-9-1010-TR-NS1 | 16MHz ±10ppm 9pF 200Ω SMD,2.0x1.6mm SMD Crystal              |
| 15   | F1                   | Littlefuse 1206L150THWR                        | PTC RESET FUSE 8V 1.5A 1206                                  |
| 16   | F2                   | Littlefuse 1210L020WR                          | PPTC Resettable Fuse, SMD, POLYFUSE 1210L Series, 200 mA, 400 mA, 30 VDC |
| 17   | C1, C3-C13, C19      | KEMET C0603C104J3RACTU                         | SMD Multilayer Ceramic Capacitor, 0603 [1608 Metric], 0.1 uF, 25 V,  5%, X7R, C Series |
| 18   | C2, C14              | KEMET C0603C105K3RACTU                         | 1F Multilayer Ceramic Capacitor (MLCC) 25 V 10% X7R dielectric C SMD max op. temp. +125C |
| 19   | C15, C16             | KEMET C0603C220J5RACTU                         | Cap Ceramic 22pF 50V X7R 5% SMD 0603 125°C Punched Paper T/R |
| 20   | C17, C18             | KEMET C0805C106K8RACTU                         | CAP, 10µF, 10V, 10%, X7R, 0805                               |
| 21   | R1, R4, R7, R13, R14 | Yageo RC0603FR-071KL                           | RES SMD 1K OHM 1% 1/10W 0603                                 |
| 22   | R2, R3               | Yageo RC0603FR-0722RL                          | RES SMD 22 OHM 1% 1/10W 0603                                 |
| 23   | R5, R6, R9           | Yageo RC0603FR-0710KL                          | RES SMD 10K OHM 1% 1/10W 0603                                |
| 24   | R10, R11             | Yageo RC0603FR-0710RL                          | RES SMD 10 OHM 1% 1/10W 0603                                 |
| 25   | R12                  | Yageo RC0603FR-074K7L                          | RES SMD 4.7K OHM 1% 1/10W 0603                               |
| 26   | CN1                  | Würth Elektronik 629105150521                  | Socket micro-USB B 5P                                        |
| 27   | CN3                  | MPE Garry 369-1-014-0-NTX-KT0                  | Conn Wire to Board HDR 14 POS 1.27mm Solder ST Thru-Hole     |
| 28   | CN4                  | TE Connectivity AMP 5499345-8                  | Conn Ejector Header HDR 34 POS 2.54mm Solder RA Thru-Hole    |
| 29   | SW1                  | ITT C&K RS-282G05A3-SMRT                       | SWITCH TACTILE SPST-NO 0.05A 12V                             |
| 30   | SW2                  | Würth Electronics 430476085716                 | Black Button Tactile Switch, NO 50 mA 5mm Through Hole       |



# Status

- [x] **PCB**: Version 1.2A developed, ordered and available in the repository

- [x] **BOM:** done

- [ ] **CPLD-Code:**	in progress

- [ ] **Case:** in progress



# Preview

**PCB Version 1.2D**

![](https://github.com/DL2DW/EPROM-Emulator-NG-II/blob/main/images/pcb_preview.jpg)



**Case for 3D printing**

![](https://github.com/DL2DW/EPROM-Emulator-NG-II/blob/main/images/case_preview.jpg)



# License

The contents of this repository is released under the following license:

- the "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License" (CC BY-NC-SA 4.0) full text of this license is included in the [LICENSE.CC-NC-BY-SA-4.0](https://github.com/DL2DW/EPROM-Emulator-NG-II/blob/main/LICENSE.CC-NC-BY-SA) file and a copy can also be found at https://creativecommons.org/licenses/by-nc-sa/4.0/

  
