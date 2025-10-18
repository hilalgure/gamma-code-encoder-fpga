library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gamma_lut is
    port(
        letter_sel : in  std_logic_vector(3 downto 0);
        gamma_code : out std_logic_vector(7 downto 0)
    );
end gamma_lut;

architecture behavior of gamma_lut is
begin
    process(letter_sel)
    begin
        case letter_sel is
            when "0000" => gamma_code <= "01010000"; -- P: dash dash dot
            when "0001" => gamma_code <= "01000000"; -- B: bar dot dot
            when "0010" => gamma_code <= "01000100"; -- 1: bar dot dash
            when "0011" => gamma_code <= "00100000"; -- 8: dot bar dot
            when "0100" => gamma_code <= "01000100"; -- 0: dash dot dash
            when "0101" => gamma_code <= "01000000"; -- -: dash
            when "0110" => gamma_code <= "10010000"; -- F: bar dash dot
            when "0111" => gamma_code <= "10000000"; -- G: bar dot dot bar
            when "1000" => gamma_code <= "00010000"; -- A: dot dash dot
            when others => gamma_code <= "11111111"; -- ugyldig kode
        end case;
    end process;
end behavior;
