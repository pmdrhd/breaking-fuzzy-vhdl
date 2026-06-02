library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_fuzzy_controller_top is
-- Testbench tidak memiliki port eksternal
end tb_fuzzy_controller_top;

architecture behavior of tb_fuzzy_controller_top is

    -- Deklarasi komponen untuk Unit Under Test (UUT)
    component fuzzy_controller_top
        Port (
            distance_in : in std_logic_vector(7 downto 0);
            speed_in    : in std_logic_vector(7 downto 0);
            brake_out   : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Sinyal Input (diinisialisasi ke 0)
    signal distance_in : std_logic_vector(7 downto 0) := (others => '0');
    signal speed_in    : std_logic_vector(7 downto 0) := (others => '0');

    -- Sinyal Output
    signal brake_out   : std_logic_vector(7 downto 0);

begin

    -- Instansiasi Unit Under Test (UUT)
    uut: fuzzy_controller_top PORT MAP (
        distance_in => distance_in,
        speed_in    => speed_in,
        brake_out   => brake_out
    );

    -- Proses pemberian stimulus (Test Cases)
    stim_proc: process
    begin
        -- Berikan waktu inisialisasi awal
        wait for 10 ns;

        -- Test Case 1: Jarak sangat dekat (0), Kecepatan sangat cepat (255)
        -- Ekspektasi: Pengereman (brake) maksimum/sangat kuat
        distance_in <= std_logic_vector(to_unsigned(0, 8));
        speed_in    <= std_logic_vector(to_unsigned(255, 8));
        wait for 20 ns;

        -- Test Case 2: Jarak sangat jauh (255), Kecepatan sangat lambat (0)
        -- Ekspektasi: Pengereman (brake) sangat kecil atau nol
        distance_in <= std_logic_vector(to_unsigned(255, 8));
        speed_in    <= std_logic_vector(to_unsigned(0, 8));
        wait for 20 ns;

        -- Test Case 3: Jarak dekat (85), Kecepatan cepat (170)
        distance_in <= std_logic_vector(to_unsigned(85, 8));
        speed_in    <= std_logic_vector(to_unsigned(170, 8));
        wait for 20 ns;

        -- Test Case 4: Jarak menengah (120), Kecepatan menengah (120)
        distance_in <= std_logic_vector(to_unsigned(120, 8));
        speed_in    <= std_logic_vector(to_unsigned(120, 8));
        wait for 20 ns;

        -- Test Case 5: Jarak jauh (170), Kecepatan lambat (85)
        distance_in <= std_logic_vector(to_unsigned(170, 8));
        speed_in    <= std_logic_vector(to_unsigned(85, 8));
        wait for 20 ns;

        -- Hentikan simulasi
        wait;
    end process;

end behavior;
