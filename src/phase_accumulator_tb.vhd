library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Use numeric_std for arithmetic operations

-- Use LPM components library
library lpm;
use lpm.lpm_components.all;

entity phase_accumulator_tb is
end entity phase_accumulator_tb;

architecture testbench of phase_accumulator_tb is

    -- Signal Declarations
    signal clock     : std_logic;                      -- Clock signal
    signal reset     : std_logic;                      -- Reset signal
    signal add_sub   : std_logic;                      -- Control signal for addition or subtraction
    signal FSW       : std_logic_vector(7 downto 0);   -- Frequency Setting Word
    signal result    : std_logic_vector(7 downto 0);   -- Output result

    -- Constant for clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the phase_accumulator
    uut: entity work.phase_accumulator
        port map (
            clock               => clock,
            reset               => reset,
            add_sub             => add_sub,
            FSW(7 downto 0)     => FSW(7 downto 0),
            result(7 downto 0)  => result(7 downto 0)
        );

    -- Clock Generation Process
    clock_process: process
    begin
        clock <= '0';
        wait for clk_period / 2;
        clock <= '1';
        wait for clk_period / 2;
    end process;

    -- Test Process
    stimulus_process: process
    begin
        -- Initialize signals
		  FSW <= "00000000";    -- Set FSW to 0 (Initial FSW)
        reset <= '1';         -- Assert reset
        add_sub <= '1';       -- Start with addition
        wait for 2 * clk_period; -- Wait for clock to stabilize
        reset <= '0';         -- Deassert reset
        wait for clk_period;   -- Wait for clock to update result

        -- Test Case 1: Addition
        FSW <= "00000011";    -- Set FSW to 3 (First value for addition)
        wait for 80 ns;   -- Wait for multiple clock cycles

        FSW <= "00000101";    -- Set FSW to 5 (Second value for addition)
        wait for 250 ns;   -- Wait for multiple clock cycles

        -- Test Case 2: Subtraction
        add_sub <= '0';       -- Set to subtraction
        wait for 4 * clk_period;   -- Wait for clock to update result
        
        FSW <= "00000110";    -- Set FSW to 6 (First value for subtraction)
		  wait for 80 ns;   -- Wait for multiple clock cycles

        FSW <= "00000010";    -- Set FSW to 2 (Second value for subtraction)
		  wait for 80 ns;   -- Wait for multiple clock cycles

        -- Final state check
        wait for 20 ns;        -- Wait before finishing simulation
        assert false report "End of simulation." severity note;  -- End the simulation
    end process;

end architecture testbench;
