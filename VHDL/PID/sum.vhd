----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 20:24:47
-- Design Name: 
-- Module Name: sum - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sum is
PORT (
		sumIn1 : in STD_LOGIC_VECTOR (31 downto 0);
		sumIn2 : in STD_LOGIC_VECTOR (31 downto 0);
		sumOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end sum;

architecture Behavioral of sum is

begin
    
    sumOut <= sumIn1 + sumIn2;
end Behavioral;
