----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.06.2020 23:23:03
-- Design Name: 
-- Module Name: ADDER_CARRY_PROPAGATE_MACRO - Behavioral
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
Library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use UNISIM.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADDER_CARRY_PROPAGATE_MACRO is
    Port ( A_IN : in STD_LOGIC_VECTOR (255 downto 0);
           B_IN : in STD_LOGIC_VECTOR (255 downto 0);
           SUM_OUT : out STD_LOGIC_VECTOR (255 downto 0);
           CARRY_OUT : out STD_LOGIC);
end ADDER_CARRY_PROPAGATE_MACRO;

architecture Behavioral of ADDER_CARRY_PROPAGATE_MACRO is

Signal CARRY : STD_LOGIC_VECTOR (255 downto 0);   
    Signal AXORB : STD_LOGIC_VECTOR (255 downto 0);
begin
 
    GEN1 : for i in 0 to 255 generate begin
        AXORB(i) <= A_IN(i) xor B_IN(i);
    end generate GEN1;
        
    U0 : CARRY4 port map (
        CO => CARRY(3 downto 0), 
        O => SUM_OUT(3 downto 0), 
        CI => '0', 
        CYINIT => '0', 
        DI => B_IN(3 downto 0), 
        S => AXORB(3 downto 0) 
    );
    
    GEN2 : for i in 1 to 15 generate begin
        U : CARRY4 port map (
            CO => CARRY((4*(i+1)-1) downto (4*i)), 
            O => SUM_OUT((4*(i+1)-1) downto (4*i)), 
            CI => CARRY(4*i-1), 
            CYINIT => '0', 
            DI => B_IN((4*(i+1)-1) downto (4*i)), 
            S => AXORB((4*(i+1)-1) downto (4*i)) 
        );
    end generate GEN2;
    
    CARRY_OUT <= CARRY(255); 


end Behavioral;
