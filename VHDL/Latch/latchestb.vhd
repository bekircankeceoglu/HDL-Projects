-- Flip flop with
-- Rising ed clock

library IEEE;
use IEEE.std_logic_1164.all;

entity latchestb is

end entity;

architecture sim1 of latchestb is

	component latches
	port(
		G, D, CLR : in std_logic;
		Q		  : out  std_logic
	);
	end component;
	
	--inputs
	signal G : std_logic := '0';
	signal D : std_logic := '0';
	signal CLR : std_logic := '0'; 
	-- outputs
	signal Q : std_logic := '0';
	
begin

	uut : latches port map(
		G => G,
		D => D,
		CLR => CLR,
		Q => Q
	);
	
	tb : process
	begin
		
		D <= '0';
		wait for 10 ns;
		G <= '1';
		wait for 10 ns;
		D <= '1';
		wait for 50 ns;
		CLR <= '1';
		wait for 10 ns;
		
	end process;

end architecture;