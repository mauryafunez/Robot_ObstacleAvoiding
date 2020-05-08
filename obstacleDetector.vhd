LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY obstacleDetector IS
	PORT (Clock			:IN		STD_LOGIC;
		  Slow_Clock	:IN		STD_LOGIC;
		  go			:IN		STD_LOGIC;
		  front_close 	:IN		STD_LOGIC;
		
		  too_close		:In		std_logic;
		  too_far		:In		std_logic;
		
		  change_side	:In		Std_Logic;
		  back_far		:In		std_logic;
		  extremeFar_front :In  std_logic;
		  sweetspot		:In		std_logic;
		  
		  returnClose	:In		std_logic;
		  returnFar		:In		std_logic;

		  state_output	:OUT    STD_LOGIC_Vector(2 downto 0);
		  left_motor	:OUT    STD_LOGIC_Vector(2 downto 0);
		  right_motor	:OUT    STD_LOGIC_Vector(2 downto 0));
END obstacleDetector;

ARCHITECTURE Behavior OF obstacleDetector IS 
	TYPE   State_type IS (reset, straight, spin, away_wall, towards_wall, forward_two, pivot_turn);
	SIGNAL y : State_type;

--MSB to LSB (speed[1..0], for/rev), state output.
BEGIN
	
	PROCESS(Clock)
	BEGIN
	IF (Clock'EVENT AND Clock = '1') THEN 
		CASE y IS 
			--Start
			when reset =>
				if go = '1' then 
					y <= straight;
				else 
					y <= reset;
				end if;
					state_output <= "000";
					left_motor <= "000";
					right_motor <= "000";
				
			--What to do when straight S1
			when straight =>
				if too_close = '1' then
					--State 4
					y <= away_wall;
					
				elsif front_close = '1' then
					--State 2
					y <= spin;
				
				elsif too_far = '1' And back_far = '0' And extremeFar_front = '0' then
				--State 3
					y <= towards_wall;
									
				elsif too_far = '1' And extremeFar_front = '1' And back_far = '0' then
				--State 5
					y <= forward_two;
				else
					y <= straight;
				end if;
					state_output <= "001";
					left_motor <= "101";
					right_motor <= "101";
				
			--What to do when we spin
			--And too_close = 0
			when spin =>
				if front_close = '0' And back_far = '0' And too_close = '0' then
					y <= straight;

				else 
					y <= spin;
				end if; 
					state_output <= "010";
					if change_side = '1' then
						left_motor <= "001";
						right_motor <= "011";
					else
						left_motor <= "011";
						right_motor <= "001";
					end if;
				
			--State 3
			when towards_wall =>
				if returnFar = '1' Or front_close = '1' then
					y <= straight;
				elsif extremeFar_front = '1' And back_far = '0' then
					y <= forward_two;
				elsif front_close = '1' then
					y <= spin;
				else
					y <= towards_wall;
				End If;
					state_output <= "011";
					if change_side = '1' then
						left_motor <= "101";
						right_motor <= "011";
					else 
						left_motor <= "011";
						right_motor <= "101";
					end if;
			--State 4
			when away_wall =>
				If returnClose = '1' then
					y <= straight;
				elsif front_close = '1' then
					y <= spin;
				else
					y <= away_wall;
				End If;
					state_output <= "100";
					if change_side = '1' then
						left_motor <= "011";
						right_motor <= "101";
					else 
						left_motor <= "101";
						right_motor <= "011";
					end if;

				
			--state 5 
			 when forward_two =>
				If back_far = '1' And too_far = '1' And extremeFar_front = '1' then
					y <= pivot_turn;
				else 
					y <= forward_two;
				End If;
					state_output <= "101";
					left_motor <= "011";
					right_motor <= "011";
			
--			 State 6
			 when pivot_turn =>
				If sweetspot = '1' then
					y <= straight;
				else
					y <= pivot_turn;
				End If;
					state_output <= "110";
					if change_side = '1' then
						left_motor <= "011";
						right_motor <= "000";
					else
						left_motor <= "000";
						right_motor <= "011";
					End If;
		END CASE;
		End If;
	END PROCESS;

END Behavior;