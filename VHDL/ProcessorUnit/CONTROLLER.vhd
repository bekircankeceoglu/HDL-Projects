----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 02:26:59 PM
-- Design Name: 
-- Module Name: CONTROLLER - Behavioral
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

entity CONTROLLER is
    PORT (
        dataInController : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        emptyFIFOIn : IN STD_LOGIC;
        emptyFIFOOut : IN STD_LOGIC;
        fullFIFOIn : IN STD_LOGIC;
        fullFIFOOut : IN STD_LOGIC;
        wr_clk : IN STD_LOGIC;
        rd_clk : IN STD_LOGIC;
        controllerSelect : OUT STD_LOGIC
    );
end CONTROLLER;

architecture Behavioral of CONTROLLER is

begin

    process(rd_clk)
    begin
        if (dataInController(7 downto 0) = x"AA") then
            controllerSelect <= '0';
        elsif (dataInController(7 downto 0) = x"55") then
            controllerSelect <= '1';
        end if;
    end process;
end Behavioral;
