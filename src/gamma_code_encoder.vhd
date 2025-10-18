library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gamma_code_encoder is
    port (
        CLOCK_50 : in  std_logic;
        SW       : in  std_logic_vector(3 downto 0);
        KEY      : in  std_logic_vector(1 downto 0);
        LEDR     : out std_logic_vector(9 downto 0);
        HEX0     : out std_logic_vector(0 to 6)
    );
end gamma_code_encoder;

architecture structural of gamma_code_encoder is

    component counter_slow is
        generic( n : NATURAL; k : INTEGER);
        port(
            CLK, reset, load : in std_logic;
            enable           : in std_logic;
            data             : in std_logic_vector(n-1 downto 0);
            Q                : out std_logic_vector(n-1 downto 0);
            rollover         : out std_logic
        );
    end component;

    component gamma_lut is
        port (
            letter_sel : in  std_logic_vector(3 downto 0);
            gamma_code : out std_logic_vector(7 downto 0)
        );
    end component;

    component seven_seg is
        port (
            chosen_symbol : in  std_logic_vector(3 downto 0);
            display       : out std_logic_vector(0 to 6)
        );
    end component;

    component gamma_shift_reg is
        port (
            clk, reset, load, shift_en : in  std_logic;
            code_in                    : in  std_logic_vector(7 downto 0);
            code_out                   : out std_logic_vector(1 downto 0);
            finished                   : out std_logic
        );
    end component;

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

    signal tick_qsec      : std_logic;
    signal gamma_code     : std_logic_vector(7 downto 0);
    signal code_out       : std_logic_vector(1 downto 0);
    signal finished       : std_logic;
    signal shift_en       : std_logic;
    signal load_reg       : std_logic;
    signal start          : std_logic;
    signal reset          : std_logic := '0';
    signal toggle_test    : std_logic := '0';
    signal tick_stretched : std_logic := '0';
    signal stretch_count  : integer range 0 to 10 := 0;

begin

    start <= not KEY(1);
    reset <= not KEY(0);

    
    quarter_ticker : counter_slow
								  generic map (
										n => 25,
										k => 12500000
								  )
								  port map (
										CLK      => CLOCK_50,
										reset    => reset,
										load     => '0',
										enable   => '1',
										data     => (others => '0'),
										Q        => open,
										rollover => tick_qsec
								  );



    lookup_table : gamma_lut
							  port map (
									letter_sel => SW,
									gamma_code => gamma_code
							  );

    segment_display : seven_seg
							  port map (
									chosen_symbol => SW,
									display       => HEX0
							  );

    shift_register : gamma_shift_reg
							  port map (
									clk       => CLOCK_50,
									reset     => reset,
									load      => load_reg,
									shift_en  => shift_en,
									code_in   => gamma_code,
									code_out  => code_out,
									finished  => finished
							  );

    gamma_fsm : FSM
					  port map (
							clk       => CLOCK_50,
							reset     => reset,
							start     => start,
							qsec_tick => tick_qsec,
							code_out  => code_out,
							empty     => finished,
							load_reg  => load_reg,
							shift_en  => shift_en,
							led_out   => LEDR(0)
					  );

LEDR(9) <= reset;

end structural;
