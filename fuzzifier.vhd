library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fuzzifier is
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
end fuzzifier;

architecture Behavioral of fuzzifier is
begin
    -- Perhitungan Membership Function untuk Distance
    process(distance)
    begin
        if distance < 85 then
            dist_vclose <= 255 - (distance * 3);
            dist_close  <= distance * 3;
            dist_far    <= to_unsigned(0, 8);
            dist_vfar   <= to_unsigned(0, 8);
        elsif distance < 170 then
            dist_vclose <= to_unsigned(0, 8);
            dist_close  <= 255 - ((distance - 85) * 3);
            dist_far    <= (distance - 85) * 3;
            dist_vfar   <= to_unsigned(0, 8);
        else
            dist_vclose <= to_unsigned(0, 8);
            dist_close  <= to_unsigned(0, 8);
            dist_far    <= 255 - ((distance - 170) * 3);
            dist_vfar   <= (distance - 170) * 3;
        end if;
    end process;

    -- Perhitungan Membership Function untuk Speed
    process(speed)
    begin
        if speed < 85 then
            speed_vslow <= 255 - (speed * 3);
            speed_slow  <= speed * 3;
            speed_fast  <= to_unsigned(0, 8);
            speed_vfast <= to_unsigned(0, 8);
        elsif speed < 170 then
            speed_vslow <= to_unsigned(0, 8);
            speed_slow  <= 255 - ((speed - 85) * 3);
            speed_fast  <= (speed - 85) * 3;
            speed_vfast <= to_unsigned(0, 8);
        else
            speed_vslow <= to_unsigned(0, 8);
            speed_slow  <= to_unsigned(0, 8);
            speed_fast  <= 255 - ((speed - 170) * 3);
            speed_vfast <= (speed - 170) * 3;
        end if;
    end process;
end Behavioral;