library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity code_selector is
    Port (  
           up, down, sel, clk, reset : in std_logic;
           locked, pinin : out std_logic_vector(2 downto 0);
           code : out STD_LOGIC_VECTOR (11 downto 0)
         	
           );
           
end code_selector;

architecture Behavioral of code_selector is

signal lock : std_logic_vector(2 downto 0) := "000";
signal tries : std_logic_vector(2 downto 0) := "000";
signal pin1, pin2, pin3 : std_logic_vector(3 downto 0);
signal password : std_logic_vector(11 downto 0);
signal ok : std_logic := '0';

begin

process(reset,clk,up,down,sel,pin1,pin2,pin3,password,tries,lock)
begin
--choosing the password

if reset = '1' then
                password <= x"000";
                pin1 <= "0000";
                pin2 <= "0000"; 
                pin3 <= "0000";
                tries <="000"; 
                lock <= "000";
                ok <= '0';
else
if clk = '1' and clk'event then
if ok = '0' then
case lock is 
when "111" =>   if ok = '0' then	
                  password <= pin1&pin2&pin3;
		          pin1 <= "0000";
		          pin2 <= "0000"; 
		          pin3 <= "0000";
		          tries <="000";
		          ok <= not ok;
		         end if;
when "110" =>   if up = '1' then pin3 <= pin3 + 1;
		        elsif down = '1' then pin3 <= pin3 - 1;
		        end if;
		        if sel = '1' then lock(0) <= '1';
		        end if;
when "100" =>   if up = '1' then pin2 <= pin2 + 1;
		        elsif down = '1' then pin2 <= pin2 - 1;
		        end if;
		        if sel = '1' then lock(1) <= '1';
		        end if;		        		         		         
when "000" =>   if up = '1' then pin1 <= pin1 + 1;
	           	elsif down = '1' then pin1 <= pin1 - 1;
                end if;
                if sel = '1' then lock(2) <= '1';
		        end if;
when others => null;   
end case;	
end if;

if ok = '1' then
case tries is 
when "000" =>   if up = '1' then pin1 <= pin1 + 1;
		        elsif down = '1' then pin1 <= pin1 - 1;	
                end if;
                if sel = '1' then tries(2) <= '1';
                end if;
when "100" =>   if up = '1' then pin2 <= pin2 + 1;
                elsif down = '1' then pin2 <= pin2 - 1;
                end if;
                if sel = '1' then tries(1) <= '1';
                end if; 
when "110" =>   if up = '1' then pin3 <= pin3 + 1;
                elsif down = '1' then pin3 <= pin3 - 1;
                end if;
                if sel = '1' then tries(0) <= '1';
                end if;                
when "111" =>   if pin1&pin2&pin3 = password then
                password <= x"000";
                pin1 <= "0000";
                pin2 <= "0000"; 
                pin3 <= "0000";
                tries <="000"; 
                lock <= "000";
                ok <= not ok;
                else
                tries <= "000";
                pin1 <= "0000";
                pin2 <= "0000"; 
                pin3 <= "0000";
                end if;
when others => null;                                               
end case;
end if;
end if;
end if;
pinin <= tries;
locked <= lock;
code <= pin1&pin2&pin3;
end process;

END Behavioral;
