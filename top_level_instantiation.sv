import definitions::*;
module top_level_instantiation(
    input clock,
    input reset
);

    parameter PC_BITS = 9;

    logic [2:0] aluOp, reg1, reg2;
    logic [7:0] data1, data2, aluResult, memData, ltVal;
    logic memWrite, jumpFlag, regWrite, immediate;
    logic [PC_BITS-1:0] pc;

    instructionmem #(PC_BITS) IM (.pc(pc), .instructions(aluOp), .reg1(reg1), .reg2(reg2));
    fetch_unit FU (.clock(clock), .reset(reset), .jumpFlag(jumpFlag), .pc(pc));
    registerFile RF (.clock(clock), .immediate(immediate), .regWrite(regWrite),
                     .readRegister1(reg1), .readRegister2(reg2), .writeRegister(reg1),
                     .ltValue(ltVal), .writeData(aluResult), 
                     .readData1(data1), .readData2(data2));
    alu ALU (.clock(clock), .aluOp(aluOp), .input1(data1), .input2(data2), 
             .jumpFlag(jumpFlag), .out(aluResult));
    datamem DM (.clock(clock), .memWrite(memWrite), .addr(reg1), .data_in(aluResult), .data_out(memData));

    control_decoder CD (.clock(clock), .reset(reset), .instructions(aluOp), .jumpFlag(jumpFlag), .memWrite(memWrite), .regWrite(regWrite), .immediate(immediate), .ltVal(ltVal));

endmodule
