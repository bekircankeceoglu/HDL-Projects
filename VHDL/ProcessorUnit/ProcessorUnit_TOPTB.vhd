----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 02:32:17 PM
-- Design Name: 
-- Module Name: ProcessorUnit_TOPTB - Behavioral
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

entity ProcessorUnit_TOPTB is
--  Port ( );
end ProcessorUnit_TOPTB;

architecture Behavioral of ProcessorUnit_TOPTB is

COMPONENT ProcessorUnit_TOP
    PORT (
           dinTop : in STD_LOGIC_VECTOR(15 downto 0);
           wr_rstTop : in STD_LOGIC;
           rd_rstTop : in STD_LOGIC;
           wr_clkTop : in STD_LOGIC;
           rd_clkTop : in STD_LOGIC;
           wr_e1Top : in STD_LOGIC;
           rd_e1Top : in STD_LOGIC;
           wr_e2Top : in STD_LOGIC;
           rd_e2Top : in STD_LOGIC;
           doutTop : out STD_LOGIC_VECTOR(15 downto 0)
     );
end COMPONENT;

signal dinTop : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
signal wr_rstTop : STD_LOGIC := '0';
signal rd_rstTop : STD_LOGIC := '0';
signal wr_clkTop : STD_LOGIC := '0';
signal rd_clkTop : STD_LOGIC := '0';
signal wr_e1Top : STD_LOGIC := '0';
signal rd_e1Top : STD_LOGIC := '0';
signal wr_e2Top : STD_LOGIC := '0';
signal rd_e2Top : STD_LOGIC := '0';
signal doutTop : STD_LOGIC_VECTOR(15 downto 0) := x"0000";

begin

uut : ProcessorUnit_TOP
  PORT MAP (
    dinTop => dinTop,
    wr_rstTop => wr_rstTop,
    rd_rstTop => rd_rstTop,
    wr_clkTop => wr_clkTop,
    rd_clkTop => rd_clkTop,
    wr_e1Top => wr_e1Top,
    rd_e1Top => rd_e1Top,
    wr_e2Top => wr_e2Top,
    rd_e2Top => rd_e2Top,
    doutTop => doutTop
  );

clk1: process
begin
wr_clkTop <= '1';
wait for 10 ns;
wr_clkTop <= '0';
wait for 10 ns;
end process;

clk2: process
begin
rd_clkTop <= '1';
wait for 5 ns;
rd_clkTop <= '0';
wait for 5 ns;
end process;

test: process
begin
wr_rstTop <= '1';
rd_rstTop <= '1';
wr_e1Top <= '0';
rd_e1Top <= '0';
wr_e2Top <= '0';
rd_e2Top <= '0';
wait for 100 ns;
wr_rstTop <= '0';
rd_rstTop <= '0';
wr_e1Top <= '1';
rd_e1Top <= '0';
wr_e2Top <= '1';
rd_e2Top <= '0';
dinTop <= x"11AA";
wait for 200 ns;
wr_e1Top <= '0';
rd_e1Top <= '1';
wr_e2Top <= '1';
rd_e2Top <= '1';
wait for 100 ns;
wr_e1Top <= '1';
rd_e1Top <= '0';
wr_e2Top <= '1';
rd_e2Top <= '0';
dinTop <= x"1155";
wait for 100 ns;
wr_e1Top <= '0';
rd_e1Top <= '1';
wr_e2Top <= '1';
rd_e2Top <= '1';
wait;
end process;

end Behavioral;
