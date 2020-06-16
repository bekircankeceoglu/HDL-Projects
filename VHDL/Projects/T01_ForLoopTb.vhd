--entity
entity T01_ForLoopTb is

end entity;

--architecture
architecture sim of T01_ForLoopTb is
-- signals
begin
	
	process is
	begin
		
		for i in 1 to 10 loop
			
			report "i=" & integer'image(i);
			
		end loop;
		wait;
		
	end process;

end architecture;