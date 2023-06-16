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
        if (memWrite) begin
            core[addr] <= data_in;
            $displayb("DataMem addr: %d", addr);
            $displayb("DataMem data_in: %d", data_in);
        end
    
    end
endmodule