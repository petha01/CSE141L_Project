import definitions::*;
module alu(
    input clock,
    input [2:0] aluOp,
    input [7:0] input1, input2,
    output jumpFlag,
    output[7:0] out
);
    logic [7:0] outVal;
    logic [2:0] temp;

    always_comb begin
        outVal = 0;
        temp = 7 - input2;
        case(aluOp)
            ADD : outVal = input1 + input2;
            XOR : outVal = input1 ^ input2;
            AND : outVal = input1 & input2;
            RSL : outVal = {input1[temp:0], input1[7:temp + 1]};
            MOV : outVal = input2;
            LD  : outVal = input1;
            ST  : outVal = input1;
            BLQZ: outVal = 0;
            default: outVal = 0;
        endcase
    end

    always_ff @ (posedge clock) begin
        out <= outVal;
        if ((aluOp == BLQZ) && (input1 == input2)) begin
            jumpFlag = 1;
        end else begin
            jumpFlag = 0;
        end
    end
endmodule