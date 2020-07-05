----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 02:12:02 PM
-- Design Name: 
-- Module Name: ADDER - Behavioral
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

entity ADDER is
    PORT (
        adderIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        adderOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
end ADDER;

architecture Behavioral of ADDER is
    signal data1 : integer;
    signal data2 : integer;
    signal dataSum : integer;
begin
    data1 <= CONV_INTEGER(adderIn(11 downto 8));
    data2 <= CONV_INTEGER(adderIn(15 downto 12));
    dataSum <= data1 + data2;
    adderOut <= (CONV_STD_LOGIC_VECTOR(dataSum, 8) & adderIn(7 downto 0));
end Behavioral;
