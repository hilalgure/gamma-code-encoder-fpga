library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gamma_shift_reg is
    port (
        clk, reset, load, shift_en : in  std_logic;
        code_in                    : in  std_logic_vector(7 downto 0);
        code_out                   : out std_logic_vector(1 downto 0);
        finished                   : out std_logic
    );
end gamma_shift_reg;

architecture behavior of gamma_shift_reg is
    signal shift_reg : std_logic_vector(7 downto 0) := (others => '0');
    signal bit_count : integer range 0 to 4 := 0;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            shift_reg <= (others => '0');
            bit_count <= 0;
        elsif rising_edge(clk) then
            if load = '1' then
                shift_reg <= code_in;
                bit_count <= 4;
            elsif shift_en = '1' and bit_count > 0 then
                shift_reg <= shift_reg(5 downto 0) & "00";
                bit_count <= bit_count - 1;
            end if;
        end if;
    end process;

    code_out <= shift_reg(7 downto 6);
    finished <= '1' when bit_count = 0 else '0';
end behavior;
