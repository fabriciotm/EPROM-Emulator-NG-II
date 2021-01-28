----------------------------------------------------------------------------------
-- Company:					DL2DW 
-- Engineer: 				Dirk Wouters
-- 
-- Create Date:    		19:39:08 11/18/2020 
-- Design Name:			Eprom Emulator NG II
-- Module Name:			eprom_emulator_ng - dl2dw 
-- Project Name: 			Savannah Module IV
-- Target Devices: 		XC95144XL-10TQ100
-- Tool versions: 		Web ISE 14.7
-- Description: 			Replacement for the single TTL devices of the project 
--								"EPROM Emulator NG" by Kris Sekula (https://github.com/Kris-Sekula/EPROM-EMU-NG)
--								and integration into a CPLD. 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 				0.01 - File Created
-- Revision					0.1  - First Alpha Release
-- Revision					0.2  - Adaptations to PCB version 1.0a
-- Revision					0.3  - Code optimizations
-- Revision					0.4  - Adaptations to PCB version 1.2a
-- Revision					0.5  - Adaptations for ATMega Unified Version '2.0rc3unified'
-- Revision					1.0  - Error correction with external reset line
-- Additional Comments: 
-- License:					© 2020-2021 by Dirk Wouters, DL2DW
--
--								This hardware design is licensed under
--								TAPR Open Hardware License v1.0 (TAPR-OHL-1.0)
--
--								https://spdx.org/licenses/TAPR-OHL-1.0.html
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity eprom_emulator_ng is

		port		(
		
					EN_RST							:	in		std_logic;										-- Enable Reset
					data								:	in		std_logic;										-- Data lines
					adLo								:	in		std_logic;										-- Address lines LSB
					adHi								:	in		std_logic;										-- Address lines MSB
					DATA_LD							:	in		std_logic;										-- Latch storage register
					SCLK								:	in		std_logic;										-- clk for shift register
					EN_A								:	in		std_logic_vector (15 downto 11);
					RAM_D								:	inout	std_logic_vector (7 downto 0);			-- Data lines for RAM
					RAM_A								:	out	std_logic_vector (16 downto 0);			-- address lines for RAM
					RAM_CS							:	out	std_logic;										-- ChipSelect for RAM
					RESET								:	out	std_logic;										-- High Active Reset line
					EPROM_D							:	out	std_logic_vector (7 downto 0);			-- Data lines to the emulated EPROM
					EPROM_A							:	in		std_logic_vector (15 downto 0);			-- Address lines to the emulated EPROM
					EPROM_CS							:	in		std_logic;										-- /CS Line to the emulated EPROM
					EPROM_OE							:	in		std_logic;										-- /OE Line to the emulated EPROM
					EPROM_RESET						:	out	std_logic;										-- RESET Line to the emulated EPROM
					EPROM_N_RESET					:	out	std_logic;										-- /RESET Line to the emulated EPROM (low active)
					RAM_WE_CTRL						:	in		std_logic;										-- /WE Signal for RAM, coming from ATMega
					RAM_WE							:	out	std_logic;										-- /WE Signal for RAM from CPLD to RAM
					CPLD_ENABLE						:	in		std_logic;										-- Enable control signal for CPLD
					readyLED							:	out	std_logic;										-- Ready LED
					Spare1							:	out	std_logic
					
					);
					
end eprom_emulator_ng;

architecture dl2dw of eprom_emulator_ng is

		signal	dataSR							:	std_logic_vector (7 downto 0);					-- shift register for D0-D7
		signal	adLoSR							:	std_logic_vector (7 downto 0);					-- shift register for A0-A7
		signal	adHiSR							:	std_logic_vector (7 downto 0);					-- shift register for A8-A15
		signal	D									:	std_logic_vector (7 downto 0);					-- Data lines D0-D7
		signal	A									:	std_logic_vector (15 downto 0);					-- Address lines A0-A15
		signal	epromEna							:	std_logic := '1';										-- If HIGH, then the simulated EPROM is accessed
		
begin

		ShiftStage : process (SCLK)																			-- shift register, loading data from ATMega32u4
		begin
				if (rising_edge(SCLK)) then
						dataSR <= dataSR (dataSR'high - 1 downto dataSR'low) & data;				-- SR for Data
						adLoSR <= adLoSR (adLoSR'high - 1 downto adLoSR'low) & adLo;				-- SR for LSB addresses
						adHiSR <= adHiSR (adHiSR'high - 1 downto adHiSR'low) & adHi;				-- SR for MSB addresses
				end if;
		end process ShiftStage;

		StorageStage : process (DATA_LD, EN_RST)															--	storage register (latch)
		begin
				if (EN_RST = '1') then																			-- if "Enable Reset" is HIGH, then takeover 
						if (rising_edge(DATA_LD)) then
								D <= dataSR;
								A <= adHiSR & adLoSR;
						end if;
				elsif  (EN_RST = '0') then																		-- otherwise nothing...
						D <= (others => 'Z');
						A <= (others => 'Z');
				end if;
		end process StorageStage;
		
		RAM_D <= D when (epromEna = '0' and CPLD_ENABLE = '0') else (others => 'Z');
		RAM_A(10 downto 0) <= A (10 downto 0) when (CPLD_ENABLE = '0') else (others => 'Z');

		highMem : for i in RAM_A'high - 1 downto 11 generate
				RAM_A(i) <= A(i) and EN_A(i);
		end generate highMem;

		epromEna <= (not EPROM_OE) and (not EPROM_CS) and (not EN_RST);

		RAM_A(10 downto 0) <= EPROM_A(10 downto 0) when (epromEna = '1' and CPLD_ENABLE = '0') else (others => 'Z');
		A(15 downto 11) <= EPROM_A(15 downto 11) when (epromEna = '1' and CPLD_ENABLE = '0') else (others => 'Z');

		EPROM_D <= RAM_D when (epromEna = '1' and CPLD_ENABLE = '0') else (others => 'Z');

		RESET <= EN_RST when (CPLD_ENABLE = '0') else 'Z';
		EPROM_RESET <= EN_RST when (CPLD_ENABLE = '0') else 'Z';
		EPROM_N_RESET <= not EN_RST when (CPLD_ENABLE = '0') else 'Z';

		RAM_CS <= '0' when (CPLD_ENABLE = '0') else 'Z';
		RAM_WE <= RAM_WE_CTRL when (CPLD_ENABLE = '0') else 'Z';
		
		RAM_A(RAM_A'high) <= '0';

		readyLED <= not CPLD_ENABLE;
		
		Spare1 <= '0';
		
end dl2dw;