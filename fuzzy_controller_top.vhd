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
    component fuzzifier
        Port (
            distance : in unsigned(7 downto 0);
            speed    : in unsigned(7 downto 0);
            mu_d_vc  : out unsigned(7 downto 0);
            mu_d_c   : out unsigned(7 downto 0);
            mu_d_f   : out unsigned(7 downto 0);
            mu_d_vf  : out unsigned(7 downto 0);
            mu_s_vs  : out unsigned(7 downto 0);
            mu_s_s   : out unsigned(7 downto 0);
            mu_s_f   : out unsigned(7 downto 0);
            mu_s_vf  : out unsigned(7 downto 0)
        );
    end component;

    component inference_engine
        Port (
            mu_d_vc : in unsigned(7 downto 0);
            mu_d_c  : in unsigned(7 downto 0);
            mu_d_f  : in unsigned(7 downto 0);
            mu_d_vf : in unsigned(7 downto 0);
            mu_s_vs : in unsigned(7 downto 0);
            mu_s_s  : in unsigned(7 downto 0);
            mu_s_f  : in unsigned(7 downto 0);
            mu_s_vf : in unsigned(7 downto 0);
            w_vl    : out unsigned(7 downto 0);
            w_l     : out unsigned(7 downto 0);
            w_h     : out unsigned(7 downto 0);
            w_vh    : out unsigned(7 downto 0)
        );
    end component;

    component defuzzifier
        Port (
            w_vl  : in unsigned(7 downto 0);
            w_l   : in unsigned(7 downto 0);
            w_h   : in unsigned(7 downto 0);
            w_vh  : in unsigned(7 downto 0);
            brake : out unsigned(7 downto 0)
        );
    end component;

    signal dist_u, speed_u, brake_u : unsigned(7 downto 0);
    signal md_vc, md_c, md_f, md_vf  : unsigned(7 downto 0);
    signal ms_vs, ms_s, ms_f, ms_vf  : unsigned(7 downto 0);
    signal wl, wl_l, wh, wvh         : unsigned(7 downto 0);
begin
    dist_u <= unsigned(distance_in);
    speed_u <= unsigned(speed_in);
    brake_out <= std_logic_vector(brake_u);

    u1: fuzzifier port map (
        distance => dist_u, speed => speed_u,
        mu_d_vc => md_vc, mu_d_c => md_c, mu_d_f => md_f, mu_d_vf => md_vf,
        mu_s_vs => ms_vs, mu_s_s => ms_s, mu_s_f => ms_f, mu_s_vf => ms_vf
    );

    u2: inference_engine port map (
        mu_d_vc => md_vc, mu_d_c => md_c, mu_d_f => md_f, mu_d_vf => md_vf,
        mu_s_vs => ms_vs, mu_s_s => ms_s, mu_s_f => ms_f, mu_s_vf => ms_vf,
        w_vl => wl, w_l => wl_l, w_h => wh, w_vh => wvh
    );

    u3: defuzzifier port map (
        w_vl => wl, w_l => wl_l, w_h => wh, w_vh => wvh,
        brake => brake_u
    );
end Structural;
