----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 20:21:43
-- Design Name: 
-- Module Name: compl - Behavioral
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

entity compl is
    PORT (
		complIn : in STD_LOGIC_VECTOR (31 downto 0);
		complOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end compl;

architecture Behavioral of compl is
    signal negativeVal : integer;
    signal tempNegativeVal : integer;
begin
    
    negativeVal <= CONV_INTEGER(complIn);
    tempNegativeVal <= -(negativeVal);
    complOut <= CONV_STD_LOGIC_VECTOR(tempNegativeVal, 32);  
end Behavioral;
