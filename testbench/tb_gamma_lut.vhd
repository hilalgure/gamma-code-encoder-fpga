library ieee;
use ieee.std_logic_1164.all;

entity tb_gamma_lut is
end tb_gamma_lut;

architecture sim of tb_gamma_lut is

    component gamma_lut is
        port (
            letter_sel : in  std_logic_vector(3 downto 0);
            gamma_code : out std_logic_vector(7 downto 0)
        );
    end component;

    signal letter_sel : std_logic_vector(3 downto 0);
    signal gamma_code : std_logic_vector(7 downto 0);

begin

    uut: gamma_lut
        port map (
            letter_sel => letter_sel,
            gamma_code => gamma_code
        );

    stim_proc: process
    begin
        -- Test each valid symbol
        letter_sel <= "0000"; wait for 20 ns; -- P
        letter_sel <= "0001"; wait for 20 ns; -- B
        letter_sel <= "0010"; wait for 20 ns; -- 1
        letter_sel <= "0011"; wait for 20 ns; -- 8
        letter_sel <= "0100"; wait for 20 ns; -- 0
        letter_sel <= "0101"; wait for 20 ns; -- -
        letter_sel <= "0110"; wait for 20 ns; -- F
        letter_sel <= "0111"; wait for 20 ns; -- G
        letter_sel <= "1000"; wait for 20 ns; -- A
        letter_sel <= "1111"; wait for 20 ns; -- invalid

        wait;
    end process;

end architecture;
