library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity SSD is
    Port ( input : in STD_LOGIC_VECTOR (11 downto 0);
           clock_in,clock_divin : in std_logic;   
           locked : in std_logic_vector(2 downto 0);
           ifclsd : in std_logic;
           an : out STD_LOGIC_vector(7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0)
           );
end SSD;

architecture Behavioral of SSD is

signal input_decoder : std_logic_vector(3 downto 0);
signal count:std_logic_vector(16 downto 0);
signal pp:std_logic := '0' ;

begin

process(clock_in ,count)
begin
--counter
if(clock_in='1' and clock_in'event) then count<=count+1;
end if;
end process;
-- anod 4 - 7;open / lock

process(count)
begin 
--anod 0 - 3 ;
case count(16 downto 14) is
when "000"=>an<="11111011";
when "001"=>an<="11111101";
when "010"=>an<="11111110";
when "011"=>an<="11110111";
when "100"=>an<="01111111";
when "101"=>an<="10111111";
when "110"=>an<="11011111";
when  others=>an<="11101111";
end case;
end process;

process(locked,input,count)
begin 
--digit catod
case count(16 downto 14) is
when "000"=>input_decoder<=input(11 downto 8);
when "001"=>input_decoder<=input(7 downto 4);
when "010"=>input_decoder<=input(3 downto 0);
when  others =>input_decoder<=x"0";
end case;
end process;

process(clock_divin)
begin
-- creating the rate of the blinking 
if rising_edge(clock_divin) then
    pp <= not pp;
    end if;
   -- pp <= not pp;
end process;

-- displaying the corect digit while the one that is being chosen is blinking
process(input_decoder,clock_in,locked)
begin
	if rising_edge(clock_in) then -- the clock here should be 0.7seconds
	 
	if count(16 downto 14) = "000" and locked = "000" then 
	 if pp = '1' then 
	 case input_decoder is
		when "0000" => cat<="0000001";
		when "0001" => cat<="1001111";
		when "0010" => cat<="0010010";
		when "0011" => cat<="0000110";

		when "0100" => cat<="1001100";
		when "0101" => cat<="0100100";
		when "0110" => cat<="0100000";
		when "0111" => cat<="0001111";

		when "1000" => cat<="0000000";
		when "1001" => cat<="0000100";
		when "1010" => cat<="0001000";
		when "1011" => cat<="1100000";

		when "1100" => cat<="0110001";
		when "1101" => cat<="1000010";
		when "1110" => cat<="0110000";
		when others => cat<="0111000";
		end case;
	else cat<="1111111";
	end if;
	elsif  count(16 downto 14) = "001" and locked = "100" then 
	 if pp = '1' then 
	 case input_decoder is
		when "0000" => cat<="0000001";
		when "0001" => cat<="1001111";
		when "0010" => cat<="0010010";
		when "0011" => cat<="0000110";

		when "0100" => cat<="1001100";
		when "0101" => cat<="0100100";
		when "0110" => cat<="0100000";
		when "0111" => cat<="0001111";

		when "1000" => cat<="0000000";
		when "1001" => cat<="0000100";
		when "1010" => cat<="0001000";
		when "1011" => cat<="1100000";

		when "1100" => cat<="0110001";
		when "1101" => cat<="1000010";
		when "1110" => cat<="0110000";
		when others => cat<="0111000";
		end case;
	else cat<="1111111";
	end if;
	elsif count(16 downto 14) = "010" and locked = "110" then 
	 if pp = '1' then 
	 case input_decoder is
		when "0000" => cat<="0000001";
		when "0001" => cat<="1001111";
		when "0010" => cat<="0010010";
		when "0011" => cat<="0000110";

		when "0100" => cat<="1001100";
		when "0101" => cat<="0100100";
		when "0110" => cat<="0100000";
		when "0111" => cat<="0001111";

		when "1000" => cat<="0000000";
		when "1001" => cat<="0000100";
		when "1010" => cat<="0001000";
		when "1011" => cat<="1100000";

		when "1100" => cat<="0110001";
		when "1101" => cat<="1000010";
		when "1110" => cat<="0110000";
		when others => cat<="0111000";
		end case;
	else cat<="1111111";
	end if;
	elsif count(16 downto 14) = "011" then
	    if ifclsd = '1' then
	    cat<="1000010";
	    else
	    cat<="1111111";
	    end if;
	else 
	  case input_decoder is
		when "0000" => cat<="0000001";
		when "0001" => cat<="1001111";
		when "0010" => cat<="0010010";
		when "0011" => cat<="0000110";

		when "0100" => cat<="1001100";
		when "0101" => cat<="0100100";
		when "0110" => cat<="0100000";
		when "0111" => cat<="0001111";

		when "1000" => cat<="0000000";
		when "1001" => cat<="0000100";
		when "1010" => cat<="0001000";
		when "1011" => cat<="1100000";

		when "1100" => cat<="0110001";
		when "1101" => cat<="1000010";
		when "1110" => cat<="0110000";
		when others => cat<="0111000";
		end case;
	end if;
	
	case count(16 downto 14) is
    when "100"=>if ifclsd = '1' then  cat<="1110001";
           else cat <="0000001"; 
           end if;
    when "101"=>if ifclsd = '1'  then  cat<="1100010";
               else cat <="0011000"; 
               end if;
    when "110"=>if ifclsd = '1'  then  cat<="1110010";
               else cat <="0110000"; 
               end if;
    when  "111"=>if ifclsd = '1'  then  cat<="0101000";
           else cat <="1101010"; 
           end if;
    when others => null;
end case;
	
	
	
	end if;
end process;

END Behavioral;