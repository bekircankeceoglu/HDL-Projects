----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2020 19:40:27
-- Design Name: 
-- Module Name: pidTOP - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY pidTOP IS
	PORT (
		clk        : in STD_LOGIC;
		rst        : in STD_LOGIC;
		q0   	   : in STD_LOGIC_VECTOR (31 downto 0);	-- kp parametresi (signed).
        q1         : in STD_LOGIC_VECTOR (31 downto 0);	-- ki parametresi (signed).
        q2         : in STD_LOGIC_VECTOR (31 downto 0);	-- kd parametresi (signed).
        w          : in STD_LOGIC_VECTOR (31 downto 0);
        y          : in STD_LOGIC_VECTOR (31 downto 0);
        pid_result : out STD_LOGIC_VECTOR (31 downto 0)
	);
END pidTOP;

architecture Behavioral of pidTOP is

component reg
    PORT (
        clkReg  : in STD_LOGIC;
        rst :  in STD_LOGIC;
		d_in : in STD_LOGIC_VECTOR (31 downto 0);
		dout : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component compl
    PORT (
		complIn : in STD_LOGIC_VECTOR (31 downto 0);
		complOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component sum
    PORT (
		sumIn1 : in STD_LOGIC_VECTOR (31 downto 0);
		sumIn2 : in STD_LOGIC_VECTOR (31 downto 0);
		sumOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

component mult
    PORT (
		multIn1 : in STD_LOGIC_VECTOR (31 downto 0);
		multIn2 : in STD_LOGIC_VECTOR (31 downto 0);
		multOut : out STD_LOGIC_VECTOR (31 downto 0)
    );
end component;

signal y_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal minusy_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal ek_0_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal ek_1_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal ek_2_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal p0_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal p1_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal p2_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal s1_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal s2_Signal : STD_LOGIC_VECTOR (31 downto 0);
signal uk_0_Signal : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";
signal uk_1_Signal : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";

begin

   

reg1: entity work.reg
    port map(
        clkReg  => clk,
        rst => rst,
		d_in => y,
		dout => y_Signal
    );
    
compl2: entity work.compl
    port map(
        complIn => y_Signal,
		complOut => minusy_Signal
    );   
  
sum1: entity work.sum
    port map(
        sumIn1 => w,
		sumIn2 => minusy_Signal,
		sumOut => ek_0_Signal
    );    
    
reg2: entity work.reg
    port map(
        clkReg  => clk,
        rst => rst,
		d_in => ek_0_Signal,
		dout => ek_1_Signal
    );    

reg4: entity work.reg
    port map(
        clkReg  => clk,
        rst => rst,
		d_in => ek_1_Signal,
		dout => ek_2_Signal
    ); 

mult1: entity work.mult
    port map(
        multIn1 => q0,
		multIn2 => ek_0_Signal,
		multOut => p0_Signal
    ); 

mult2: entity work.mult
    port map(
        multIn1 => ek_1_Signal,
		multIn2 => q1,
		multOut => p1_Signal
    ); 

mult3: entity work.mult
    port map(
        multIn1 => ek_2_Signal,
		multIn2 => q2,
		multOut => p2_Signal
    ); 
 
sum2: entity work.sum
   port map(
        sumIn1 => p0_Signal,
		sumIn2 => p1_Signal,
		sumOut => s1_Signal
   );

sum3: entity work.sum
   port map(
        sumIn1 => p2_Signal,
		sumIn2 => uk_1_Signal,
		sumOut => s2_Signal
   );
 
sum4: entity work.sum
  port map(
        sumIn1 => s1_Signal,
		sumIn2 => s2_Signal,
		sumOut => uk_0_Signal
  );
  
reg3: entity work.reg
    port map(
        clkReg  => clk,
        rst => rst,
		d_in => uk_0_Signal,
		dout => uk_1_Signal
    );
    
reg5: entity work.reg
        port map(
            clkReg  => clk,
            rst => rst,
            d_in => uk_0_Signal,
            dout => pid_result
        );    
  

end Behavioral;
