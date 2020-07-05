----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2020 22:59:31
-- Design Name: 
-- Module Name: SHIFT_REGTB - Behavioral
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

entity SHIFT_REGTB is
--  Port ( );
end SHIFT_REGTB;

architecture Behavioral of SHIFT_REGTB is
    component SHIFT_REG
        Port ( 
            DIN : in STD_LOGIC;
            SHIFT_EN : in STD_LOGIC;
            CLK : in STD_LOGIC;
            DOUT : out STD_LOGIC
        );
    end component;
    
    signal DIN : std_logic := '0';
    signal SHIFT_EN : std_logic := '0';
    signal CLK : std_logic := '0';
    signal DOUT : std_logic := '0';
    
begin
    uut: SHIFT_REG port map(
        DIN => DIN,
        SHIFT_EN  => SHIFT_EN,
        CLK => CLK,
        DOUT => DOUT
    );
    
    -- simulate clk source
    tb_clk: process
    begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    end process;
    
    -- simulate shifter
    tb_shftreg: process
    begin
    SHIFT_EN <= '0';
    wait for 50 ns;
    SHIFT_EN <= '1';
    wait for 10 ns;
    DIN <= '1';
    wait for 6000 ns;    
    SHIFT_EN <= '0';
    wait;
    end process;
    
end Behavioral;
