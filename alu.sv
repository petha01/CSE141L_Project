import definitions::*;
module alu(
    input [2:0] aluOp,
    input [7:0] input1, input2,
    output jumpFlag,
    output[7:0] out
);
    logic [7:0] outVal;
    logic [2:0] temp;
	 
    always_comb begin
        outVal = 0;
        case(aluOp)
            ADD : outVal = input1 + input2;
            XOR : outVal = input1 ^ input2;
            AND : outVal = input1 & input2;
            RSL : begin
				outVal[0] = input1[(0 + 7 - input2) % 7];
				outVal[1] = input1[(1 + 7 - input2) % 7];
				outVal[2] = input1[(2 + 7 - input2) % 7];
				outVal[3] = input1[(3 + 7 - input2) % 7];
				outVal[4] = input1[(4 + 7 - input2) % 7];
				outVal[5] = input1[(5 + 7 - input2) % 7];
				outVal[6] = input1[(6 + 7 - input2) % 7];
				outVal[7] = input1[(7 + 7 - input2) % 7];
			end
            MOV : outVal = input2;
            LD  : outVal = input2;
            ST  : outVal = input1;
            BLQZ: outVal = 0;
            default: outVal = 0;
        endcase

        out <= outVal;
        if ((aluOp == BLQZ) && (input1 <= 0)) begin
            jumpFlag = 1;
        end else begin
            jumpFlag = 0;
        end
    end
endmodule