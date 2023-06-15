import definitions::*;
module control (
    input clock,
    input [2:0] instructions,
    output logic [2:0] aluOp,
    output logic nextIns, immediate, regWrite, memWrite, memToReg
);

    logic [2:0] currentState, nextState;

    always_ff @ (posedge clock) begin
        // $displayb("In control, state: %d", currentState);
        case (currentState)
            PC: begin
                $displayb("Control: PC");
                nextState <= REGISTERREAD;
                nextIns <= 1;
                immediate <= 0;
                regWrite <= 0;
                memWrite <= 0;
                memToReg <= 0;
            end

            REGISTERREAD: begin
                $displayb("Control: REGISTERREAD");
                nextState <= DATAMEM;
                nextIns <= 0;
                regWrite <= 0;
                memWrite <= 0;
                memToReg <= 0;
                if (instructions == MOV) begin
                    immediate <= 1;
                end else begin
                    immediate <= 0;
                end
            end

            DATAMEM: begin
                $displayb("Control: DATAMEM");
                nextState <= REGISTERWRITE;
                nextIns <= 0;
                immediate <= 0;
                regWrite <= 0;

                if (instructions == ST) begin
                    $displayb("store instruction");
                    memWrite <= 1;
                end else begin
                    memWrite <= 0;
                end

                if (instructions == LD) begin
                    memToReg <= 1;
                end else begin
                    memToReg <= 0;
                end
            end

            REGISTERWRITE: begin
                $displayb("Control: REGISTERWRITE");
                nextState <= PC;
                nextIns <= 0;
                immediate <= 0;
                memWrite <= 0;
                memToReg <= 0;
                // If statement is true for ADD, XOR, AND, RSL MOV
                if (instructions <= MOV) begin
                    regWrite <= 1;
                end else begin
                    regWrite <= 0;
                end
            end

            default: begin
                $displayb("Control: default");
                nextState <= PC;
                nextIns <= 0;
                immediate <= 0;
                memWrite <= 0;
                memToReg <= 0;
                regWrite <= 0;
            end
        endcase

        currentState <= nextState;
        aluOp <= instructions;
    end

endmodule
