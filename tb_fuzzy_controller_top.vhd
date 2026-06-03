library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_fuzzy_controller is
-- Testbench tidak memiliki port input/output
end tb_fuzzy_controller;

architecture behavior of tb_fuzzy_controller is

    -- 1. Deklarasi Komponen Top Module yang akan diuji (Unit Under Test)
    component fuzzy_controller_top
    Port (
        distance_in : in std_logic_vector(7 downto 0);
        speed_in    : in std_logic_vector(7 downto 0);
        brake_out   : out std_logic_vector(7 downto 0)
    );
    end component;

    -- 2. Sinyal internal untuk dihubungkan ke port komponen
    -- Inisialisasi awal ke nilai '0'
    signal tb_distance : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_speed    : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_brake    : std_logic_vector(7 downto 0);

begin

    -- 3. Memasang (Instansiasi) Top Module
    uut: fuzzy_controller_top port map (
        distance_in => tb_distance,
        speed_in    => tb_speed,
        brake_out   => tb_brake
    );

    -- 4. Proses injeksi sinyal (Stimulus)
    stim_proc: process
    begin
        -- Beri jeda awal sebelum simulasi mulai
        wait for 10 ns; 

        -- =======================================================
        -- TEST CASE 1: Bahaya! (Rule 1)
        -- Jarak: Sangat Dekat (~20) | Kecepatan: Sangat Lambat (~20)
        -- Ekspektasi Output: Rem Sangat Tinggi (Mendekati 255)
        -- =======================================================
        tb_distance <= std_logic_vector(to_unsigned(20, 8)); 
        tb_speed    <= std_logic_vector(to_unsigned(20, 8));
        wait for 20 ns;

        -- =======================================================
        -- TEST CASE 2: Aman (Rule 8)
        -- Jarak: Jauh (~200) | Kecepatan: Cepat (~150)
        -- Ekspektasi Output: Rem Sangat Rendah (Mendekati 0)
        -- =======================================================
        tb_distance <= std_logic_vector(to_unsigned(200, 8));
        tb_speed    <= std_logic_vector(to_unsigned(150, 8));
        wait for 20 ns;

        -- =======================================================
        -- TEST CASE 3: Peringatan (Rule 10)
        -- Jarak: Dekat (~100) | Kecepatan: Sangat Cepat (~220)
        -- Ekspektasi Output: Rem Tinggi (Mendekati 170)
        -- =======================================================
        tb_distance <= std_logic_vector(to_unsigned(100, 8));
        tb_speed    <= std_logic_vector(to_unsigned(220, 8));
        wait for 20 ns;

        -- =======================================================
        -- TEST CASE 4: Hati-hati (Rule 4)
        -- Jarak: Dekat (~100) | Kecepatan: Lambat (~100)
        -- Ekspektasi Output: Rem Rendah (Mendekati 85)
        -- =======================================================
        tb_distance <= std_logic_vector(to_unsigned(100, 8));
        tb_speed    <= std_logic_vector(to_unsigned(100, 8));
        wait for 20 ns;

        -- =======================================================
        -- TEST CASE 5: Sweep Dinamis
        -- Menyuntikkan sinyal yang berubah-ubah secara otomatis
        -- =======================================================
        for i in 0 to 5 loop
            -- Jarak semakin jauh, kecepatan semakin turun
            tb_distance <= std_logic_vector(to_unsigned(i * 40, 8));
            tb_speed    <= std_logic_vector(to_unsigned(250 - (i * 30), 8));
            wait for 20 ns;
        end loop;

        -- Menghentikan simulasi secara elegan
        report "Simulasi VHDL Fuzzy Controller Selesai!";
        wait; 
        
    end process;

end behavior;