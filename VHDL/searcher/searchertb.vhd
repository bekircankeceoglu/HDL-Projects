----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2020 15:59:48
-- Design Name: 
-- Module Name: soru1tb - Behavioral
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

entity searchertb is
--  Port ( );
end searchertb;

architecture Behavioral of searchertb is
    
    component searcher
        port(
            Ain  :  in std_logic;
            Aout : out std_logic
        );
    end component;
    
    signal Ain : std_logic := '0';
    signal Aout : std_logic := '0';
    
begin

    uut : searcher port map(
		Ain  => Ain,
		Aout => Aout
	);
    
    tb : process
    begin
        Ain <= '0';
        wait for 10 ns;
        Ain <= '1';
        wait for 10 ns;
        Ain <= '0';
        wait for 10 ns;
        Ain <= '1';
        wait for 10 ns;
        Ain <= '0';
        wait for 10 ns;
        Ain <= '1';
        wait for 10 ns;
        Ain <= '0';
        wait for 10 ns;
        Ain <= '1';
        wait for 10 ns;
        Ain <= '0';
        wait for 10 ns;
        wait;
    end process;
    
end Behavioral;
