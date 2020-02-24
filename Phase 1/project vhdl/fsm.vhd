library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity dacs is
port( vdd,clk,vcc,reset,daytime: in std_logic;
	code: in std_logic_vector(3 downto 0);
	door,alarm: out std_logic );
end entity dacs;

architecture behav of dacs is

type state is (start, s2, s6, sa, s0, s5, finish, error);
signal cs,ns: state;

begin
p1:process(cs,reset,daytime,code)is
begin

if reset='1' then
	alarm<='0';
	door<='0';
	ns<=start;
else
	if daytime='1' then
		if code ="1101" then
			door<='1';
			ns<=finish;
		else
			case cs is 
			when start=>
				door<='0';
				alarm<='0';
				if code="0010" then
					ns<=s2;
				else
					ns<=error;
				end if;
			when s2=>
				if code="0110" then
					ns<=s6;
				else
					ns<=error;
				end if;
			when s6=>
				if code="1010" then
					ns<=sa;
				else
					ns<=error;
				end if;
			when sa=>
				if code="0000" then
					ns<=s0;
				else
					ns<=error;
				end if;
			when s0=>
				if code="0101" then
					ns<=s5;
				else
					ns<=error;
				end if;
			when s5=>
				ns<=finish;
			when finish=>
				door<='1';
				ns<=start;
			when error=>
				door<='0';
				alarm<='1';
			end case;
		end if;
		
	else
		case cs is 
			when start=>
				door<='0';
				alarm<='0';
				if code="0010" then
					ns<=s2;
				else
					ns<=error;
				end if;
			when s2=>
				if code="0110" then
					ns<=s6;
				else
					ns<=error;	
				end if;
			when s6=>
				if code="1010" then
					ns<=sa;
				else
					ns<=error;		
				end if;
			when sa=>
				if code="0000" then
					ns<=s0;
				else
					ns<=error;				
				end if;
			when s0=>
				if code="0101" then
					ns<=s5;
				else
					ns<=error;
				end if;
			when s5=>
				ns<=finish;
			when finish=>
				door<='1';
				ns<=start;
			when error=>
				door<='0';
				alarm<='1';
		end case;
	end if;
end if;
end process p1;

p2:process(clk)is
begin
if clk'event and clk='1' then
	cs<=ns;
end if;
end process p2;

end architecture behav;