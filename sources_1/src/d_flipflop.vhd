LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
ENTITY d_flipflop IS
  PORT (
    d,clock,reset,en      : IN  std_logic;                   
    q       : OUT std_logic
    );
END d_flipflop;

ARCHITECTURE TypeArchitecture OF d_flipflop IS
signal new_q : std_logic;
BEGIN

process(clock,reset)
begin
if reset = '1' then
	new_q <= '0';
		
elsif rising_edge(clock) then
	  if en = '1' then
	  	new_q <= d;
	   end if;
   else null;
	   	
end if;
end process;
q <= new_q;
END TypeArchitecture;