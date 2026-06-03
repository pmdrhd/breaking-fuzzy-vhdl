library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fuzzy_controller_top is
    Port (
        distance_in : in std_logic_vector(7 downto 0);
        speed_in    : in std_logic_vector(7 downto 0);
        brake_out   : out std_logic_vector(7 downto 0)
    );
end fuzzy_controller_top;

architecture Structural of fuzzy_controller_top is
    -- Deklarasi Komponen
    component fuzzifier
        Port (
            distance    : in unsigned(7 downto 0);
            speed       : in unsigned(7 downto 0);
            dist_vclose : out unsigned(7 downto 0);
            dist_close  : out unsigned(7 downto 0);
            dist_far    : out unsigned(7 downto 0);
            dist_vfar   : out unsigned(7 downto 0);
            speed_vslow : out unsigned(7 downto 0);
            speed_slow  : out unsigned(7 downto 0);
            speed_fast  : out unsigned(7 downto 0);
            speed_vfast : out unsigned(7 downto 0)
        );
    end component;

    component inference_engine
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
    end component;

    component defuzzifier
        Port (
            brake_vlow_wt  : in unsigned(7 downto 0);
            brake_low_wt   : in unsigned(7 downto 0);
            brake_high_wt  : in unsigned(7 downto 0);
            brake_vhigh_wt : in unsigned(7 downto 0);
            brake_out      : out unsigned(7 downto 0)
        );
    end component;

    -- Sinyal Penghubung Internal (Wires)
    signal dist_unsigned, speed_unsigned, brake_unsigned : unsigned(7 downto 0);
    
    signal sig_dist_vclose, sig_dist_close, sig_dist_far, sig_dist_vfar : unsigned(7 downto 0);
    signal sig_speed_vslow, sig_speed_slow, sig_speed_fast, sig_speed_vfast : unsigned(7 downto 0);
    
    signal sig_brake_vlow_wt, sig_brake_low_wt, sig_brake_high_wt, sig_brake_vhigh_wt : unsigned(7 downto 0);

begin
    -- Konversi port input (STD_LOGIC_VECTOR ke UNSIGNED)
    dist_unsigned <= unsigned(distance_in);
    speed_unsigned <= unsigned(speed_in);
    brake_out <= std_logic_vector(brake_unsigned);

    -- Instansiasi Blok Fuzzifier
    U1_Fuzzifier: fuzzifier port map (
        distance    => dist_unsigned, 
        speed       => speed_unsigned,
        dist_vclose => sig_dist_vclose, 
        dist_close  => sig_dist_close, 
        dist_far    => sig_dist_far, 
        dist_vfar   => sig_dist_vfar,
        speed_vslow => sig_speed_vslow, 
        speed_slow  => sig_speed_slow, 
        speed_fast  => sig_speed_fast, 
        speed_vfast => sig_speed_vfast
    );

    -- Instansiasi Blok Inference Engine
    U2_Inference: inference_engine port map (
        dist_vclose => sig_dist_vclose, 
        dist_close  => sig_dist_close, 
        dist_far    => sig_dist_far, 
        dist_vfar   => sig_dist_vfar,
        speed_vslow => sig_speed_vslow, 
        speed_slow  => sig_speed_slow, 
        speed_fast  => sig_speed_fast, 
        speed_vfast => sig_speed_vfast,
        brake_vlow_wt  => sig_brake_vlow_wt, 
        brake_low_wt   => sig_brake_low_wt, 
        brake_high_wt  => sig_brake_high_wt, 
        brake_vhigh_wt => sig_brake_vhigh_wt
    );

    -- Instansiasi Blok Defuzzifier
    U3_Defuzzifier: defuzzifier port map (
        brake_vlow_wt  => sig_brake_vlow_wt, 
        brake_low_wt   => sig_brake_low_wt, 
        brake_high_wt  => sig_brake_high_wt, 
        brake_vhigh_wt => sig_brake_vhigh_wt,
        brake_out      => brake_unsigned
    );
end Structural;