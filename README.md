# Phase Accumulator Project

## Overview
The Phase Accumulator Project is an educational VHDL-based design that implements a phase accumulator using LPM (Library of Parameterized Modules) components. The lpm_add_sub model is fed by two inputs, one of which is a constant. The output of the adder is fed into a buffer (lpm D-Type Flip-Flops), whose output is fed back into the adder module. By setting one of the inputs as constant and a feedback loop, the adder acts as a counter.

## Features
- Uses LPM components: `lpm_add_sub` for addition and subtraction and `lpm_ff` for storing the result.
- Allows dynamic operation mode (addition or subtraction) controlled via an external input signal.
- Designed to provide a learning tool for students in electronics and digital design.

## Getting Started
### Prerequisites
- [Quartus Prime 13.0 (Free Edition)](https://www.intel.com/content/www/us/en/software-development-tools/programmable/quartus-prime/overview.html) or later.
- Basic understanding of VHDL and digital design concepts.

### Project Structure
```bash
phase_accumulator/
├── .gitignore            # File to specify untracked files to ignore
├── README.md             # Project description and instructions
├── requirements.txt      # List of required tools and versions
├── src/                  # Source files directory
│   ├── phase_accumulator.vhd   # VHDL code for the phase accumulator
│   └── phase_accumulator_tb.vhd # VHDL testbench for the phase accumulator
└── doc/                  # Documentation (if any)
    └── design_notes.md   # Additional design notes or documentation
```

### How to Compile and Simulate
1. Open Quartus Prime.
2. Create a new project and specify the project directory.
3. Add the VHDL source files located in the `src` directory.
4. Compile the project.
5. Use the ModelSim or Quartus simulation tool to run the testbench (`phase_accumulator_tb.vhd`).

### Usage
- The `FSW` input controls the values being added or subtracted.
- The `add_sub` control signal determines the operation:
  - `0`: Addition
  - `1`: Subtraction
- The `reset` signal initializes the flip-flop and clears previous results.

## License
This project is intended for educational purposes and is provided as-is without any warranty. Feel free to use, modify, and distribute it under the same terms.
