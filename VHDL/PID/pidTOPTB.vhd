----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 21:31:34
-- Design Name: 
-- Module Name: pidTOPTB - Behavioral
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
library ieee_proposed;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pidTOPTB is
--  Port ( );
end pidTOPTB;

architecture Behavioral of pidTOPTB is

    component pidTOP
    PORT (
		clk        : in STD_LOGIC;
		rst        : in STD_LOGIC;
		q0   	   : in STD_LOGIC_VECTOR (31 downto 0);	-- kp parametresi (signed).
        q1         : in STD_LOGIC_VECTOR (31 downto 0);	-- ki parametresi (signed).
        q2         : in STD_LOGIC_VECTOR (31 downto 0);-- kd parametresi (signed).
        w          : in STD_LOGIC_VECTOR (31 downto 0);
        y          : in STD_LOGIC_VECTOR (31 downto 0);
        pid_result : out STD_LOGIC_VECTOR (31 downto 0)
	);
    end component;
    
    --inputs
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal q0 : STD_LOGIC_VECTOR (31 downto 0) := x"00000001";
    signal q1 : STD_LOGIC_VECTOR (31 downto 0) := x"00000001";
    signal q2 : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
    signal w : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
    signal y : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
    signal pid_result : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
begin
    
    uut : pidTOP port map(
		clk => clk,
		rst => rst,
		q0 => q0,
		q1 => q1,
		q2 => q2,
		w => w,
		y => y,
		pid_result => pid_result
	);
    
    reset : process 
	begin
		rst <= '1';
		wait for 20 ms;
		rst <= '0';
		wait;
	
	end process;
    
    clock : process 
	begin
		clk <= '0';
		wait for 10 ms;
		clk <= '1';
		wait for 10 ms;
	
	end process;
	
	tb : process 
	begin
		
		w <= x"0000000A";
		y <= pid_result;
		wait for 10 ns;
	end process;
end Behavioral;
