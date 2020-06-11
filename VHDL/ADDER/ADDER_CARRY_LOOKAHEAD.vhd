----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2020 23:17:57
-- Design Name: 
-- Module Name: ADDER_CARRY_LOOKAHEAD - Behavioral
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

entity ADDER_CARRY_LOOKAHEAD is
    Port ( A_IN : in STD_LOGIC_VECTOR (255 downto 0);
           B_IN : in STD_LOGIC_VECTOR (255 downto 0);
           SUM_OUT : out STD_LOGIC_VECTOR (255 downto 0);
           CARRY_OUT : out STD_LOGIC);
end ADDER_CARRY_LOOKAHEAD;

architecture Behavioral of ADDER_CARRY_LOOKAHEAD is
    component  FA_WS is
       Port ( a : in STD_LOGIC;
              b : in STD_LOGIC;
              c_in : in STD_LOGIC;
              s : out STD_LOGIC;
              c_out : out STD_LOGIC);
    end component;
    
    Signal C : STD_LOGIC_VECTOR (255 downto 0);
begin
    C(0) <= '0';
    
    GEN1 : for i in 0 to 255 generate begin
        U : FA_WS port map(
            a=>A_IN(i),
            b=>B_IN(i),
            c_in=>C(i),
            s=>SUM_OUT(i),
            c_out=>C(i+1));
    end generate GEN1;  
    
    CARRY_OUT <= C(255);

end Behavioral;
