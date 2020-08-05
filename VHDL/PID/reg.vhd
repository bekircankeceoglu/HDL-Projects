----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 20:20:10
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
PORT (
        clkReg  : in STD_LOGIC;
        rst : in STD_LOGIC;
		d_in : in STD_LOGIC_VECTOR (31 downto 0);
		dout : out STD_LOGIC_VECTOR (31 downto 0)
    );
end reg;

architecture Behavioral of reg is

begin
process(clkReg) is
		begin
			if rising_edge(clkReg) then
			     if rst = '1' then
			         dout <= (others => '0');
			     else
			         dout <= d_in;
			     end if;
			end if;
		end process;

end Behavioral;
