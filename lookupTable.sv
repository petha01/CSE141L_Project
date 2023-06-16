module LookupTable(
    input [2:0] instruction,
    output reg [7:0] out
);

    always_comb begin
        case(instruction)
            3'b000: out = 8'b01100100; // 100
            3'b001: out = 8'b00001010; // 10
            3'b010: out = 8'b00000101; // 5
            3'b011: out = 8'b00000001; // 1
            3'b100: out = 8'b00000000; // 0
            3'b101: out = 8'b11111111; // -1
            3'b110: out = 8'b11100010; // -30
            3'b111: out = 8'b11111011; // -5
            default: out = 8'b00000000;
        endcase
    end

endmodule
