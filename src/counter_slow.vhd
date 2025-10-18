library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_slow is
    generic (
        n : natural := 25;
        k : integer := 50_000_000  -- 1 sekund ved 50 MHz
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
end counter_slow;

architecture behavior of counter_slow is
    signal counter : unsigned(n-1 downto 0) := (others => '0');
    signal limit   : unsigned(n-1 downto 0) := to_unsigned(k - 1, n);
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
            if enable = '1' then
                if reset = '1' then
                    counter <= (others => '0');
                elsif load = '1' then
                    counter <= unsigned(data);
                elsif counter = limit then
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;

    Q <= std_logic_vector(counter);
    rollover <= '1' when counter = limit else '0';
end behavior;
