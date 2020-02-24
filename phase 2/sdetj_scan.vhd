LIBRARY sxlib_ModelSim;

entity sdetj_scan is
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
end sdetj_scan;

architecture structural of sdetj_scan is
Component inv_x2
   port (
      i   : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa22_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o2_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component a3_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component noa22_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component na3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no3_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component o4_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no2_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component no4_x1
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      nq  : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component oa2ao222_x2
   port (
      i0  : in      bit;
      i1  : in      bit;
      i2  : in      bit;
      i3  : in      bit;
      i4  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component sff2_x4
   port (
      ck  : in      bit;
      cmd : in      bit;
      i0  : in      bit;
      i1  : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

Component buf_x2
   port (
      i   : in      bit;
      q   : out     bit;
      vdd : in      bit;
      vss : in      bit
 );
end component;

signal dacs_cs        : bit_vector( 2 downto 0);
signal not_code       : bit_vector( 3 downto 0);
signal not_dacs_cs    : bit_vector( 2 downto 0);
signal oa22_x2_sig    : bit;
signal o4_x2_sig      : bit;
signal o2_x2_sig      : bit;
signal not_reset      : bit;
signal not_daytime    : bit;
signal not_dacs_ns_s6 : bit;
signal not_dacs_ns_s2 : bit;
signal not_dacs_cs_sf : bit;
signal noa22_x1_sig   : bit;
signal no4_x1_sig     : bit;
signal no4_x1_4_sig   : bit;
signal no4_x1_3_sig   : bit;
signal no4_x1_2_sig   : bit;
signal no3_x1_sig     : bit;
signal no3_x1_4_sig   : bit;
signal no3_x1_3_sig   : bit;
signal no3_x1_2_sig   : bit;
signal no2_x1_sig     : bit;
signal no2_x1_6_sig   : bit;
signal no2_x1_5_sig   : bit;
signal no2_x1_4_sig   : bit;
signal no2_x1_3_sig   : bit;
signal no2_x1_2_sig   : bit;
signal na4_x1_sig     : bit;
signal na4_x1_2_sig   : bit;
signal na3_x1_sig     : bit;
signal na3_x1_6_sig   : bit;
signal na3_x1_5_sig   : bit;
signal na3_x1_4_sig   : bit;
signal na3_x1_3_sig   : bit;
signal na3_x1_2_sig   : bit;
signal na2_x1_sig     : bit;
signal na2_x1_5_sig   : bit;
signal na2_x1_4_sig   : bit;
signal na2_x1_3_sig   : bit;
signal na2_x1_2_sig   : bit;
signal a4_x2_sig      : bit;
signal a4_x2_4_sig    : bit;
signal a4_x2_3_sig    : bit;
signal a4_x2_2_sig    : bit;
signal a3_x2_sig      : bit;
signal a3_x2_4_sig    : bit;
signal a3_x2_3_sig    : bit;
signal a3_x2_2_sig    : bit;
signal a2_x2_sig      : bit;

begin

a3_x2_ins : a3_x2
   port map (
      i0  => dacs_cs(1),
      i1  => dacs_cs(0),
      i2  => not_dacs_cs(2),
      q   => a3_x2_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_ins : a4_x2
   port map (
      i0  => not_code(0),
      i1  => not_code(3),
      i2  => code(2),
      i3  => code(1),
      q   => a4_x2_sig,
      vdd => vdd,
      vss => vss
   );

not_dacs_ns_s6_ins : na2_x1
   port map (
      i0  => a4_x2_sig,
      i1  => a3_x2_sig,
      nq  => not_dacs_ns_s6,
      vdd => vdd,
      vss => vss
   );

a3_x2_2_ins : a3_x2
   port map (
      i0  => dacs_cs(2),
      i1  => dacs_cs(0),
      i2  => not_dacs_cs(1),
      q   => a3_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_2_ins : a4_x2
   port map (
      i0  => not_code(0),
      i1  => not_code(3),
      i2  => not_code(2),
      i3  => code(1),
      q   => a4_x2_2_sig,
      vdd => vdd,
      vss => vss
   );

not_dacs_ns_s2_ins : na2_x1
   port map (
      i0  => a4_x2_2_sig,
      i1  => a3_x2_2_sig,
      nq  => not_dacs_ns_s2,
      vdd => vdd,
      vss => vss
   );

not_dacs_cs_sf_ins : na3_x1
   port map (
      i0  => dacs_cs(1),
      i1  => dacs_cs(0),
      i2  => dacs_cs(2),
      nq  => not_dacs_cs_sf,
      vdd => vdd,
      vss => vss
   );

not_dacs_cs_0_ins : inv_x2
   port map (
      i   => dacs_cs(0),
      nq  => not_dacs_cs(0),
      vdd => vdd,
      vss => vss
   );

not_dacs_cs_1_ins : inv_x2
   port map (
      i   => dacs_cs(1),
      nq  => not_dacs_cs(1),
      vdd => vdd,
      vss => vss
   );

not_dacs_cs_2_ins : inv_x2
   port map (
      i   => dacs_cs(2),
      nq  => not_dacs_cs(2),
      vdd => vdd,
      vss => vss
   );

not_reset_ins : inv_x2
   port map (
      i   => reset,
      nq  => not_reset,
      vdd => vdd,
      vss => vss
   );

not_daytime_ins : inv_x2
   port map (
      i   => daytime,
      nq  => not_daytime,
      vdd => vdd,
      vss => vss
   );

not_code_3_ins : inv_x2
   port map (
      i   => code(3),
      nq  => not_code(3),
      vdd => vdd,
      vss => vss
   );

not_code_2_ins : inv_x2
   port map (
      i   => code(2),
      nq  => not_code(2),
      vdd => vdd,
      vss => vss
   );

not_code_1_ins : inv_x2
   port map (
      i   => code(1),
      nq  => not_code(1),
      vdd => vdd,
      vss => vss
   );

not_code_0_ins : inv_x2
   port map (
      i   => code(0),
      nq  => not_code(0),
      vdd => vdd,
      vss => vss
   );

na3_x1_ins : na3_x1
   port map (
      i0  => not_dacs_cs(2),
      i1  => dacs_cs(1),
      i2  => not_dacs_cs(0),
      nq  => na3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_ins : na4_x1
   port map (
      i0  => code(2),
      i1  => not_code(3),
      i2  => code(0),
      i3  => not_code(1),
      nq  => na4_x1_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_ins : no2_x1
   port map (
      i0  => na4_x1_sig,
      i1  => na3_x1_sig,
      nq  => no2_x1_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_2_ins : na2_x1
   port map (
      i0  => not_dacs_cs_sf,
      i1  => not_dacs_ns_s2,
      nq  => na2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_2_ins : no3_x1
   port map (
      i0  => dacs_cs(2),
      i1  => not_dacs_cs(0),
      i2  => dacs_cs(1),
      nq  => no3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_ins : no3_x1
   port map (
      i0  => no3_x1_2_sig,
      i1  => na2_x1_2_sig,
      i2  => no2_x1_sig,
      nq  => no3_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_2_ins : na3_x1
   port map (
      i0  => daytime,
      i1  => code(3),
      i2  => code(2),
      nq  => na3_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_ins : no4_x1
   port map (
      i0  => not_code(0),
      i1  => code(1),
      i2  => na3_x1_2_sig,
      i3  => reset,
      nq  => no4_x1_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_2_ins : no2_x1
   port map (
      i0  => reset,
      i1  => no4_x1_sig,
      nq  => no2_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_ins : na2_x1
   port map (
      i0  => no2_x1_2_sig,
      i1  => no3_x1_sig,
      nq  => na2_x1_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_3_ins : no3_x1
   port map (
      i0  => not_daytime,
      i1  => not_code(3),
      i2  => not_code(2),
      nq  => no3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_3_ins : a4_x2
   port map (
      i0  => no3_x1_3_sig,
      i1  => not_code(1),
      i2  => code(0),
      i3  => not_reset,
      q   => a4_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

no3_x1_4_ins : no3_x1
   port map (
      i0  => not_dacs_cs(2),
      i1  => dacs_cs(1),
      i2  => dacs_cs(0),
      nq  => no3_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_2_ins : no4_x1
   port map (
      i0  => code(2),
      i1  => code(1),
      i2  => code(3),
      i3  => code(0),
      nq  => no4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_3_ins : na2_x1
   port map (
      i0  => no4_x1_2_sig,
      i1  => no3_x1_4_sig,
      nq  => na2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_4_ins : na3_x1
   port map (
      i0  => not_dacs_cs(2),
      i1  => dacs_cs(0),
      i2  => not_dacs_cs(1),
      nq  => na3_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

a2_x2_ins : a2_x2
   port map (
      i0  => not_dacs_ns_s6,
      i1  => not_dacs_ns_s2,
      q   => a2_x2_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_3_ins : na3_x1
   port map (
      i0  => a2_x2_sig,
      i1  => na3_x1_4_sig,
      i2  => na2_x1_3_sig,
      nq  => na3_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

oa22_x2_ins : oa22_x2
   port map (
      i0  => na3_x1_3_sig,
      i1  => not_reset,
      i2  => a4_x2_3_sig,
      q   => oa22_x2_sig,
      vdd => vdd,
      vss => vss
   );

a3_x2_3_ins : a3_x2
   port map (
      i0  => not_dacs_cs(2),
      i1  => dacs_cs(0),
      i2  => not_dacs_cs(1),
      q   => a3_x2_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_5_ins : na2_x1
   port map (
      i0  => not_dacs_cs_sf,
      i1  => not_dacs_ns_s6,
      nq  => na2_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

o2_x2_ins : o2_x2
   port map (
      i0  => na2_x1_5_sig,
      i1  => a3_x2_3_sig,
      q   => o2_x2_sig,
      vdd => vdd,
      vss => vss
   );

a4_x2_4_ins : a4_x2
   port map (
      i0  => not_code(0),
      i1  => code(3),
      i2  => not_code(2),
      i3  => code(1),
      q   => a4_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

a3_x2_4_ins : a3_x2
   port map (
      i0  => dacs_cs(2),
      i1  => dacs_cs(1),
      i2  => not_dacs_cs(0),
      q   => a3_x2_4_sig,
      vdd => vdd,
      vss => vss
   );

noa22_x1_ins : noa22_x1
   port map (
      i0  => a3_x2_4_sig,
      i1  => a4_x2_4_sig,
      i2  => o2_x2_sig,
      nq  => noa22_x1_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_5_ins : na3_x1
   port map (
      i0  => daytime,
      i1  => code(3),
      i2  => code(2),
      nq  => na3_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_3_ins : no4_x1
   port map (
      i0  => not_code(0),
      i1  => code(1),
      i2  => na3_x1_5_sig,
      i3  => reset,
      nq  => no4_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_3_ins : no2_x1
   port map (
      i0  => reset,
      i1  => no4_x1_3_sig,
      nq  => no2_x1_3_sig,
      vdd => vdd,
      vss => vss
   );

na2_x1_4_ins : na2_x1
   port map (
      i0  => no2_x1_3_sig,
      i1  => noa22_x1_sig,
      nq  => na2_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

na4_x1_2_ins : na4_x1
   port map (
      i0  => daytime,
      i1  => code(3),
      i2  => code(2),
      i3  => not_code(1),
      nq  => na4_x1_2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_4_ins : no2_x1
   port map (
      i0  => not_code(0),
      i1  => na4_x1_2_sig,
      nq  => no2_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

na3_x1_6_ins : na3_x1
   port map (
      i0  => not_dacs_cs(2),
      i1  => not_dacs_cs(1),
      i2  => not_dacs_cs(0),
      nq  => na3_x1_6_sig,
      vdd => vdd,
      vss => vss
   );

alarm_ins : no3_x1
   port map (
      i0  => reset,
      i1  => na3_x1_6_sig,
      i2  => no2_x1_4_sig,
      nq  => alarm,
      vdd => vdd,
      vss => vss
   );

no2_x1_5_ins : no2_x1
   port map (
      i0  => reset,
      i1  => not_dacs_cs_sf,
      nq  => no2_x1_5_sig,
      vdd => vdd,
      vss => vss
   );

o4_x2_ins : o4_x2
   port map (
      i0  => code(1),
      i1  => not_code(3),
      i2  => not_daytime,
      i3  => not_code(2),
      q   => o4_x2_sig,
      vdd => vdd,
      vss => vss
   );

no2_x1_6_ins : no2_x1
   port map (
      i0  => reset,
      i1  => not_daytime,
      nq  => no2_x1_6_sig,
      vdd => vdd,
      vss => vss
   );

no4_x1_4_ins : no4_x1
   port map (
      i0  => not_code(2),
      i1  => not_code(3),
      i2  => not_code(0),
      i3  => code(1),
      nq  => no4_x1_4_sig,
      vdd => vdd,
      vss => vss
   );

door_ins : oa2ao222_x2
   port map (
      i0  => no4_x1_4_sig,
      i1  => no2_x1_6_sig,
      i2  => o4_x2_sig,
      i3  => not_code(0),
      i4  => no2_x1_5_sig,
      q   => door,
      vdd => vdd,
      vss => vss
   );

dacs_cs_0_ins_scan_0 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => na2_x1_sig,
      i1  => scanin,
      q   => dacs_cs(0),
      vdd => vdd,
      vss => vss
   );

dacs_cs_1_ins_scan_1 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => oa22_x2_sig,
      i1  => dacs_cs(0),
      q   => dacs_cs(1),
      vdd => vdd,
      vss => vss
   );

dacs_cs_2_ins_scan_2 : sff2_x4
   port map (
      ck  => clk,
      cmd => test,
      i0  => na2_x1_4_sig,
      i1  => dacs_cs(1),
      q   => dacs_cs(2),
      vdd => vdd,
      vss => vss
   );

buf_scan_3 : buf_x2
   port map (
      i   => dacs_cs(2),
      q   => scanout,
      vdd => vdd,
      vss => vss
   );


end structural;
