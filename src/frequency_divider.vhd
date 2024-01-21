library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity frequency_divider is
    Port ( clock_in, reset : in std_logic;
           clock_out : out std_logic
           );
end frequency_divider;

architecture Behavioral of frequency_divider is
signal count : integer := 1;
signal clock_divided : std_logic := '0';
begin
process(clock_in,reset,clock_divided)
begin
if reset = '1' then 
	count <= 1;
elsif rising_edge(clock_in) then
	if count = 25000000 then 
		count <= 1;
		clock_divided <= not clock_divided;
	else
	count <= count + 1;
	end if;
end if;
clock_out <= clock_divided;
end process;


END Behavioral;