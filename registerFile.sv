module registerFile(
    input clock, immediate, regWrite,
    input [2:0] readRegister1, readRegister2,
    input [7:0] ltValue, writeData,
    output logic [7:0] readData1, readData2
);

    logic [7:0] registers[7:0];

    always_ff @(posedge clock) begin
        // $displayb("readRegister1: %d", readRegister1);
        // $displayb("readRegister2: %d", readRegister2);

        if (regWrite) begin
            // $displayb("writeData: %d", writeData);
            registers[readRegister1] <= writeData;
        end

        if (immediate) begin
            // $displayb("ltValue: %d", ltValue);
            readData1 <= registers[readData1];
            readData2 <= ltValue;
        end

        else begin
            readData1 <= registers[readData1];
            readData2 <= registers[readData2];
        end
    end

endmodule
