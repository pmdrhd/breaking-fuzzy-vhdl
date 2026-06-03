library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity defuzzifier is
    Port (
        brake_vlow_wt  : in unsigned(7 downto 0);
        brake_low_wt   : in unsigned(7 downto 0);
        brake_high_wt  : in unsigned(7 downto 0);
        brake_vhigh_wt : in unsigned(7 downto 0);
        brake_out      : out unsigned(7 downto 0)
    );
end defuzzifier;

architecture Behavioral of defuzzifier is
    signal numerator   : unsigned(19 downto 0);
    signal denominator : unsigned(9 downto 0);
    
    signal prod_vlow   : unsigned(15 downto 0);
    signal prod_low    : unsigned(15 downto 0);
    signal prod_high   : unsigned(15 downto 0);
    signal prod_vhigh  : unsigned(15 downto 0);
begin
    -- Mengalikan bobot (weight) dengan nilai konstan (singleton)
    prod_vlow  <= brake_vlow_wt * to_unsigned(0, 8);
    prod_low   <= brake_low_wt * to_unsigned(85, 8);
    prod_high  <= brake_high_wt * to_unsigned(170, 8);
    prod_vhigh <= brake_vhigh_wt * to_unsigned(255, 8);

    -- Menghitung total pembilang dan penyebut
    numerator   <= resize(prod_vlow, 20) + resize(prod_low, 20) + resize(prod_high, 20) + resize(prod_vhigh, 20);
    denominator <= resize(brake_vlow_wt, 10) + resize(brake_low_wt, 10) + resize(brake_high_wt, 10) + resize(brake_vhigh_wt, 10);

    -- Proses pembagian (Weighted Average)
    process(numerator, denominator)
    begin
        if denominator = 0 then
            brake_out <= to_unsigned(0, 8);
        else
            brake_out <= resize(numerator / denominator, 8);
        end if;
    end process;
end Behavioral;