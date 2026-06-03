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
    -- Proses Fuzzifikasi untuk Jarak (Distance)
    process(distance)
    begin
        if distance < to_unsigned(85, 8) then
            dist_vclose <= to_unsigned(255, 8) - resize(distance * to_unsigned(3, 8), 8);
            dist_close  <= resize(distance * to_unsigned(3, 8), 8);
            dist_far    <= to_unsigned(0, 8);
            dist_vfar   <= to_unsigned(0, 8);
        elsif distance < to_unsigned(170, 8) then
            dist_vclose <= to_unsigned(0, 8);
            dist_close  <= to_unsigned(255, 8) - resize((distance - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            dist_far    <= resize((distance - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            dist_vfar   <= to_unsigned(0, 8);
        else
            dist_vclose <= to_unsigned(0, 8);
            dist_close  <= to_unsigned(0, 8);
            dist_far    <= to_unsigned(255, 8) - resize((distance - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
            dist_vfar   <= resize((distance - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
        end if;
    end process;

    -- Proses Fuzzifikasi untuk Kecepatan (Speed)
    process(speed)
    begin
        if speed < to_unsigned(85, 8) then
            speed_vslow <= to_unsigned(255, 8) - resize(speed * to_unsigned(3, 8), 8);
            speed_slow  <= resize(speed * to_unsigned(3, 8), 8);
            speed_fast  <= to_unsigned(0, 8);
            speed_vfast <= to_unsigned(0, 8);
        elsif speed < to_unsigned(170, 8) then
            speed_vslow <= to_unsigned(0, 8);
            speed_slow  <= to_unsigned(255, 8) - resize((speed - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            speed_fast  <= resize((speed - to_unsigned(85, 8)) * to_unsigned(3, 8), 8);
            speed_vfast <= to_unsigned(0, 8);
        else
            speed_vslow <= to_unsigned(0, 8);
            speed_slow  <= to_unsigned(0, 8);
            speed_fast  <= to_unsigned(255, 8) - resize((speed - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
            speed_vfast <= resize((speed - to_unsigned(170, 8)) * to_unsigned(3, 8), 8);
        end if;
    end process;
end Behavioral;