LIBRARY sxlib_ModelSim;

entity tb2 is
end entity tb2;

architecture test of tb2 is

component dacs is
port( vdd,clk,vss,reset,daytime: in bit;
	code: in bit_vector(3 downto 0);
	door,alarm: out bit );
end component dacs;

component sdetj_b_l is
   port (
      vdd     : in      bit;
      clk     : in      bit;
      vss     : in      bit;
      reset   : in      bit;
      daytime : in      bit;
      code    : in      bit_vector(3 downto 0);
      door    : out     bit;
      alarm   : out     bit
 );
end component sdetj_b_l;


signal vdd,vss,clk,reset,daytime,door,alarm:bit;
signal code:bit_vector(3 downto 0);
signal reset2,daytime2,door2,alarm2:bit;
signal code2:bit_vector(3 downto 0);
constant clk_period : time := 100ns;
for dut:dacs use entity work.dacs(behav);
for dut2:sdetj_b_l use entity work.sdetj_b_l(structural);
begin
dut:dacs port map(vdd,clk,vss,reset,daytime,code,door,alarm);
dut2:sdetj_b_l port map(vdd,clk,vss,reset2,daytime2,code2,door2,alarm2);
clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;  
        clk <= '1';
        wait for clk_period/2;  
   end process;

p:process
begin
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

wait;
end process p;
end architecture test;
