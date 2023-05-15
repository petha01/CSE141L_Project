module LookupTable(
    input [2:0] instruction,
    output reg [7:0] out
);

    always @(*) begin
        case(instruction)
            3'b000: out = 8'b00000000; // 0
            3'b001: out = 8'b00000001; // 1
            3'b010: out = 8'b00011110; // 30
            3'b011: out = 8'b11100010; // -30 in two's complement
            3'b100: out = 8'b00000000; // Fill the rest of the table
            default: out = 8'b00000000;
        endcase
    end

endmodule
