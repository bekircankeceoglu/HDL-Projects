----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 13:16:48
-- Design Name: 
-- Module Name: SPI_FLASH_TB - Behavioral
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

entity SPI_FLASH_TB is
--  Port ( );
end SPI_FLASH_TB;

architecture Behavioral of SPI_FLASH_TB is

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

signal rst : std_logic := '0';
signal clk_main : std_logic := '0';
signal wr : std_logic := '0';
signal rd : std_logic := '0';
signal busy : std_logic := '0';
signal spi_miso : std_logic := '0';
signal spi_mosi : std_logic := '0';
signal spi_clk : std_logic := '0';
signal spi_cs : std_logic := '0';
signal addr : std_logic_vector(7 downto 0) := "00000000";
signal din : std_logic_vector(7 downto 0) := "00000000";
signal dout : std_logic_vector(7 downto 0):= "00000000"; 

begin
uut: SPI_FLASH port map(
    -- controller ports
    rst     => rst,
    clk_main => clk_main,
    wr      => wr,
    rd      => rd,
    busy    => busy,
    addr    => addr,
    din     => din,
    dout    => dout,
    -- spi ports
    spi_miso    => spi_miso,
    spi_mosi    => spi_mosi,
    spi_clk     => spi_clk,
    spi_cs      => spi_cs
);

clock_process : process
begin
    clk_main <= '0';
    wait for 10 ns;
    clk_main <= '1';
    wait for 10 ns;
end process;

-- 1000000010
test : process
begin
    rst <= '1';
    wait for 20 ns;
    rst <= '0';
    wr <= '1';
    rd <= '0';
    addr <= "00000001";
    din <= x"06";
    wait for 20 ns;
    addr <= "00000001";
    din <= x"01";
    wait;
end process;

end Behavioral;
