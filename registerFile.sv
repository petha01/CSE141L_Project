module registerFile(
    input clock, immediate, regWrite,
    input [2:0] readRegister1, readRegister2, writeRegister,
    input [7:0] ltValue, writeData,
    output [7:0] readData1, readData2
);

    logic [7:0] registers[7:0];

    always_ff @(posedge clock) begin
        if (regWrite) begin
            registers[readRegister1] <= writeData;
        end

        if (immediate) begin
            readData1 <= registers[readData1];
            readData2 <= ltValue;
        end

        else begin
            readData1 <= registers[readData1];
            readData2 <= registers[readData2];
        end
    end

endmodule