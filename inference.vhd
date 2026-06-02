library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity inference_engine is
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
end inference_engine;

architecture Behavioral of inference_engine is
    pure function min_val(a : unsigned; b : unsigned) return unsigned is
    begin
        if a < b then
            return a;
        else
            return b;
        end if;
    end function;

    pure function max_val(a : unsigned; b : unsigned) return unsigned is
    begin
        if a > b then
            return a;
        else
            return b;
        end if;
    end function;

    signal r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12 : unsigned(7 downto 0);
    signal r13, r14, r15, r16 : unsigned(7 downto 0);
begin
    r1 <= min_val(mu_d_vc, mu_s_vs);
    r3 <= min_val(mu_d_vc, mu_s_s);
    r6 <= min_val(mu_d_vc, mu_s_f);
    r9 <= min_val(mu_d_vc, mu_s_vf);

    r2 <= min_val(mu_d_c, mu_s_vs);
    r4 <= min_val(mu_d_c, mu_s_s);
    r7 <= min_val(mu_d_c, mu_s_f);
    r10 <= min_val(mu_d_c, mu_s_vf);

    r16 <= min_val(mu_d_f, mu_s_vs);
    r5 <= min_val(mu_d_f, mu_s_s);
    r8 <= min_val(mu_d_f, mu_s_f);
    r11 <= min_val(mu_d_f, mu_s_vf);

    r13 <= min_val(mu_d_vf, mu_s_vs);
    r14 <= min_val(mu_d_vf, mu_s_s);
    r15 <= min_val(mu_d_vf, mu_s_f);
    r12 <= min_val(mu_d_vf, mu_s_vf);

    w_vh <= max_val(max_val(max_val(r1, r3), r6), r9);
    w_h  <= r10;
    w_l  <= max_val(max_val(r4, r7), r11);
    w_vl <= max_val(max_val(max_val(max_val(max_val(max_val(max_val(r2, r5), r8), r12), r13), r14), r15), r16);
end Behavioral;
