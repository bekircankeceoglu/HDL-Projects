----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.07.2020 09:25:19
-- Design Name: 
-- Module Name: SPI_FLASH - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI_FLASH is
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
end SPI_FLASH;

architecture Behavioral of SPI_FLASH is
    -- clock
    constant SPI_FREQ : integer := 5000000; -- below max read rate 5 MHZ
    constant SYS_FREQ : integer := 20000000; -- 20 MHZ max 50 MHZ
    signal clk_counter : integer range 0 to (SYS_FREQ/SPI_FREQ)-1;
    signal clk_enable : std_logic;
    signal spi_clk_int : std_logic;
    signal spi_clk_int_enable : std_logic;
    signal spi_cs_int : std_logic;
    
    -- transmit
    signal tx_data, tx_datashift : std_logic_vector (7 downto 0);
    signal tx_bit_counter : std_logic_vector (2 downto 0); -- max 8
    signal tx_enable : std_logic;
    
    -- receiver
    signal rx_data, rx_datashift : std_logic_vector (7 downto 0);
    signal rx_bit_counter : std_logic_vector (2 downto 0); -- max 8
    signal rx_enable : std_logic;  
    signal rx_data_ready : std_logic;  
    
    signal wr_addr, rd_addr : std_logic;
    signal rd_data, wr_data : std_logic;
    signal rd_stat, wr_cmd : std_logic;
    
    -- address register
    signal addr_reg : std_logic_vector (7 downto 0);
    
    -- command register
    signal cmd_reg : std_logic_vector (7 downto 0);
    
    -- tx register
    signal tx_data_reg : std_logic_vector (7 downto 0);
    
    -- rx register
    signal rx_data_reg : std_logic_vector (7 downto 0);
    
    type state_t is (
    IDLE, CMDReceived, WRState, ReadState, TXState, RXState, CLR_CMD);
    signal state, next_state : state_t;
    
    -- Generic FLASH commands
    constant START  : std_logic_vector (7 downto 0) := x"00";  -- start 
    constant WREN : std_logic_vector (7 downto 0) := x"06";  -- write enable
    constant RDSR1 : std_logic_vector (7 downto 0) := x"05";  -- read status reg
    constant WRR : std_logic_vector (7 downto 0) := x"01";  -- write status reg
    constant READ: std_logic_vector (7 downto 0) := x"03";  -- read data
begin

spi_mosi <= tx_datashift(7);
spi_clk <= spi_clk_int;
spi_cs <= spi_cs_int;


spi_clock : process(rst, clk_main)
begin
    if rst = '1' then           
        spi_clk_int <= '1';
        clk_enable  <= '0';
        clk_counter <= 0;
    elsif falling_edge(clk_main) then
        if clk_counter = (SYS_FREQ/SPI_FREQ) then
            clk_enable <= '1';
            clk_counter <= 0;
            if tx_enable = '1' or rx_enable = '1' then
                spi_clk_int <= '1';
            else
                spi_clk_int <= '0';
            end if;
        else
            spi_clk_int <= '1';
            clk_enable <= '0';
            clk_counter <= clk_counter + 1;
        end if;
    end if;

end process;

command_decode : process(wr, rd)
    variable input : std_logic_vector (9 downto 0);
begin
    input := wr & addr &rd; --0.00000000.0
    -- init signals
    rd_addr <= '0';
    wr_addr <= '0';
    case input is
        when "0000000001" => rd_data <= '1';
        when "1000000000" => wr_data <= '1';
        when "0000000011" => rd_stat <= '1';
        when "1000000010" => wr_cmd  <= '1';
        when "0000000101" => rd_addr  <= '1';
        when "1000000100" => wr_addr  <= '1';
        when others => null;
    end case;

end process;

-- write address
write_address: process(rst, clk_main)
begin
    if rst = '1' then
        addr_reg <= "00000000";
    elsif rising_edge(clk_main) then
        if wr_addr = '1' then
            addr_reg <= din;
        end if;
    end if;
end process;

-- write command
write_cmd : process(rst, clk_main)
begin
    if rst = '1' then
        cmd_reg <= START;
    elsif rising_edge(clk_main) then
        if wr_cmd = '1' then
            cmd_reg <= din;
        end if;
    end if;
end process;

-- write data
write_data : process(rst, clk_main)
begin
    if rst = '1' then
        tx_data <= "00000000";
    elsif rising_edge(clk_main) then
        if wr_data = '1' then
            tx_data <= din;
        end if;
    end if;
end process;

-- advance state machine
stace_machine_adv : process (rst, clk_main)
begin
    if rst = '1' then
      state <= IDLE;
    elsif rising_edge (clk_main) then
      if clk_enable = '1' then
        state <= next_state;
      end if;
    end if;
end process;

-- state machine
state_machine : process(state, cmd_reg, tx_bit_counter, rx_bit_counter)
begin
    case state is
        when IDLE =>
            case cmd_reg is
                when START => next_state <= IDLE;
                when others => next_state <= CMDReceived;
            end case;
        
        when CMDReceived =>
            case cmd_reg is
                when WREN => next_state <= CLR_CMD;
                when RDSR1 | WRR | READ => next_state <= WRState;
                when others => next_state <= CLR_CMD;
            end case;
        
        when WRState =>
            case cmd_reg is
                when WREN => next_state <= CLR_CMD;
                when READ => next_state <= ReadState;
                when WRR => next_state <= TXState;
                when RDSR1 => next_state <= RXState;
                when others => next_state <= CLR_CMD;
            end case;
         
        when ReadState =>   
            if tx_bit_counter < x"7" then
              next_state <= ReadState;
            else
              next_state <= CLR_CMD;
            end if;
            
        when TXState =>   
            if tx_bit_counter < x"7" then
              next_state <= TXState;
            else
              next_state <= CLR_CMD;
            end if;
        
        when RXState =>   
            if rx_bit_counter < x"7" then
              next_state <= RXState;
            else
              next_state <= CLR_CMD;
            end if;
        
        when CLR_CMD => next_state <= IDLE;
        
    end case;
end process;

-- state machine outputs
state_machine_o : process (state, cmd_reg, tx_data_reg, addr_reg)
  begin
    -- default values
    tx_enable <= '0';
    rx_enable <= '0';
    tx_data <= x"00";
    spi_cs_int <= '0';
    busy <= '1';

    case state is
      when IDLE =>
        busy <= '0';
        
      when CMDReceived =>
        tx_data <= cmd_reg;
        tx_enable <= '1';
        spi_cs_int <= '1';
        
      when WRState =>
        tx_data_reg <= tx_data;
        tx_enable <= '1';
        spi_cs_int <= '1';
        
      when READState =>
        tx_data_reg <= addr;
        tx_enable <= '1';
        spi_cs_int <= '1';
      
      when TxState =>
        tx_data_reg <= x"00";
        tx_enable <= '1';
        spi_cs_int <= '1';
        
      when RxState =>
        rx_enable <= '1';
        spi_cs_int <= '1';
       
      when others => null;
    end case;
  end process;
  
-- transmit shift
transmit_register : process (rst, tx_data_reg, tx_enable, clk_main)
begin
    if rst = '1' then
      tx_datashift <= x"00";
      tx_bit_counter <= "000";
    elsif rising_edge (clk_main) then
      if clk_enable = '1' then
        tx_bit_counter <= tx_bit_counter + 1;
        tx_datashift <= tx_datashift (6 downto 0) & '1';
        if tx_bit_counter = x"8" then
            busy <= '0';
        end if;  
      end if;
    end if;
end process;  

 -- the rx_data register
receive_data : process (rst, clk_main)
begin
    if rst = '1' then
      rx_data <= x"00";
    elsif rising_edge (clk_main) then
      if rx_data_ready = '1' then
        rx_data <= rx_datashift;
      end if;
    end if;
end process;

shiftreceive_data : process(rst, clk_main)
begin
    if rst = '1' then 
        rx_bit_counter <= "000";
        rx_data_ready <= '0';
        rx_datashift <= x"00";
    elsif rising_edge (clk_main) then 
        rx_datashift <= rx_datashift (6 downto 0) & spi_miso;
        if rx_bit_counter = "111" then
            rx_bit_counter <= rx_bit_counter + '1';
        else
            rx_data_ready <= '1';
        end if;
    end if;
end process;

-- send data out when cmd received
dout <= rx_data and (rd_data & 
                     rd_data &
                     rd_data &
                     rd_data &
                     rd_data &
                     rd_data &
                     rd_data &
                     rd_data );


end Behavioral;
