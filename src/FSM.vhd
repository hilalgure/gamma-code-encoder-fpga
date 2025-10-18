library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
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
end FSM;

architecture Behavioral of FSM is
    type state_type is (S1_LOAD, S2_CHECK, S3_BLINK, S4_PAUSE, S5_DONE);
    signal state, next_state : state_type;

    signal led_timer : integer range 0 to 6 := 0;
    signal duration  : integer range 1 to 6 := 1;

begin

    -- State register
    process(clk, reset)
    begin
        if reset = '1' then
            state <= S1_LOAD;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    -- Next state logic
    process(state, start, qsec_tick, empty, led_timer)
    begin
        case state is
            when S1_LOAD =>
                if start = '1' then
                    next_state <= S2_CHECK;
                else
                    next_state <= S1_LOAD;
                end if;

            when S2_CHECK =>
                if empty = '0' then
                    next_state <= S3_BLINK;
                else
                    next_state <= S5_DONE;
                end if;

            when S3_BLINK =>
                if qsec_tick = '1' and led_timer = duration then
                    next_state <= S4_PAUSE;
                else
                    next_state <= S3_BLINK;
                end if;

            when S4_PAUSE =>
                if qsec_tick = '1' then
                    next_state <= S2_CHECK;
                else
                    next_state <= S4_PAUSE;
                end if;

            when S5_DONE =>
                if start = '0' then
                    next_state <= S1_LOAD;
                else
                    next_state <= S5_DONE;
                end if;
        end case;
    end process;

   
    process(clk, reset)
    begin
        if reset = '1' then
            load_reg  <= '0';
            shift_en  <= '0';
            led_out   <= '0';
            led_timer <= 0;
            duration  <= 1;
        elsif rising_edge(clk) then
            case state is

                when S1_LOAD =>
                    load_reg <= '1';
                    shift_en <= '0';
                    led_out  <= '0';

                when S2_CHECK =>
                    load_reg <= '0';
                    shift_en <= '1';
                    led_timer <= 0;

                    case code_out is
                        when "00" => duration <= 1; -- dot
                        when "01" => duration <= 3; -- dash
                        when "10" => duration <= 6; -- bar
                        when others => duration <= 1;
                    end case;

                when S3_BLINK =>
                    load_reg <= '0';
                    shift_en <= '0';
                    led_out  <= '1';
                    if qsec_tick = '1' then
                        led_timer <= led_timer + 1;
                    end if;

                when S4_PAUSE =>
                    led_out <= '0';
                    if qsec_tick = '1' then
                        led_timer <= 0;
                    end if;

                when S5_DONE =>
                    led_out  <= '0';
                    shift_en <= '0';
                    load_reg <= '0';

            end case;
        end if;
    end process;

end Behavioral;
