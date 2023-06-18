# CSE141L_Project
Pethaperumal Natarajan
Karisma Kumar
Karthik Vetrivelan 

##File Descriptions
### top_level_instantiation.sv
This module defines and connects core elements like program counter, instruction memory, register file, control unit, arithmetic logic unit, data memory, and a multiplexer. The output signal ack signifies the end of program execution when the program counter equals a predefined doneAddress

### register_file.sv
Implements functionality to read from and write to 8-bit registers. The 'immediate' input dictates the source of the second read data: when 'immediate' is high, it reads from the 'ltValue' input, otherwise it reads from the specified register. Writing to the registers is synchronized to the rising edge of the clock signal and is performed when 'regWrite' is high.

### programcounter.sv
It uses a parameter to specify the number of bits in the PC. It takes clock, start, jumpFlag and a target value as inputs. The PC value is outputted. The module increments the PC with each clock cycle, resets it on a 'start' signal, or sets it to a predefined value or the target value depending on the 'jumpFlag' and 'target'.

### mux2x1_NBits.sv
This module represents a parametric 2x1 multiplexer with configurable bit-width (N). The multiplexer takes in two input signals (A and B) of N bits each, and a single bit select signal to choose between A and B. The selected signal is output as Y. 

### lookupTable.sv
This module implements a 3-bit instruction set. It takes a 3-bit binary input ('instruction') and, based on the input value, assigns an 8-bit output ('out'). The module uses a case statement to map specific instructions to certain output values. 

### instructionmem.sv
This module takes as input a Program Counter (PC) of a given number of bits (PC_BITS) and produces as output three 3-bit instruction components (instruction opcode, reg1, and reg2). The memory core is initialized from a file, and on each clock cycle, the instruction corresponding to the current PC value is fetched from the core, and then split into its parts.

### definitions.sv
This module contains an enumeration aluOp that represents our chosen arithmetic and logic operations (ADD, XOR, AND, RSL, MOV, LD, ST and BLQZ). The operations are encoded as 3-bit binary values for use in our ALU.

### datamem.sv
This module includes two modes of operation: read and write. The read operation outputs the value at the memory address specified by addr to data_out. The write operation, triggered by a high memWrite signal, writes the data_in value to the memory address specified by addr. Additionally, it provides console debug information with each write operation, displaying the memory address and the data written.

### control.sv
This module decodes 3-bit instructions and accordingly sets control signals for our processor. The control signals are aluOp (ALU operation), immediate (use immediate data), regWrite (register write enable), memWrite (memory write enable), and memToReg (memory to register enable).
Based on the incoming instruction, it sets these control signals. For ADD, XOR, AND, RSL operations, it enables register write. For MOV, it enables register write and uses immediate data. For LD, it enables register write and memory to register. For ST, it enables memory write. For BLQZ there is no output signal.

### alu.sv
This module takes three inputs: aluOp, input1, and input2. It outputs jumpFlag and out. The aluOp selects the operation to be performed on the inputs, such as addition (ADD), XOR operation (XOR), bitwise AND operation (AND), right shift logic (RSL), or data transfer operations (MOV, LD, ST). The BLQZ operation checks if input1 is less than 0, and if so, sets the jumpFlag. 

### assemble.py
A high level program to transalate assembly code inot machine code that can be used to run on our processor. 


## Working Programs
Programs 1 and 2 work completely. 

## Broken Programs
We have our assembly implementation for program 3 but it is not working completely. 
We faced major challenges with the timing of some of our singals in our processor that delayed the testing of any of our programs. After solving the timing issues, we ran into problems with the implementation of our instructions and had to test them extensively to get them working. Only after this we were able to begin to start testing our Assembly implementations for our programs and test our Translator as well. 

## Video Demonstation
link- https://youtu.be/eUA_uP8cYms

## Screenshots for outpu
Screenshots for output can be found in the 'Output screenshots' directory.