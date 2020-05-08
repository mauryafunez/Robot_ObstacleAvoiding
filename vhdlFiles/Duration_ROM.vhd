library IEEE;
use IEEE.std_logic_1164.all;

Entity Duration_ROM is 
	port(Data_in: in  STD_LOGIC_VECTOR (2 downto 0);
	     Dur: out STD_LOGIC_VECTOR (5 downto 0));
End Duration_ROM ;

Architecture Structure of Duration_ROM  is
Begin
	Process(Data_in)
	Begin
		Case Data_in is
		--   ROM for Note Durations           
			when "000" => Dur <= "000010";  --1/16 Note
			when "001" => Dur <= "000101";  --1/8 Note
			when "010" => Dur <= "001011";	--1/4 Note
			when "011" => Dur <= "010001";	--Dotted 1/4 Note 
			when "100" => Dur <= "010111";  -- Half Note
			when "101" => Dur <= "100011";  --Dotted 1/2 Note
			when "110" => Dur <= "101111";  --Whole Note
			when "111" => Dur <= "------";  --Not Defined
		End Case;
	End process;
End Structure;
