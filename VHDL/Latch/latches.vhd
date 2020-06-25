-- Flip flop with
-- Rising ed clock

library IEEE;
use IEEE.std_logic_1164.all;

entity latches is
	port(
		G, D, CLR : in std_logic;
		Q		  : out  std_logic
	);
end entity;

architecture rt1 of latches is
	
begin
	process(G, D, CLR)
	begin
		if (CLR = '1') then
			Q <= '0';
		elsif (G = '1') then
			Q <= D;
		end if;
	end process;
	
end architecture;