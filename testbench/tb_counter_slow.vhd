library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter_slow is
end entity;

architecture sim of tb_counter_slow is

    constant n : natural := 4;        -- Lav verdi for rask simulering
    constant k : integer := 10;

    component counter_slow is
        generic (
            n : natural := 4;
            k : integer := 10
        );
        port (
            CLK      : in  std_logic;
            reset    : in  std_logic;
            load     : in  std_logic;
            enable   : in  std_logic;
            data     : in  std_logic_vector(n-1 downto 0);
            Q        : out std_logic_vector(n-1 downto 0);
            rollover : out std_logic
        );
    end component;

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal load     : std_logic := '0';
    signal enable   : std_logic := '1';
    signal data     : std_logic_vector(n-1 downto 0) := (others => '0');
    signal Q        : std_logic_vector(n-1 downto 0);
    signal rollover : std_logic;

    -- clock generation
    constant clk_period : time := 10 ns;
begin

    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    uut: counter_slow
        generic map (
            n => n,
            k => k
        )
        port map (
            CLK      => clk,
            reset    => reset,
            load     => load,
            enable   => enable,
            data     => data,
            Q        => Q,
            rollover => rollover
        );

    stimulus : process
    begin
        wait for 10 ns;
        reset <= '1';
        wait for clk_period;
        reset <= '0';

        wait for 150 ns;

        -- test done
        wait;
    end process;

end architecture;

