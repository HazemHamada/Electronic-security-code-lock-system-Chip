LIBRARY sxlib_ModelSim;

entity tb3 is
end entity tb3;

architecture test of tb3 is

component dacs is
port( vdd     : in      bit;
      clk     : in      bit;
      vss     : in      bit;
      reset   : in      bit;
      daytime : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit
 );
end component dacs;

component sdetj_scan is
   port (
      vdd     : in      bit;
      clk     : in      bit;
      vss     : in      bit;
      reset   : in      bit;
      daytime : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit;
      scanin  : in      bit;
      test    : in      bit;
      scanout : out     bit
 );
end component sdetj_scan;



signal sequence : bit_vector(19 downto 0);
signal vdd,vss,clk,reset,daytime,door,alarm:bit;
signal code:bit_vector(3 downto 0);
signal reset2,daytime2,door2,alarm2,scanin,test,scanout:bit;
signal code2:bit_vector(3 downto 0);
constant clk_period : time := 100ns;
for dut:dacs use entity work.dacs(behav);
for dut2:sdetj_scan use entity work.sdetj_scan(structural);
begin
dut:dacs port map(vdd,clk,vss,reset,daytime,code,door,alarm);
dut2:sdetj_scan port map(vdd,clk,vss,reset2,daytime2,code2,door2,alarm2,scanin,test,scanout);
clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  
        clk <= '1';
        wait for clk_period/2;  
   end process;

p:process
begin
-------------test off
test<='0';

--happy scenario test.
reset<='1';
reset2<='1';
wait for clk_period;
reset<='0';
daytime<='0';
code<="0010";
reset2<='0';
daytime2<='0';
code2<="0010";
wait for clk_period;
code<="0110";
code2<="0110";
wait for clk_period;
code<="1010";
code2<="1010";
wait for clk_period;
code<="0000";
code2<="0000";
wait for clk_period;
code<="0101";
code2<="0101";
wait for 2*clk_period;
assert door=door2 and alarm=alarm2
report "happy scenario error"
severity error;
wait for clk_period;

--alarm scenario 1 test.
reset<='1';
reset2<='1';
wait for clk_period;
reset<='0';
code<="0000";
reset2<='0';
code2<="0000";
wait for clk_period;
assert door=door2 and alarm=alarm2
report "alarm scenario 1 error"
severity error;
wait for clk_period;

--alarm scenario 2 test.
reset<='1';
reset2<='1';
wait for clk_period;
reset<='0';
code<="0010";
reset2<='0';
code2<="0010";
wait for clk_period;
code<="0110";
code2<="0110";
wait for clk_period;
code<="1010";
code2<="1010";
wait for clk_period;
code<="0000";
code2<="0000";
wait for clk_period;
code<="0000";
code2<="0000";
wait for clk_period;
assert door=door2 and alarm=alarm2
report "alarm scenario 2 error"
severity error;
wait for clk_period;

--daytime happy scenario 1 test.
reset<='1';
daytime<='1';
reset2<='1';
daytime2<='1';
wait for clk_period;
reset<='0';
code<="1101";
reset2<='0';
code2<="1101";
wait for clk_period;
assert door=door2 and alarm=alarm2
report "daytime happy scenario 1 error"
severity error;
wait for clk_period;

--daytime happy scenario 2 test.
reset<='1';
reset2<='1';
wait for clk_period;
reset<='0';
code<="0010";
reset2<='0';
code2<="0010";
wait for clk_period;
code<="0110";
code2<="0110";
wait for clk_period;
code<="1010";
code2<="1010";
wait for clk_period;
code<="1101";
code2<="1101";
wait for clk_period;
assert door=door2 and alarm=alarm2
report "daytime happy scenario 2 error"
severity error;
wait for clk_period;

--daytime happy scenario 3 test.
reset<='1';
reset2<='1';
wait for clk_period;
reset<='0';
code<="0010";
reset2<='0';
code2<="0010";
wait for clk_period;
code<="0110";
code2<="0110";
wait for clk_period;
code<="1010";
code2<="1010";
wait for clk_period;
code<="0000";
code2<="0000";
wait for clk_period;
code<="0101";
code2<="0101";
wait for 2*clk_period;
assert door=door2 and alarm=alarm2
report "daytime happy scenario 3 error"
severity error;
wait for clk_period;

--alarm scenario 3 test.
reset<='1';
daytime<='1';
reset2<='1';
daytime2<='1';
wait for clk_period;
reset<='0';
code<="0000";
reset2<='0';
code2<="0000";
wait for clk_period;
assert door=door2 and alarm=alarm2
report "alarm scenario 3 error"
severity error;
wait for clk_period;

-------------test on
reset2<='1';
wait for clk_period;
reset2<='0';
daytime2<='0';
sequence<="00100110101000000101";
test<='1';
for i in 0 to sequence'length-1 loop
	scanin<=sequence(i);
	wait for clk_period;
	if i>=3 then
		assert scanout=sequence(i-2)
		report "scanout doesn't follow scanin"
		severity error;
	end if;
end loop;

wait;
end process p;
end architecture test;
