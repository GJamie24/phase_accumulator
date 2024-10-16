# Design Notes for Phase Accumulator Project

## Introduction
The Phase Accumulator is a fundamental component in digital signal processing, often used in applications like Direct Digital Synthesis (DDS) and Software Defined Radio (SDR). This design aims to provide a simple yet effective implementation that enhances the understanding of VHDL coding and digital design principles.

## Design Components
### LPM Components Used
1. **lpm_add_sub**: This component performs addition or subtraction based on the control signal. It accepts two 8-bit inputs and produces an 8-bit output.
2. **lpm_ff**: This component is a D-type flip-flop that stores the result from the adder/subtractor and updates its output on the rising edge of the clock.

### Architecture Overview
- **Inputs**:
  - `FSW`: The frequency setting word (8-bit).
  - `clock`: The clock signal to synchronize operations.
  - `reset`: An active-high signal to reset the flip-flop output.
  - `add_sub`: Control signal to switch between addition and subtraction.

- **Outputs**:
  - `result`: The final output stored in the flip-flop.

### Functionality
- On the rising edge of the clock, if the reset signal is active, the flip-flop output will be cleared to zero. 
- If reset is not active, the design will perform addition or subtraction based on the value of the `add_sub` control signal.
- The result of the operation is stored in the flip-flop and is available at the output.

## Future Work
This project can be further extended by integrating:
- **Digital-to-Analog Converter (DAC)**: To convert the digital output to an analog signal.
- **Look-Up Table (LUT)**: To generate sine waves or other waveforms based on the accumulated phase.
- **Integration with SDR**: To create a complete software-defined radio front-end that can manipulate signals in real time.
- **Phase Modulation**: Expanding the functionality to include phase modulation capabilities, which could be useful in various communication systems.

## Conclusion
The Phase Accumulator project provides a foundational understanding of digital circuit design using VHDL and LPM components. It can serve as a stepping stone to more complex designs and real-world applications in signal processing.
