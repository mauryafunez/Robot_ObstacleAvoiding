library IEEE;
use IEEE.std_logic_1164.all;

Entity Music is 
	port(Clk: in  STD_LOGIC_VECTOR (29 downto 0);
		 Play:in  Std_Logic;
		 Speaker_74: out STD_LOGIC;
	     Speaker_82: out STD_LOGIC);
End Music ;

Architecture Structure of Music is
Begin
	Process(Play)
		Begin
		If rising_edge(Play) Then
			Speaker_74 <= Clk(14) AND Clk(19);
			Speaker_82 <= Clk(14) AND Clk(19);
		End If;
	End Process;
End Structure;