----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 02:20:47 PM
-- Design Name: 
-- Module Name: MULTIPLEXER - Behavioral
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

entity MULTIPLEXER is
    PORT (
        dataSum : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        dataBypass : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        muxSelect : IN STD_LOGIC;
        muxOutData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
end MULTIPLEXER;

architecture Behavioral of MULTIPLEXER is

begin

process(muxSelect)
begin
    case muxSelect is
        when '0' => muxOutData <= dataBypass;
        when '1' => muxOutData <= dataSum;
        when others => muxOutData <= x"0000";
    end case;
end process;

end Behavioral;
