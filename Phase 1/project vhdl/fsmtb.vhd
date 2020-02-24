library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity tb is
end entity tb;

architecture test of tb is
component dacs is
port( vdd,clk,vcc,reset,daytime: in std_logic;
	code: in std_logic_vector(3 downto 0);
	door,alarm: out std_logic );
end component dacs;

signal vdd,vcc,clk,reset,daytime,door,alarm:std_logic;
signal code:std_logic_vector(3 downto 0);
constant clk_period : time := 100ns;
for dut:dacs use entity work.dacs(behav);
begin
dut:dacs port map(vdd,clk,vcc,reset,daytime,code,door,alarm);

clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  
        clk <= '1';
        wait for clk_period/2;  
   end process;

p:process
begin
--happy cenario test.
reset<='1';
wait for clk_period;
reset<='0';
daytime<='0';
code<="0010";
wait for clk_period;
code<="0110";
wait for clk_period;
code<="1010";
wait for clk_period;
code<="0000";
wait for clk_period;
code<="0101";
wait for 2*clk_period;
assert door='1' and alarm='0'
report "happy senario error"
severity error;
wait for clk_period;

--alarm senario 1.
reset<='1';
wait for clk_period;
reset<='0';
code<="0000";
wait for clk_period;
assert door='0' and alarm='1'
report "alarm senario 1 error"
severity error;
wait for clk_period;

--alarm senario 2.
reset<='1';
wait for clk_period;
reset<='0';
code<="0010";
wait for clk_period;
code<="0110";
wait for clk_period;
code<="1010";
wait for clk_period;
code<="0000";
wait for clk_period;
code<="0000";
wait for clk_period;
assert door='0' and alarm='1'
report "alarm senario 2 error"
severity error;
wait for clk_period;

--daytime happy senario 1.
reset<='1';
daytime<='1';
wait for clk_period;
reset<='0';
code<="1101";
wait for clk_period;
assert door='1' and alarm='0'
report "daytime happy senario 1 error"
severity error;
wait for clk_period;

--daytime happy senario 2.
reset<='1';
wait for clk_period;
reset<='0';
code<="0010";
wait for clk_period;
code<="0110";
wait for clk_period;
code<="1010";
wait for clk_period;
code<="1101";
wait for clk_period;
assert door='1' and alarm='0'
report "daytime happy senario 2 error"
severity error;
wait for clk_period;

--daytime happy senario 3.
reset<='1';
wait for clk_period;
reset<='0';
code<="0010";
wait for clk_period;
code<="0110";
wait for clk_period;
code<="1010";
wait for clk_period;
code<="0000";
wait for clk_period;
code<="0101";
wait for 2*clk_period;
assert door='1' and alarm='0'
report "daytime happy senario 3 error"
severity error;
wait for clk_period;

--alarm senario 3.
reset<='1';
daytime<='1';
wait for clk_period;
reset<='0';
code<="0000";
wait for clk_period;
assert door='0' and alarm='1'
report "alarm senario 3 error"
severity error;
wait for clk_period;

wait;
end process p;
end architecture test;