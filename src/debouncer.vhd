LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
ENTITY debouncer IS
  PORT (
    clock, btn, reset      : IN  std_logic;                    
    enable        : OUT std_logic
    );
END debouncer;

ARCHITECTURE TypeArchitecture OF debouncer IS

component counter IS
  PORT (
    clock,reset,en      : IN  std_logic;                   
    count        : OUT std_logic_vector(15 DOWNTO 0) 
    );
END component counter;

component d_flipflop IS
  PORT (
    d,clock,reset,en      : IN  std_logic;                   
    q       : OUT std_logic
    );
END component d_flipflop;

signal s2,q3,q2,q1 : std_logic;
signal s1: std_logic_vector(15 downto 0);
signal v : std_logic := '1';
BEGIN

l1:counter port map(clock,reset,v,s1);
l2:d_flipflop port map(btn,clock,reset,s2,q3);
l3:d_flipflop port map(q3,clock,reset,v,q2);
l4:d_flipflop port map(q2,clock,reset,v,q1);

process(s1)
begin
if s1 = x"FFFF" then
	s2 <= '1';
else s2 <= '0';
end if;
end process;

process(q2,q1)
begin
if q2 = '1' and q1 = '0' then
enable <= '1';
else enable <= '0';
end if;
end process;

END TypeArchitecture;