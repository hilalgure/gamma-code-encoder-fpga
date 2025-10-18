
library ieee;
use ieee.std_logic_1164.all;

entity tb_seven_seg is
end tb_seven_seg;

architecture sim of tb_seven_seg is

    component seven_seg is
        port (
            chosen_symbol : in  std_logic_vector(3 downto 0);
            display       : out std_logic_vector(0 to 6)
        );
    end component;

    signal chosen_symbol : std_logic_vector(3 downto 0);
    signal display        : std_logic_vector(0 to 6);

begin

    uut: seven_seg
        port map (
            chosen_symbol => chosen_symbol,
            display       => display
        );

    stim_proc: process
    begin
        -- Test valid symbols
        chosen_symbol <= "0000"; wait for 20 ns; -- P
        chosen_symbol <= "0001"; wait for 20 ns; -- B
        chosen_symbol <= "0010"; wait for 20 ns; -- 1
        chosen_symbol <= "0011"; wait for 20 ns; -- 8
        chosen_symbol <= "0100"; wait for 20 ns; -- 0
        chosen_symbol <= "0101"; wait for 20 ns; -- -
        chosen_symbol <= "0110"; wait for 20 ns; -- F
        chosen_symbol <= "0111"; wait for 20 ns; -- G
        chosen_symbol <= "1000"; wait for 20 ns; -- A
        chosen_symbol <= "1111"; wait for 20 ns; -- invalid

        wait;
    end process;

end architecture;

