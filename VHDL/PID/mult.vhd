----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 20:27:53
-- Design Name: 
-- Module Name: mult - Behavioral
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

entity mult is
    PORT (
		multIn1 : in STD_LOGIC_VECTOR (31 downto 0);
		multIn2 : in STD_LOGIC_VECTOR (31 downto 0);
		multOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end mult;

architecture Behavioral of mult is

signal multSignal : integer;

begin

        multSignal <= CONV_INTEGER(multIn1) * CONV_INTEGER(multIn2);
        multOut <= CONV_STD_LOGIC_VECTOR(multSignal, 32);
  
end Behavioral;
