LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY globalFSM IS
	PORT (side_far		:in		std_logic;
		  slow_clk		:in		std_logic;
		  cds_cell		:in		std_logic;
		  hall_sensor	:in		std_logic;
		  front_close	:in		std_logic;
		  too_close		:in		std_logic;
		  back_far		:in		std_logic;
		  clk			:in		std_logic;
		  go			:in		std_logic;
		  
		  changeFollow	:out	std_logic;
		  musicEnable	:out	std_logic;
		  decision		:out	 std_logic_vector(2 downto 0));
END globalFSM;
--reset, to_house, honk, out_house, pivot, wall_search, wall_follow, t_tunnel
ARCHITECTURE Behavior OF globalFSM IS 
	Type   State_type IS (reset, to_house, honk, wall_house_search, pivot, straight_search, wall_follow, pivot_side, t_tunnel, change_side, t_tunnel_2, t_tunnel_3, cross, right_side, hall_stop, school_bus, to_church, arrival, stop);
	Signal y : State_type;
	signal count : std_logic_vector(3 downto 0);
	signal runNload : std_logic;
	signal done : std_logic;


	
Begin

Process(clk)
Begin 
	If (clk'EVENT AND clk = '1') then
		Case y is
			when reset =>
				If go = '1' And cds_cell = '1' then
					y <= to_house;
				else
					y <= reset;
				End If;
					decision <= "-11";
					musicEnable <= '0';
					runNload <= '0';
					changeFollow <= '0';
			
			when to_house =>
				If cds_cell = '0' then
					y <= honk;
				else
					y <= to_house;
				End If;
					decision <= "100";
					musicEnable <= '0';
					changeFollow <= '0';
					runNload <= '0';
			
			when honk => 
				If count(3) = '1' then
					y <= wall_house_search;
				Else 
					y <= honk;
				End If;
					decision <= "000";
					runNload <= '1';
					musicEnable <= '1';
					changeFollow <= '0';
				
			when wall_house_search =>
				if cds_cell = '1' And back_far = '1' And side_far = '1' then
					y <= pivot; 
				else 
					y <= wall_house_search;
				End If;
					decision <= "-11";
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '0';
			
			when pivot => 
				if count(3) = '1' then
					y <= straight_search;
				else
					y <= pivot;
				End If;
					decision <= "-01";
					runNload <= '1';
					musicEnable <= '0';
					changeFollow <= '0';
				
			when straight_search =>
				if too_close = '1' and front_close = '1'then
					y <= wall_follow;
				else
					y <= straight_search;	
				End If;
					decision <= "-00";
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '0';
				
			when wall_follow =>
				If cds_cell = '0' then
					y <= pivot_side;
				Else
					y <= wall_follow;
				End If;
					decision <= "-11";
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '0';
				
			when pivot_side =>
				if count(3) = '1' then
					y <= t_tunnel;
				else
					y <= pivot_side;
				End If;
					decision <= "-10";
					runNload <= '1';
					musicEnable <= '0';
					changeFollow <= '1';
			
			when t_tunnel =>
				if front_close = '1' Or too_close = '1' then
					y <= change_side;
				else
					y <= t_tunnel;
				End If;
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '1';
					decision <= "100";
					
			when change_side =>
				If count(3) = '1' then
					y <= t_tunnel_2;
				else
					y <= change_side;
				End If;
					runNload <= '1';
					musicEnable <= '0';
					changeFollow <= '1';
					decision <= "-01";
					
			when t_tunnel_2 =>
				if cds_cell = '1' And back_far = '1' then
					y <= cross;
				else
					y <= t_tunnel_2;
				End If;
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '1';
					decision <= "-11";	
					
			when t_tunnel_3 =>
				if back_far = '1' then
					y <= cross;
				else
					y <= t_tunnel_3;
				End If;
					runNload <= '0';
					musicEnable <= '0';
					changeFollow <= '1';
					decision <= "-11";	
		
			when cross =>
			if front_close = '1' Or too_close = '1' then 
				y <= right_side;
			else
				y <= cross;
			End If;
				decision <= "100";
				musicEnable <= '0';
				changeFollow <= '1';
				runNload <= '0';
				
			when right_side =>
				if hall_sensor = '0' then
					y <= hall_stop;
				else 
					y <= right_side;
				End If; 
					decision <= "-11";
					musicEnable <= '0';
					changeFollow <= '1';
					runNload <= '0';
			
			when hall_stop =>
				if front_close = '1' then
					y <= school_bus;
				else 
					y <= hall_stop;
				End If; 
					decision <= "000";
					musicEnable <= '0';
					changeFollow <= '1';
					runNload <= '0';
			
			when school_bus =>
				if front_close = '0' then
					y <= to_church;
				else 
					y <= school_bus;
				End If;
					decision <= "000";
					musicEnable <= '0';
					runNload <= '0';
					changeFollow <= '1';
			
			when to_church =>
				if cds_cell = '0' then
					y <= arrival;
				else
					y <= to_church;
				End If;
				decision <= "-11";
				musicEnable <= '0';
				runNload <= '0';
				changeFollow <= '1';
			
			when arrival =>
				decision <= "000";
				musicEnable <= '1';
				runNload <= '0';
				changeFollow <= '1';
			
			when stop =>
				decision <= "000";
				
				
			 when others => 
					y <= stop;
	End Case;
	End If;
End Process; 
						
	
process (slow_clk)
	begin
		if (rising_edge(slow_clk)) then
			if runNload = '1' then 
				count <= count + 1;
			elsif runNload = '0' then
				-- Load the 4 bit counter			   
				count <= "0000";
			end if;
		end if;
end process;				

END Behavior;