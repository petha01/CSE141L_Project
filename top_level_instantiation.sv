import definitions::*;
module top_level_instantiation(
    input clock, req,
    output ack
);

    // Parameters
    parameter PC_BITS = 10;

    // Wires and logics
    logic  jumpFlag, immediate, regWrite, memWrite, memToReg;
    logic [PC_BITS - 1:0] pc;
    logic [PC_BITS - 1:0] doneAddress1 = 9'b110110011;  // 435
    // logic [PC_BITS - 1:0] doneAddress1 = 9'b000000011;  // 3
    // logic [PC_BITS - 1:0] doneAddress1 = 9'b000000011;
    logic[7:0] aluOut, writeData, data1, data2, memOut, lutOut;
    logic[2:0] instruction, reg1, reg2, aluOp;


    // Module instances
    programcounter #(PC_BITS) PC (.clock(clock), .start(req), .jumpFlag(jumpFlag), 
         .target(aluOut), .pc(pc));

    instructionmem #(PC_BITS) IM (.pc(pc), .instructions(instruction), .reg1(reg1), .reg2(reg2));

    registerFile RF (.clock(clock), .immediate(immediate), .regWrite(regWrite), .readRegister1(reg1), .readRegister2(reg2),
        .ltValue(lutOut), .writeData(writeData), .readData1(data1), .readData2(data2));

    LookupTable LT (.instruction(reg2), .out(lutOut));

    control CONTROL (.instructions(instruction), .aluOp(aluOp), .immediate(immediate),
        .regWrite(regWrite), .memWrite(memWrite), .memToReg(memToReg));

    alu ALU (.aluOp(aluOp), .input1(data1), .input2(data2), .jumpFlag(jumpFlag), .out(aluOut));

    datamem DM (.clock(clock), .memWrite(memWrite), .addr(aluOut), .data_in(data2), .data_out(memOut));

    mux2x1_Nbits M2RMUX (.A(aluOut), .B(memOut), .select(memToReg), .Y(writeData));

    assign done = pc == doneAddress1;


endmodule
