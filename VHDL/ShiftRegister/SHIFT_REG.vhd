----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2020 22:54:53
-- Design Name: 
-- Module Name: SHIFT_REG - Behavioral
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

entity SHIFT_REG is
    Port ( DIN : in STD_LOGIC;
           SHIFT_EN : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DOUT : out STD_LOGIC);
end SHIFT_REG;

architecture Behavioral of SHIFT_REG is
    signal shiftReg : std_logic_vector(255 downto 0) := (others => '0');
begin
       
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (SHIFT_EN = '1') then
                shiftReg <= shiftReg(254 downto 0) & DIN;
            end if;
        end if;
    end process;
    DOUT <= shiftReg(255);
end Behavioral;
