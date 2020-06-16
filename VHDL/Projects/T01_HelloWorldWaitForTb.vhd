--entity
entity T01_HelloWorldWaitForTb is

end entity;

--architecture
architecture sim of T01_HelloWorldWaitForTb is
-- signals
begin
	
	process is
	begin
	
		report "Hello World";
		
		wait for 10 ns;
	
	end process;

end architecture;