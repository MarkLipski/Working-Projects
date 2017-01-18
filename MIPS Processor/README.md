# MIPS Processor
This was a project of mine that I really enjoyed and learned alot during. It's a full (hopefully) functional MIPS processor, implemented in VHDL, when synthesized for the FPGA that I was originally working with, the maximum clock speed was something like 120MHz.

### Instruction Set
The instructions that the processor runs can be viewed in the **Instruction Set.xlsx** file, which also illustrates how each instruction gets converted into
binary code.

### Processor Design/Layout
The design of the processor closely follows the generic MIPS architecture in alot of ways, though the inclusion of a Barrel Shifter and Multiplier make it slightly less orthodox, I also have a distributed control unit, as it decreased the number of registers 
required between stages, rather than propagating all of the control signals down the pipeline, a more compressed version of the instruction is propagated down, reducing
the total number of registers required. The flow of information and general block diagram can be viewed in the **Processor Architecture.png** file, and the list of control signals
can be viewed in the **Control Signal List.xlsx** file.
