module programcounter (
    input nextIns, jumpFlag, start, clock
    input [11:0] pc_in, startingAddress,
    input [7:0] target,
    output [11:0] pc_out
);
    
    always_ff @ (posedge clock) begin
        if (start) begin
            pc_out = startingAddress;
        end else if (nextIns && jumpFlag) begin
            pc_out = pc_in + 1 + target;
        end else if (nextIns) begin
            pc_out = pc_in + 1;
        end else begin
            pc_out = pc_in;
        end
    end

endmodule