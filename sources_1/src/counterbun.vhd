LIBRARY ieee;
USE ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;  
ENTITY counter IS
  PORT (
    clock,reset,en      : IN  std_logic;                   
    count        : OUT std_logic_vector(15 DOWNTO 0) 
    );
END counter;

ARCHITECTURE TypeArchitecture OF counter IS
signal cnt : unsigned(15 DOWNTO 0) := x"0000";
BEGIN

process(clock,reset)
begin
if reset = '1' then
	cnt <= x"0000";
	
elsif rising_edge(clock) then
	   if en = '1' then	
	   if cnt = x"FFFF" then
	   	cnt <= x"0000";
	   else cnt <= cnt + 1;
	   end if;
	   end if;
      	
end if;
end process;
count <= std_logic_vector(cnt);
END TypeArchitecture;