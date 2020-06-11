----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2020 20:54:53
-- Design Name: 
-- Module Name: ADDER_256 - Behavioral
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

entity ADDER_256 is
    Port ( A_IN : in STD_LOGIC_VECTOR (255 downto 0);
           B_IN : in STD_LOGIC_VECTOR (255 downto 0);
           SUM_OUT : out STD_LOGIC_VECTOR (255 downto 0);
           CARRY_OUT : out STD_LOGIC);
end ADDER_256;

architecture Behavioral of ADDER_256 is
    -- component
    component FA is
        Port ( a : in STD_LOGIC;
               b : in STD_LOGIC;
               c_in : in STD_LOGIC;
               s : out STD_LOGIC;
               c_out : out STD_LOGIC);
    end component;
    -- signal declaration
    Signal CARRY : STD_LOGIC_VECTOR (255 downto 0);
    
begin
FA0 : FA port map(
        a=>A_IN(0),
        b=>B_IN(0),
        c_in=>'0',
        s=>SUM_OUT(0),
        c_out=>carry(0));
          
    G : for i in 1 to 255 generate begin
        U : FA port map(
            a=>A_IN(i),
            b=>B_IN(i),
            c_in=>carry(i-1),
            s=>SUM_OUT(i),
            c_out=>carry(i));
    end generate G;
    
    CARRY_OUT <= carry(255);

end Behavioral;
