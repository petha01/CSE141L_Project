import definitions::*;
module control (
    input [2:0] instructions,
    output logic [2:0] aluOp,
    output logic immediate, regWrite, memWrite, memToReg
);

always_comb begin
    // Default values
    aluOp = instructions;
    immediate = 0;
    regWrite = 0;
    memWrite = 0;
    memToReg = 0;
    $display("Control status: %d",instructions);
    case(aluOp)
            ADD : begin
                regWrite = 1;
			end

            XOR : begin
                regWrite = 1;
			end

            AND : begin
                regWrite = 1;
			end

            RSL : begin
                regWrite = 1;
			end

            MOV : begin
                regWrite = 1;
                immediate = 1;
			end

            LD  : begin
                regWrite = 1;
                memToReg = 1;
			end

            ST  : begin
                memWrite = 1;
			end

            BLQZ: begin
                // do nothing
			end

            default: begin
                // do nothing
			end

    endcase
end

endmodule
