-- VHDL Code for phase_accumulator using lpm_add_sub and lpm_ff models
-- The design adds two numbers, stores the result in a D flip-flop (lpm_ff),
-- and feeds the output of the flip-flop back into the adder/subtractor.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Use numeric_std for arithmetic operations

-- Use LPM components library
library lpm;
use lpm.lpm_components.all;

entity phase_accumulator is
    port (
        clock     : in  std_logic;                      -- Clock signal
        reset     : in  std_logic;                      -- Reset signal
        add_sub   : in  std_logic;                      -- Control signal for addition or subtraction
        FSW       : in  std_logic_vector(7 downto 0);   -- 8-bit input (frequency setting word)
        result    : out std_logic_vector(7 downto 0)    -- Final output after feedback
    );
end entity phase_accumulator;

architecture Behavioral of phase_accumulator is

    -- Internal signals
    signal result_signal   : std_logic_vector(7 downto 0);  -- Signal to hold the output of the adder
    signal ff_output       : std_logic_vector(7 downto 0);  -- Output of the flip-flop (lpm_ff)

    -- Component Declaration for LPM_ADD_SUB (Adder/Subtractor)
    component lpm_add_sub
        generic (
            lpm_width : natural := 8;  					-- Width of the adder/subtractor (8-bit)
				lpm_representation: string := "SIGNED"    -- SIGNED vs UNSIGNED add/sub operation
        );
        port (
            dataa   : in std_logic_vector(lpm_width-1 downto 0);    -- First input (A)
            datab   : in std_logic_vector(lpm_width-1 downto 0);    -- Second input (B)
            add_sub : in std_logic;                                 -- Control signal for addition or subtraction
            result  : out std_logic_vector(lpm_width-1 downto 0)    -- Output result (A - B)
        );
    end component;

    -- Component Declaration for LPM_FF (Flip-Flop)
    component lpm_ff
        generic (
            lpm_width : natural := 8                                -- Width of the flip-flop (8-bit)
        );
        port (
            clock   : in  std_logic;                                -- Clock signal
            aclr    : in  std_logic;                                -- Asynchronous clear/reset
            data    : in  std_logic_vector(lpm_width-1 downto 0);   -- Data input
            q       : out std_logic_vector(lpm_width-1 downto 0)	  -- Flip-flop output
        );
    end component;

begin

    -- Instantiate the LPM_ADD_SUB (Adder/Subtractor)
    lpm_add_sub_inst : lpm_add_sub
        generic map (
            lpm_width => 8,                        -- 8-bit adder/subtractor
				lpm_representation => "UNSIGNED"			-- unsigned operations (non-neg)
        )
        port map (
            dataa(7 downto 0)   => ff_output(7 downto 0),       -- Input A (feedback from the flip-flop)
            datab(7 downto 0)   => FSW(7 downto 0),             -- Input B (frequency setting word) 
            add_sub 				  => add_sub,							 -- Control signal for addition or subtraction
            result(7 downto 0)  => result_signal(7 downto 0)    -- Output result
        );

    -- Instantiate the LPM_FF (Flip-Flop)
    lpm_ff_inst : lpm_ff
        generic map (
            lpm_width => 8                                      -- 8-bit flip-flop
        )
        port map (
            clock   => clock,                                   -- Clock signal
            aclr    => reset,                                   -- Asynchronous reset
            data(7 downto 0)    => result_signal(7 downto 0),   -- Data input (from the adder output)
            q(7 downto 0)       => ff_output(7 downto 0)        -- Flip-flop output
        );

    -- Drive the final output from the flip-flop's output
    result(7 downto 0) <= ff_output(7 downto 0);

end architecture Behavioral;
