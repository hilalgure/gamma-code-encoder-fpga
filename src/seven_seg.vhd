library ieee;
use ieee.std_logic_1164.all;

entity seven_seg is
    port (
        chosen_symbol : in  std_logic_vector(3 downto 0);
        display       : out std_logic_vector(0 to 6)
    );
end seven_seg;

architecture behavior of seven_seg is
begin
    process(chosen_symbol)
    begin
        case chosen_symbol is
            when "0000" => display <= "0011000"; -- P
            when "0001" => display <= "1100000"; -- B
            when "0010" => display <= "1001111"; -- 1
            when "0011" => display <= "0000000"; -- 8
            when "0100" => display <= "0000001"; -- 0
            when "0101" => display <= "1111110"; -- -
            when "0110" => display <= "0111000"; -- F
            when "0111" => display <= "0100001"; -- G
            when "1000" => display <= "0001000"; -- A
            when others => display <= "1111111"; -- blank
        end case;
    end process;
end behavior;
