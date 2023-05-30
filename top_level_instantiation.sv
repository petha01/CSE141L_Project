import definitions::*;
module top_level(
    input clock,
    input reset,
    input start
);

    parameter PC_BITS = 12;

    logic [2:0] aluOp, reg1, reg2;
    logic [7:0] input1, input2, aluOut, memData, ltVal, target;
    logic memWrite, jumpFlag, regWrite, immediate, nextIns;
    logic [PC_BITS-1:0] pc_in, pc_out, startingAddress;

    instructionmem #(PC_BITS) IM (.pc(pc_out), .instructions(aluOp), .reg1(reg1), .reg2(reg2));
    programcounter PC (.nextIns(nextIns), .jumpFlag(jumpFlag), .start(start), .clock(clock),
                       .pc_in(pc_in), .startingAddress(startingAddress), .target(target), .pc_out(pc_out));
    registerFile RF (.clock(clock), .immediate(immediate), .regWrite(regWrite),
                     .readRegister1(reg1), .readRegister2(reg2),
                     .ltValue(ltVal), .writeData(aluOut), 
                     .readData1(input1), .readData2(input2));
    alu ALU (.aluOp(aluOp), .input1(input1), .input2(input2), 
             .jumpFlag(jumpFlag), .out(aluOut));
    datamem DM (.clock(clock), .memWrite(memWrite), .addr(reg1), .data_in(aluOut), .data_out(memData));

    control CD (.clock(clock), .instructions(pc_out), .aluOp(aluOp), .nextIns(nextIns),
                .immediate(immediate), .regWrite(regWrite), .memWrite(memWrite), .memToReg(memToReg));


    always_ff @(posedge clock) begin
        if (start || (nextIns && !jumpFlag)) begin
            nextIns <= 1'b1;
        end else begin
            nextIns <= 1'b0;
        end
    end

endmodule
