----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 15:48:17
-- Design Name: 
-- Module Name: SPI_FLASH_EMU_TOP - Behavioral
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

entity SPI_FLASH_EMU_TOP is
port(
    clkTop : in std_logic;
    csTop  : out std_logic;
    misoTop : out std_logic;
    mosiTop : out std_logic 
    );
end SPI_FLASH_EMU_TOP;

architecture Behavioral of SPI_FLASH_EMU_TOP is

COMPONENT vio_0
  PORT (
    clk : IN STD_LOGIC;
    probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe_out3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe_out4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

component SPI_FLASH
    port(
    -- controller ports
    rst     : in std_logic;
    clk_main: in std_logic;
    wr      : in std_logic;
    rd      : in std_logic;
    busy    : out std_logic;
    addr    : in std_logic_vector(7 downto 0);
    din     : in std_logic_vector(7 downto 0);
    dout    : out std_logic_vector(7 downto 0);
    -- spi ports
    spi_miso    : in std_logic;
    spi_mosi    : out std_logic;
    spi_clk : out std_logic;
    spi_cs  : out std_logic
    );
end component;

Signal clk, rstS, wrS, rdS, busyS : std_logic_vector(0 downto 0);
Signal spi_misoS, spi_mosiS, spi_clk, spi_csS :std_logic_vector(0 downto 0);
Signal addrS, dinS, doutS : std_logic_vector(7 downto 0);

begin

misoTop <= spi_misoS(0);


vio_module  : vio_0
  PORT MAP (
    clk => clkTop,
    probe_out0 => rstS,
    probe_out1 => wrS,
    probe_out2 => rdS,
    probe_out3 => dinS,
    probe_out4 => addrS
  );

spi_flash_module : SPI_FLASH
  PORT MAP (
    -- controller ports
    rst         => rstS(0),
    clk_main    =>clkTop,
    wr          =>wrS(0),
    rd          =>rdS(0),
    busy        =>busyS(0),
    addr        =>addrS,
    din         =>dinS,
    dout        =>doutS,
    -- spi ports
    spi_miso    =>spi_misoS(0),
    spi_mosi    =>spi_mosiS(0),
    spi_clk     =>spi_clk(0),
    spi_cs      =>spi_csS(0)
);

end Behavioral;
