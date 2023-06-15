module registerFile(
    input clock, immediate, regWrite,
    input [2:0] readRegister1, readRegister2,
    input [7:0] ltValue, writeData,
    output logic [7:0] readData1, readData2
);

    logic [7:0] registers[7:0];

    always_ff @(posedge clock) begin
        // $display("Register File readRegister1: %d",readRegister1);
        // $display("Register File readRegister2: %d",readRegister2);

        if (regWrite) begin
            $display("Register File writeData: %d",writeData);
            registers[readRegister1] <= writeData;
        end

        if (immediate) begin
            readData1 <= registers[readData1];
            readData2 <= ltValue;
            // $display("Register File readData1: %d",readData1);
            // $display("Register File readData2: %d",readData2);
        end

        else begin
            readData1 <= registers[readData1];
            readData2 <= registers[readData2];
            // $display("Register File readData1: %d",readData1);
            // $display("Register File readData2: %d",readData2);
        end
    end

endmodule
