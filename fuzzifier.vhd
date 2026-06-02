library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fuzzifier is
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
end fuzzifier;

architecture Behavioral of fuzzifier is
begin
    -- Proses Fuzzifikasi untuk Jarak (Distance)
    process(distance)
    begin
        if distance < to_unsigned(85, 8) then
            mu_d_vc <= to_unsigned(255, 8) - resize(distance * to_unsigned(3, 8), 8);
            mu_d_c  <= resize(distance * to_unsigned(3, 8), 8);
            mu_d_f  <= to_unsigned(0, 8);
            mu_d_vf <= to_unsigned(0, 8);
        elsif distance < to_unsigned(170, 8) then
            mu_d_vc <= to_unsigned(0, 8);
            mu_d_c  <= to_unsigned(255, 8) - resize((distance - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            mu_d_f  <= resize((distance - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            mu_d_vf <= to_unsigned(0, 8);
        else
            mu_d_vc <= to_unsigned(0, 8);
            mu_d_c  <= to_unsigned(0, 8);
            mu_d_f  <= to_unsigned(255, 8) - resize((distance - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
            mu_d_vf <= resize((distance - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
        end if;
    end process;

    -- Proses Fuzzifikasi untuk Kecepatan (Speed)
    process(speed)
    begin
        if speed < to_unsigned(85, 8) then
            mu_s_vs <= to_unsigned(255, 8) - resize(speed * to_unsigned(3, 8), 8);
            mu_s_s  <= resize(speed * to_unsigned(3, 8), 8);
            mu_s_f  <= to_unsigned(0, 8);
            mu_s_vf <= to_unsigned(0, 8);
        elsif speed < to_unsigned(170, 8) then
            mu_s_vs <= to_unsigned(0, 8);
            mu_s_s  <= to_unsigned(255, 8) - resize((speed - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            mu_s_f  <= resize((speed - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            mu_s_vf <= to_unsigned(0, 8);
        else
            mu_s_vs <= to_unsigned(0, 8);
            mu_s_s  <= to_unsigned(0, 8);
            mu_s_f  <= to_unsigned(255, 8) - resize((speed - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
            mu_s_vf <= resize((speed - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
        end if;
    end process;
end Behavioral;
