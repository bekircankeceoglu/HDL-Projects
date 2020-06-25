-- Flip flop with
-- Rising ed clock

library IEEE;
use IEEE.std_logic_1164.all;

entity registers_1tb is
	
end entity;

architecture sim of registers_1tb is
	
	component registers_1
		port(
		clr, ce, clk : in std_logic;
		d_in 		 : in std_logic_vector(7 downto 0);
		dout		 : out std_logic_vector(7 downto 0)
		);
	end component;
	
	-- inputs
	signal clr :  std_logic := '0'; 
	signal ce  :  std_logic := '0';  
	signal clk :  std_logic := '0';
	signal d_in 		 :  std_logic_vector(7 downto 0) := (others => '0');
	
	-- outputs
	signal dout		 :  std_logic_vector(7 downto 0) := (others => '0');
	
begin
	
	uut : registers_1 port map(
		clr => clr,
		ce => ce,
		clk => clk,
		d_in => d_in,
		dout => dout
	);
	
	clock : process 
	begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	
	end process;
	
	tb : process 
	begin
		
		d_in <= "00000001";
		wait for 10 ns;
		ce <= '1';
		wait for 10 ns;
		
	end process;
	
end architecture;