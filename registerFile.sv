module registerFile#(parameter pw=3)(
    input clock, immediate, regWrite,
    input [2:0] readRegister1, readRegister2,
    input [7:0] ltValue, writeData,
    output logic [7:0] readData1, readData2
);

    logic [7:0] registers[7:0];

    always_comb begin
        if (immediate) begin
            readData1 = registers[readRegister1];
            readData2 = ltValue;
            $display("Register File readData1: %d",registers[readRegister1]);
            $display("Register File readData2: %d",ltValue);
        end

        else begin
            readData1 = registers[readRegister1];
            readData2 = registers[readRegister2];
            $display("Register File readData1: %d",registers[readRegister1]);
            $display("Register File readData2: %d",registers[readRegister2]);
        end
    end

    always_ff @(posedge clock) begin
        $display("Register File readRegister1: %d",readRegister1);
        $display("Register File readRegister2: %d",readRegister2);

        if (regWrite) begin
            $display("Register File writeData: %d",writeData);
            registers[readRegister1] <= writeData;
        end

        // if (immediate) begin
        //     readData1 <= registers[readRegister1];
        //     readData2 <= ltValue;
        //     $display("Register File readData1: %d",registers[readRegister1]);
        //     $display("Register File readData2: %d",ltValue);
        // end

        // else begin
        //     readData1 <= registers[readRegister1];
        //     readData2 <= registers[readRegister2];
        //     $display("Register File readData1: %d",registers[readRegister1]);
        //     $display("Register File readData2: %d",registers[readRegister2]);
        // end
    end

    // logic[7:0] core[2**pw];						// Register core/space

    // // Output Read data 1 & Read data 2
    // assign readData1 = core[readRegister1];
    // assign readData2 = core[readRegister2];

    // // Write register logic
    // always_ff @(posedge clock) begin
    //     if (regWrite)
    //         core[writeRegister] <= writeData;			// Write register with dat_in

    // end
endmodule
