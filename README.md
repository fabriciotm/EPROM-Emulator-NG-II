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



# Status

**PCB**:						Version 1.2A developed, ordered and available in the repository

**BOM:**					must still be created

**CPLD-Code:**		in progress

**Case:**					in progress



# Preview

**PCB Version 1.2D**

![](https://github.com/DL2DW/EPROM-Emulator-NG-II/blob/main/images/pcb_preview.jpg)



**Case for 3D printing**

![](https://github.com/DL2DW/EPROM-Emulator-NG-II/blob/main/images/case_preview.jpg)



# License

The contents of this repository excluding [`Third_Party` directory](https://github.com/DL2DW/EPROM-Emulator-NG-II/third_party) is released under your choice of the following two licences:

- the "Creative Commons Attribution-ShareAlike 4.0 International License" (CC BY-SA 4.0) full text of this license is included in the [LICENSE.CC-BY-SA-4.0](https://github.com/im-tomu/tomu-hardware/blob/master/LICENSE.CC-BY-SA-4.0) file and a copy can also be found at http://creativecommons.org/licenses/by-sa/4.0/
- the "TAPR Open Hardware License" full text of this license is included in the [LICENSE.TAPR](https://github.com/im-tomu/tomu-hardware/blob/master/LICENSE.TAPR) file and a copy can also be found at http://www.tapr.org/OHL

