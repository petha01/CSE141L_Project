import definitions::*;
module alu(
    input [2:0] aluOp,
    input [7:0] input1, input2,
    output logic jumpFlag,
    output logic[7:0] out
);
    logic [2:0] temp;



    always_comb begin
        $displayb("ALU input1: %d", input1);
        $displayb("ALU input2: %d", input2);
        out = 0;
        case(aluOp)
            ADD : out = input1 + input2;
            XOR : out = input1 ^ input2;
            AND : out = input1 & input2;
            RSL : begin
				out[0] = input1[(0 + 7 - input2) % 7];
				out[1] = input1[(1 + 7 - input2) % 7];
				out[2] = input1[(2 + 7 - input2) % 7];
				out[3] = input1[(3 + 7 - input2) % 7];
				out[4] = input1[(4 + 7 - input2) % 7];
				out[5] = input1[(5 + 7 - input2) % 7];
				out[6] = input1[(6 + 7 - input2) % 7];
				out[7] = input1[(7 + 7 - input2) % 7];
			end
            MOV : out = input2;
            LD  : out = input2;
            ST  : out = input1;
            BLQZ: out = input2;
            default: out = 0;
        endcase

        if ((aluOp == BLQZ) && (input1 <= 0)) begin
            jumpFlag = 1;
        end else begin
            jumpFlag = 0;
        end
        $displayb("ALU inoutput1: %d", out);
        $displayb("ALU jumpFlag: %d", jumpFlag);
    end
endmodule
