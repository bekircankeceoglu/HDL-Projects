--entity
entity T01_HelloWorldTb is

end entity;

--architecture
architecture sim of T01_HelloWorldTb is
-- signals
begin
	
	process is
	begin
	
		report "Hello World";
		wait;
	
	end process;

end architecture;