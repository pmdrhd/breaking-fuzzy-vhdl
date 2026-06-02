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
    process(distance)
    begin
        if distance < 85 then
            mu_d_vc <= 255 - (distance * 3);
            mu_d_c  <= distance * 3;
            mu_d_f  <= to_unsigned(0, 8);
            mu_d_vf <= to_unsigned(0, 8);
        elsif distance < 170 then
            mu_d_vc <= to_unsigned(0, 8);
            mu_d_c  <= 255 - ((distance - 85) * 3);
            mu_d_f  <= (distance - 85) * 3;
            mu_d_vf <= to_unsigned(0, 8);
        else
            mu_d_vc <= to_unsigned(0, 8);
            mu_d_c  <= to_unsigned(0, 8);
            mu_d_f  <= 255 - ((distance - 170) * 3);
            mu_d_vf <= (distance - 170) * 3;
        end if;
    end process;

    process(speed)
    begin
        if speed < 85 then
            mu_s_vs <= 255 - (speed * 3);
            mu_s_s  <= speed * 3;
            mu_s_f  <= to_unsigned(0, 8);
            mu_s_vf <= to_unsigned(0, 8);
        elsif speed < 170 then
            mu_s_vs <= to_unsigned(0, 8);
            mu_s_s  <= 255 - ((speed - 85) * 3);
            mu_s_f  <= (speed - 85) * 3;
            mu_s_vf <= to_unsigned(0, 8);
        else
            mu_s_vs <= to_unsigned(0, 8);
            mu_s_s  <= to_unsigned(0, 8);
            mu_s_f  <= 255 - ((speed - 170) * 3);
            mu_s_vf <= (speed - 170) * 3;
        end if;
    end process;
end Behavioral;
