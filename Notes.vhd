--****** Notes ROM 12 Notes of an Octave ***
library IEEE;
use IEEE.std_logic_1164.all;

Entity Notes is 
	port(Data_in: in  STD_LOGIC_VECTOR (3 downto 0);
	     Freq: out STD_LOGIC_VECTOR (7 downto 0));
End Notes;

Architecture Structure of Notes is
Begin
	Process(Data_in)
	Begin
		Case Data_in is
when "1100" =>Freq <="01100011";  --b 99
when "1011" =>Freq <="01101001";
when "1010" =>Freq <="01101111";
when "1001" =>Freq <="01110110";
when "1000" =>Freq <="01111101";
when "0111" =>Freq <="10000100";
when "0110" =>Freq <="10001100";
when "0101" =>Freq <="10010100";
when "0100" =>Freq <="10011101";
when "0011" =>Freq <="10100110";
when "0010" =>Freq <="10110000";  -- c# 176
when "0001" =>Freq <="10111011";  -- Middle C 187
when "0000" =>Freq <="00000000";  --rest all zeros

when others =>Freq <="--------";

		End Case;
	End process;
End Structure;
