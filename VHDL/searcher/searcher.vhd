----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2020 15:18:58
-- Design Name: 
-- Module Name: soru1 - Behavioral
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

-- number searcher
entity searcher is
    port(
        Ain  :  in std_logic;
        Aout : out std_logic
    );
end searcher;

architecture Behavioral of searcher is
    type state_type is (clear, found1, found10);
    signal state_reg : state_type;
begin
    
    process(Ain) is
    variable moduleOut : std_logic;
    begin
        case state_reg is
            when clear =>
                if (Ain = '1') then
                    state_reg <= found1;
                end if;
                moduleOut := '0';
            when found1 =>
                if (Ain = '0') then
                    state_reg <= found10;
                elsif (Ain = '1') then
                    state_reg <= found1;
                end if;
                moduleOut := '0';
            when found10 =>
                if (Ain = '0') then
                    state_reg <= clear;
                elsif (Ain = '1') then
                    state_reg <= found1;
                    moduleOut := '1';
                end if;
        end case;        
        Aout <= moduleOut;
    end process;
end Behavioral;
