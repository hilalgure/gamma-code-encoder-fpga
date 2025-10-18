
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_gamma_shift_reg is
end entity;

architecture sim of tb_gamma_shift_reg is
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal load      : std_logic := '0';
    signal shift_en  : std_logic := '0';
    signal code_in   : std_logic_vector(7 downto 0);
    signal code_out  : std_logic_vector(1 downto 0);
    signal finished  : std_logic;

    constant clk_period : time := 20 ns;

begin

    uut: entity work.gamma_shift_reg
        port map (
            clk       => clk,
            reset     => reset,
            load      => load,
            shift_en  => shift_en,
            code_in   => code_in,
            code_out  => code_out,
            finished  => finished
        );

  
    clk_process : process
    begin
        while now < 1000 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;


    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        -- Load a code value (e.g., P: dash dash dot = 01010000)
        code_in <= "01010000";
        load <= '1';
        wait for clk_period;
        load <= '0';

        wait for clk_period * 2;

        -- Perform 4 shifts
        for i in 0 to 3 loop
            shift_en <= '1';
            wait for clk_period;
            shift_en <= '0';
            wait for clk_period * 2;
        end loop;

        wait;
    end process;

end architecture;

