import definitions::*;
module top_level_instantiation(
    input clock, start,
    output done
);

    // Parameters
    parameter PC_BITS = 9;

    // Wires and logics
    wire nextIns, jumpFlag, immediate, regWrite, memWrite, memToReg;
    wire [PC_BITS - 1:0] pc;
    logic [PC_BITS - 1:0] startingAddress = 0;
    logic [PC_BITS - 1:0] doneAddress1 = 435;
    wire[7:0] aluOut, writeData, data1, data2, memOut;
    wire[2:0] instruction, reg1, reg2, lutOut, aluOp;


    // Module instances
    programcounter PC (.clock(clock), .start(start), .nextIns(nextIns), .jumpFlag(jumpFlag), .pc_in(pc),
        .startingAddress(startingAddress), .doneAddress(doneAddress1), .target(aluOut), .pc_out(pc), .done(done));

    instructionmem #(PC_BITS) IM (.pc(pc), .instructions(instruction), .reg1(reg1), .reg2(reg2));

    registerFile RF (.clock(clock), .immediate(immediate), .regWrite(regWrite), .readRegister1(reg1), .readRegister2(reg2),
        .ltValue(lutOut), .writeData(writeData), .readData1(data1), .readData2(data2));
    
    LookupTable LT (.instruction(reg2), .out(lutOut));

    control CONTROL (.clock(clock), .instructions(instruction), .aluOp(aluOp), .nextIns(nextIns), 
        .immediate(immediate), .regWrite(regWrite), .memWrite(memWrite), .memToReg(memToReg));

    alu ALU (.aluOp(aluOp), .input1(data1), .input2(data2), .jumpFlag(jumpFlag), .out(aluOut));
    
    datamem DM (.clock(clock), .memWrite(memWrite), .addr(aluOut), .data_in(data2), .data_out(memOut));

    mux2x1_Nbits M2RMUX (.A(memOut), .B(aluOut), .select(memToReg), .Y(writeData));

endmodule
