----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2020 01:28:38 PM
-- Design Name: 
-- Module Name: ProcessorUnit_TOP - Behavioral
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

entity ProcessorUnit_TOP is
    Port ( dinTop : in STD_LOGIC_VECTOR(15 downto 0);
           wr_rstTop : in STD_LOGIC;
           rd_rstTop : in STD_LOGIC;
           wr_clkTop : in STD_LOGIC;
           rd_clkTop : in STD_LOGIC;
           wr_e1Top : in STD_LOGIC;
           rd_e1Top : in STD_LOGIC;
           wr_e2Top : in STD_LOGIC;
           rd_e2Top : in STD_LOGIC;
           doutTop : out STD_LOGIC_VECTOR(15 downto 0));
end ProcessorUnit_TOP;

architecture Behavioral of ProcessorUnit_TOP is

COMPONENT fifo_generator_0
  PORT (
    wr_clk : IN STD_LOGIC;
    wr_rst : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    rd_rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT ADDER  
    PORT (
        adderIn : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        adderOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END COMPONENT;

COMPONENT MULTIPLEXER  
    PORT (
        dataSum : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        dataBypass : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        muxSelect : IN STD_LOGIC;
        muxOutData : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END COMPONENT;

COMPONENT CONTROLLER  
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
END COMPONENT;

signal doutS : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal full1S : STD_LOGIC;
signal full2S : STD_LOGIC;
signal empty1S : STD_LOGIC;
signal empty2S : STD_LOGIC;
signal adderOutS : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal selectS : STD_LOGIC;
signal muxOutS : STD_LOGIC_VECTOR(15 DOWNTO 0);

begin

FIFO_I : fifo_generator_0
  PORT MAP (
    wr_clk => wr_clkTOP,
    wr_rst => wr_rstTop,
    rd_clk => rd_clkTop,
    rd_rst => rd_rstTop,
    din => dinTop ,
    wr_en => wr_e1Top,
    rd_en => rd_e1Top,
    dout => doutS,
    full => full1S,
    empty => empty1S
  );
  
adr : ADDER
    PORT MAP (
        adderIn => doutS,
        adderOut => adderOutS
    );    

mux : MULTIPLEXER
    PORT MAP (
        dataSum => adderOutS,
        dataBypass => doutS,
        muxSelect => selectS,
        muxOutData => muxOutS
    );      

cntr : CONTROLLER
    PORT MAP (
        dataInController => doutS,
        emptyFIFOIn => empty1S,
        emptyFIFOOut => empty2S,
        fullFIFOIn => full1S,
        fullFIFOOut => full2S,
        wr_clk => wr_clkTOP,
        rd_clk => rd_clkTop,
        controllerSelect => selectS
    );

FIFO_O : fifo_generator_0
  PORT MAP (
    wr_clk => wr_clkTOP,
    wr_rst => wr_rstTop,
    rd_clk => rd_clkTop,
    rd_rst => rd_rstTop,
    din => muxOutS ,
    wr_en => wr_e2Top,
    rd_en => rd_e2Top,
    dout => doutTop,
    full => full2S,
    empty => empty2S
  );
    
end Behavioral;
    