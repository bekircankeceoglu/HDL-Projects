--entity
entity T01_LoopTb is

end entity;

--architecture
architecture sim of T01_LoopTb is
-- signals
begin
	
	process is
	begin
		
		report "Hello";
		
		loop
			report "Blue";
			exit;
		end loop;
		
		report "Goodbye";
		wait;
		
	end process;

end architecture;