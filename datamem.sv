module datamem(
    input clock, memWrite,
    input [7:0] addr, data_in,
    output [7:0] data_out
);

    logic[7:0] core[256];

    initial begin
        // $readmemh("filename.list", core);
    end

    assign data_out = core[addr];

    always_ff @ (posedge clock) begin
        // $displayb("data out: %d", data_out);
        if (memWrite) begin
            core[addr] <= data_in;
            // $displayb("Printing data in: %d, address: %d", data_in, addr);
        end
    end
endmodule