module LookupTable(
    input [2:0] instruction,
    output reg [7:0] out
);

    always @(*) begin
        case(instruction)
            3'b000: out = 100; // 0
            3'b001: out = 10; // 1
            3'b010: out = 5; // 30
            3'b011: out = 1; // -30 in two's complement
            3'b100: out = 0;
            3'b101: out = -1;
            3'b110: out = -30;
            3'b111: out = -5;
            default: out = 8'b00000000;
        endcase
    end

endmodule
