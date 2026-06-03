library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inference_engine is
    Port (
        dist_vclose : in unsigned(7 downto 0);
        dist_close  : in unsigned(7 downto 0);
        dist_far    : in unsigned(7 downto 0);
        dist_vfar   : in unsigned(7 downto 0);
        speed_vslow : in unsigned(7 downto 0);
        speed_slow  : in unsigned(7 downto 0);
        speed_fast  : in unsigned(7 downto 0);
        speed_vfast : in unsigned(7 downto 0);
        
        brake_vlow_wt  : out unsigned(7 downto 0);
        brake_low_wt   : out unsigned(7 downto 0);
        brake_high_wt  : out unsigned(7 downto 0);
        brake_vhigh_wt : out unsigned(7 downto 0)
    );
end inference_engine;

architecture Behavioral of inference_engine is
    pure function min_val(a : unsigned; b : unsigned) return unsigned is
    begin
        if a < b then return a; else return b; end if;
    end function;

    pure function max_val(a : unsigned; b : unsigned) return unsigned is
    begin
        if a > b then return a; else return b; end if;
    end function;

    -- Variabel untuk menampung kekuatan (strength) tiap rule
    signal rule1, rule2, rule3, rule4, rule5, rule6, rule7, rule8, rule9, rule10, rule11, rule12 : unsigned(7 downto 0);
    signal rule13, rule14, rule15, rule16 : unsigned(7 downto 0);
begin
    -- Evaluasi Rule menggunakan operator MIN (AND)
    rule1 <= min_val(dist_vclose, speed_vslow);
    rule3 <= min_val(dist_vclose, speed_slow);
    rule6 <= min_val(dist_vclose, speed_fast);
    rule9 <= min_val(dist_vclose, speed_vfast);

    rule2  <= min_val(dist_close, speed_vslow);
    rule4  <= min_val(dist_close, speed_slow);
    rule7  <= min_val(dist_close, speed_fast);
    rule10 <= min_val(dist_close, speed_vfast);

    rule16 <= min_val(dist_far, speed_vslow);
    rule5  <= min_val(dist_far, speed_slow);
    rule8  <= min_val(dist_far, speed_fast);
    rule11 <= min_val(dist_far, speed_vfast);

    rule13 <= min_val(dist_vfar, speed_vslow);
    rule14 <= min_val(dist_vfar, speed_slow);
    rule15 <= min_val(dist_vfar, speed_fast);
    rule12 <= min_val(dist_vfar, speed_vfast);

    -- Agregasi bobot rem menggunakan operator MAX (OR)
    brake_vhigh_wt <= max_val(max_val(max_val(rule1, rule3), rule6), rule9);
    brake_high_wt  <= rule10;
    brake_low_wt   <= max_val(max_val(rule4, rule7), rule11);
    brake_vlow_wt  <= max_val(max_val(max_val(max_val(max_val(max_val(max_val(rule2, rule5), rule8), rule12), rule13), rule14), rule15), rule16);
end Behavioral;