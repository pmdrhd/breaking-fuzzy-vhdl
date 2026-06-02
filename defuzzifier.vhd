library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity defuzzifier is
    Port (
        w_vl  : in unsigned(7 downto 0);
        w_l   : in unsigned(7 downto 0);
        w_h   : in unsigned(7 downto 0);
        w_vh  : in unsigned(7 downto 0);
        brake : out unsigned(7 downto 0)
    );
end defuzzifier;

architecture Behavioral of defuzzifier is
    signal num  : unsigned(19 downto 0);
    signal den  : unsigned(9 downto 0);
    signal p_vl : unsigned(15 downto 0);
    signal p_l  : unsigned(15 downto 0);
    signal p_h  : unsigned(15 downto 0);
    signal p_vh : unsigned(15 downto 0);
begin
    p_vl <= w_vl * to_unsigned(0, 8);
    p_l  <= w_l * to_unsigned(85, 8);
    p_h  <= w_h * to_unsigned(170, 8);
    p_vh <= w_vh * to_unsigned(255, 8);

    num <= resize(p_vl, 20) + resize(p_l, 20) + resize(p_h, 20) + resize(p_vh, 20);
    den <= resize(w_vl, 10) + resize(w_l, 10) + resize(w_h, 10) + resize(w_vh, 10);

    process(num, den)
    begin
        if den = 0 then
            brake <= to_unsigned(0, 8);
        else
            brake <= resize(num / den, 8);
        end if;
    end process;
end Behavioral;
