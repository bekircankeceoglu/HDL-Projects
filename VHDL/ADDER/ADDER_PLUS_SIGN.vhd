----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2020 23:37:17
-- Design Name: 
-- Module Name: ADDER_PLUS_SIGN - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDER_PLUS_SIGN is
    Port ( A_IN : in STD_LOGIC_VECTOR (255 downto 0);
           B_IN : in STD_LOGIC_VECTOR (255 downto 0);
           SUM_OUT : out STD_LOGIC_VECTOR (255 downto 0);
           CARRY_OUT : out STD_LOGIC);
end ADDER_PLUS_SIGN;
 
architecture Behavioral of ADDER_PLUS_SIGN is
    component FA_PLUS is
        Port ( A_IN : in STD_LOGIC_VECTOR (31 downto 0);
               B_IN : in STD_LOGIC_VECTOR (31 downto 0);
               CARRY_IN : in STD_LOGIC;
               SUM_OUT : out STD_LOGIC_VECTOR (31 downto 0);
               CARRY_OUT : out STD_LOGIC);
    end component;
    Signal TEMP_CARRY : STD_LOGIC_VECTOR (3 downto 0);
begin
    FA0 : FA_PLUS port map(
        A_IN=>A_IN(31 downto 0),
        B_IN=>B_IN(31 downto 0),
        CARRY_IN=>'0',
        SUM_OUT=>SUM_OUT(31 downto 0),
        CARRY_OUT=>TEMP_CARRY(0));
    FA1 : FA_PLUS port map(
        A_IN=>A_IN(63 downto 32),
        B_IN=>B_IN(63 downto 32),
        CARRY_IN=>TEMP_CARRY(0),
        SUM_OUT=>SUM_OUT(63 downto 32),
        CARRY_OUT=>TEMP_CARRY(1));
    FA2 : FA_PLUS port map(
        A_IN=>A_IN(95 downto 64),
        B_IN=>B_IN(95 downto 64),
        CARRY_IN=>TEMP_CARRY(1),
        SUM_OUT=>SUM_OUT(95 downto 64),
        CARRY_OUT=>TEMP_CARRY(2));
    FA3 : FA_PLUS port map(
        A_IN=>A_IN(127 downto 96),
        B_IN=>B_IN(127 downto 96),
        CARRY_IN=>TEMP_CARRY(2),
        SUM_OUT=>SUM_OUT(127 downto 96),
        CARRY_OUT=>TEMP_CARRY(3));
    FA4 : FA_PLUS port map(
        A_IN=>A_IN(159 downto 128),
        B_IN=>B_IN(159 downto 128),
        CARRY_IN=>TEMP_CARRY(3),
        SUM_OUT=>SUM_OUT(159 downto 128),
        CARRY_OUT=>TEMP_CARRY(4));     
    FA5 : FA_PLUS port map(
        A_IN=>A_IN(191 downto 160),
        B_IN=>B_IN(191 downto 160),
        CARRY_IN=>TEMP_CARRY(4),
        SUM_OUT=>SUM_OUT(191 downto 160),
        CARRY_OUT=>TEMP_CARRY(5));
    FA6 : FA_PLUS port map(
        A_IN=>A_IN(223 downto 192),
        B_IN=>B_IN(223 downto 192),
        CARRY_IN=>TEMP_CARRY(5),
        SUM_OUT=>SUM_OUT(223 downto 192),
        CARRY_OUT=>TEMP_CARRY(6));
    FA7 : FA_PLUS port map(
        A_IN=>A_IN(255 downto 224),
        B_IN=>B_IN(25 downto 224),
        CARRY_IN=>TEMP_CARRY(6),
        SUM_OUT=>SUM_OUT(25 downto 224),
        CARRY_OUT=>TEMP_CARRY(7));
    CARRY_OUT <= TEMP_CARRY(7);
end Behavioral;
