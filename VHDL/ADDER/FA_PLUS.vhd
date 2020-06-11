----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2020 23:33:09
-- Design Name: 
-- Module Name: FA_PLUS - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FA_PLUS is
    Port ( A_IN : in STD_LOGIC_VECTOR (31 downto 0);
           B_IN : in STD_LOGIC_VECTOR (31 downto 0);
           CARRY_IN : in STD_LOGIC;
           SUM_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           CARRY_OUT : out STD_LOGIC);
end FA_PLUS;

architecture Behavioral of FA_PLUS is
Signal A : integer;
    Signal B : integer;
    Signal CARRY : integer;
    Signal SUM : integer;
    Signal TEMP_SUM : STD_LOGIC_VECTOR (16 downto 0);
begin
    A <= CONV_INTEGER(A_IN);
    B <= CONV_INTEGER(B_IN);
    CARRY <= CONV_INTEGER(CARRY_IN);
    SUM <= A + B + CARRY;
    TEMP_SUM <= CONV_STD_LOGIC_VECTOR(SUM, 32);
    SUM_OUT <= TEMP_SUM(31 downto 0);
    CARRY_OUT <= TEMP_SUM(32);
end Behavioral;
