# RISC-V-Single-Cycle-Processor Overview
The aim of this project is to learn Verilog and learn the basics of CPU architecture. Using Verilogm, I implemented a RISC-V architecture to create a 32-bit, single-cycle processor that can perform 20 operations. The diagram linked demonstrates the datapath I followed, omitting the control modules.
# Processor.v
For the organization, I created three top-level modules; datapath.v, ALUController.v, and Controller.v. The highest-level module, processor.v, instantiates these three modules, defining the flow of control and data paths between the components
# ALUController.v
The ALU controller module takes three inputs, one from the controller module, and two from the datapath, to determine the ALU operation, which specifies which operation will be executed each cycle. 
# Controller.v
The controller module takes an operation code signal from the datapath and calculates several control signals to determine when to read and write from the register and memory. I used this table for the calculations:
# Datapath.v
The datapath module connects the lower-level modules, defining the flow of data across the processor. To write the datapath module I followed the diagram in the overview, instantiating each module and using wires to connect the data between the modules. 
# InstMem.v
The instruction memory contains 20 instructions in a 32-bit register with 64 indicies. The module takes in an 8-bit address as its input and outputs the 32-bit instruction. Because we need 6 bits to represent 64 instructions, the 2 least significant bits of the address are omitted. The operation is as such: Instruction = memory[addr>>2].
# RegFile.v
The register file consists of an array of registers that can be read from and written to. The two read addresses and the write address are from the instruction memory, while write data, write enable, clock, and reset and other inputs from Controller.v and DataMem.v. The register file can be written to on the positive edge of the clock but utilizes an asynchronous reset, and data is read as soon as the instruction signal changes. 
# ImmGen.v
The immediate generator takes in the 32-bit instruction and the opcode, and determines the 12-bit immediate. It then sign extends the immediate from 12 to 32-bit, which becomes the output.
# ALU.v
The ALU takes in two 32-bit data signals and the ALU operation code and performs the designated operation. There are seven operations: add, subtract, set less than, equals comparison, nor, and, and or. And, nor, and or are bitwise operations while add, subtract, and set less than are signed operations.
# DataMem.v
The Data Memory stores 128 32-bit pieces of data. This module has 4 inputs, the address, write data, and two control signals which decide whether to read or write. To address 128 indices, 7 bits are required so the 2 LSB of the 9-bit address are omitted. The data memory has one output, a 32-bit signal. 
# Mux.v
The mux, used twice, is a simple 32-bit mux with two 32-bit inputs and a 1-bit selection signal input. The logic is as such: assign out = Sel ? B_in : A_in; So, if Sel is high then B is outputted, and if Sel is low A is the output. 
# FlipFlop.v
The flip-flop module has a clock, reset, and 8-bit data as inputs, and outputs on the positive edge of the clock. It uses a synchronous reset. The output is the address for the instruction memory, which is incremented by 4 every cycle. This addition is handled by the datapath module.
# Conclusion
Through this project, I learned much about Verilog, hardware design, and CPU architecture. In the future, I hope to program, FPGAs using Verilog and design more complex CPU's with greater capabilities. My next steps are to continue learning Verilog and System Verilog, and research Assembly. Thank you for reading about my project.
