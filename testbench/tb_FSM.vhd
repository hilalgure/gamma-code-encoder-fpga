library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_FSM is
end entity;

architecture sim of tb_FSM is

    component FSM is
        port (
            clk       : in  std_logic;
            reset     : in  std_logic;
            start     : in  std_logic;
            qsec_tick : in  std_logic;
            code_out  : in  std_logic_vector(1 downto 0);
            empty     : in  std_logic;
            load_reg  : out std_logic;
            shift_en  : out std_logic;
            led_out   : out std_logic
        );
    end component;

    signal clk       : std_logic := '0';
    signal reset     : std_logic := '0';
    signal start     : std_logic := '0';
    signal qsec_tick : std_logic := '0';
    signal code_out  : std_logic_vector(1 downto 0) := "00";
    signal empty     : std_logic := '0';
    signal load_reg  : std_logic;
    signal shift_en  : std_logic;
    signal led_out   : std_logic;

    constant clk_period : time := 20 ns;

begin

    uut: FSM
        port map (
            clk       => clk,
            reset     => reset,
            start     => start,
            qsec_tick => qsec_tick,
            code_out  => code_out,
            empty     => empty,
            load_reg  => load_reg,
            shift_en  => shift_en,
            led_out   => led_out
        );

    -- Clock generation
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

    -- Stimulus
    stim_proc: process
    begin
        -- Reset
        reset <= '1'; wait for clk_period;
        reset <= '0'; wait for clk_period;

        -- Start signal
        start <= '1'; wait for clk_period;
        start <= '0'; wait for clk_period * 2;

        -- Simuler kode for "dot" og flere qsec_tick
        code_out <= "00";
        empty <= '0';

        qsec_tick <= '1'; wait for clk_period;
        qsec_tick <= '0'; wait for clk_period * 2;

        qsec_tick <= '1'; wait for clk_period;
        qsec_tick <= '0'; wait for clk_period * 2;

        -- Neste symbol
        code_out <= "10";

        qsec_tick <= '1'; wait for clk_period;
        qsec_tick <= '0'; wait for clk_period * 2;

        -- Ferdig
        empty <= '1';
        qsec_tick <= '1'; wait for clk_period;
        qsec_tick <= '0'; wait;

    end process;

end architecture;

