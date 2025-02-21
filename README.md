# Accumulator Microprocessor (Advanced Digital Systems Design Project)

A project to build a simple part of a microprocessor—an ALU and register file—and then connect them to execute a basic machine code program.

## Summary
In this project you design and implement a simple accumulator computer. The design consists of two main blocks:
- **The ALU:** A Verilog module that takes two 32‑bit inputs (A and B) and a 6‑bit opcode, and produces a 32‑bit result. The ALU supports a range of operations (addition, subtraction, absolute value, negation, maximum, minimum, average, logical NOT, OR, AND, and XOR) with the specific opcode assignments determined by the last digit of your student ID.
- **The Register File:** A small, fast RAM (typically 32×32‑bit words) that supports simultaneous dual read and one write operation. The initial contents of the register file are uniquely determined by the second-from-last digit of your student ID.
  
## Specifications
- **Memory & Register File:**
  - *Structure:* 32 × 32‑bit registers, addressed by a 5‑bit address.
  - *Interface:* Three simultaneous address ports – two for read (Output 1 and Output 2) and one for write.
  - *Synchronous Operation:* Updated on the rising edge of a clock. An enable input (valid_opcode) prevents updates when inactive.
  - *Initial Values:* Determined by the second-from-last digit of your student ID (provided in a lookup table).

- **ALU Module:**
  - *Inputs:* Two 32‑bit signed numbers (A and B) and a 6‑bit opcode.
  - *Output:* 32‑bit result.
  - *Supported Operations (opcode assignment dictated by the last digit of your student ID):*
    - a + b
    - a - b
    - |a| (absolute value)
    - -a
    - max(a, b)
    - min(a, b)
    - avg(a, b) (integer part only)
    - not a
    - a or b
    - a and b
    - a xor b

- **Machine Instruction Format:**
  - **32 bits total:**
    - *Opcode:* 6 bits (identifies the ALU operation).
    - *Source Registers:* Two 5‑bit fields (first and second source registers).
    - *Destination Register:* 5‑bit field.
    - *Unused:* 11 bits (set to zero).

- **Microprocessor Core (mp_top):**
  - *Integration:* Connects the ALU and the register file.
  - *Instruction Execution:* On a valid instruction (enable high), the CPU fetches register operands, performs the ALU operation, and writes the result into the destination register.
  - *Timing:* All synchronized to the rising edge of the clock; no dual-edge usage.

- **Testing & Simulation:**
  - *Program Stream:* A set of 32‑bit machine instructions (including a no‑op if desired) that exercises each opcode.
  - *Verification:* Each instruction’s result is compared with the expected output; any discrepancy causes the test to fail.
  - *Waveform Generation:* Simulation waveforms should capture the operation of the core and verify correct timing and data propagation.
  - *Design Constraints:* The register file must properly handle simultaneous read/write scenarios and hold outputs between clock cycles.

## Author

Qusay Taradeh
