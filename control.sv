import definitions::*;
module control (
    input clock,
    input [2:0] instructions,
    output [2:0] aluOp,
    output nextIns, immediate, regWrite, memWrite, memToReg
);

    logic [2:0] currentState, nextState;
    
    always_ff @ (posedge clock) begin
        case (currentState)
            PC: begin
                nextState <= REGISTERFILE;
                nextIns <= 1;
                immediate <= 0;
                regWrite <= 0;
                memWrite <= 0;
                memToReg <= 0;
            end

            REGISTERFILE: begin
                nextState <= ALU;
                nextIns <= 0;
                immediate <=;
                regWrite <=;
                memWrite <=;
                memToReg <=;
            end

            ALU: begin
                nextState <= DATAMEM;
                nextIns <= 0;
                immediate <= 0;
                regWrite <= 0;
                memWrite <= 0;
                memToReg <=;
            end

            DATAMEM: begin
                nextState <= PC;
                nextIns <= 0;
            end
            default: 
        endcase

        currentState <= nextState;
        aluOp <= instructions;
    end

endmodule