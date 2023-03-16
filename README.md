# Single-Cycle-RV-32I-Processor

## Project Details

- This is a _single cycle processer_ delivered as a final project of IEEE workshop 2023/2024 and all details are shown in the next figure.

![processor details](./images/Screenshot%202023-03-09%20015216.png)

### Supported Modules
- **ALU**

    An Arithmetic/Logical Unit (ALU) combines a variety of mathematical and logical operations into a single unit.
- **Instruction Memory**
    * e instruction memory has a single read port.
    * It takes a 32-bit instruction address input, A, and reads the 32-bit data (i.e., instruction) from that address onto the read data output, RD.
- **Register File**
    * The Register File contains the 32-bit registers.
    * The register file has two read output ports (RD1 and RD2) and a single input write port (WD3), RD1 and RD2 are read with no respect to the clock edge.
    * The register file is read asynchronously and written synchronously at the rising edge of the clock.
- **Data Memory**
    * It has a single read/write port.
    * If its write enable, WE, is asserted, then it writes data WD into address A on the rising edge of the cloc
- **Control Unit**

    The control unit computes the control signals based on the opcode and funct3, funct7 fields ofthe instruction, Instr14:12 and Instr30 respectively. Most of the control information comes from the opcode, but R-type instructions and I-type instructions also use the funct3 and funct7 fields to determine the ALU operation. Thus, we will simplify our design by factoring the control unit into two blocks of combinational logic.

