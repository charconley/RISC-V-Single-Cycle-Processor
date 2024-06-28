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

