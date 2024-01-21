LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_unsigned.ALL;

ENTITY circuit IS
  PORT (
 	
  		up, down, sel, clock, reset : in std_logic;
  		led_lock : out std_logic;
  		an : out std_logic_vector(7 downto 0);
  		cat : out std_logic_vector(6 downto 0)
          
  	  );
END circuit;

ARCHITECTURE TypeArchitecture OF circuit IS

component debouncer IS
  PORT (
    clock, btn, reset      : IN  std_logic;                    
    enable        : OUT std_logic
    );
END component debouncer;
 
component frequency_divider is
    Port ( clock_in, reset : in std_logic;
           clock_out : out std_logic
           );
end component frequency_divider;

component code_selector is
    Port (  
           up, down, sel, clk, reset : in std_logic;
           locked, pinin : out std_logic_vector(2 downto 0);
           code : out STD_LOGIC_VECTOR (11 downto 0)
         	
           );
           
end component code_selector;

component SSD is
    Port ( input : in STD_LOGIC_VECTOR (11 downto 0);
           clock_in,clock_divin : in std_logic;
           locked : in std_logic_vector(2 downto 0);
           ifclsd : in std_logic;
           an : out STD_LOGIC_vector(7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component SSD;

signal up1, down1, sel1, clock_div, up2, down2, sel2, up3, down3, sel3 : std_logic;
signal lock2, pinin2, ssdlock : std_logic_vector(2 downto 0);
signal code2 : std_logic_vector(11 downto 0);
constant x : std_logic := '1';
signal ifclsd :std_logic;

BEGIN
l1:debouncer port map(clock,up,reset, up1);
l2:debouncer port map( clock,down,reset, down1);
l3:debouncer port map( clock,sel,reset, sel1);
l4:frequency_divider port map(clock,reset,clock_div);
l5:code_selector port map(up1, down1, sel1, clock, reset, lock2, pinin2, code2);
l6:SSD port map(code2, clock,clock_div, ssdlock, ifclsd, an, cat);

process(lock2,pinin2)
begin 
-- display the correct input
if lock2 = "111" then
	 ssdlock <= pinin2;
else ssdlock <= lock2;
end if;
end process;

process(lock2)
begin
-- led indicates the state of the locker ( open / closed )
if lock2 = "111" then 
	led_lock <= '1';
	ifclsd <= '1' ;
else led_lock <= '0';
    ifclsd <= '0' ;
end if;

end process;

END TypeArchitecture;