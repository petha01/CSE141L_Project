module programcounter (
    input nextIns, jumpFlag, start, clock,
    input [8:0] pc_in, startingAddress, doneAddress,
    input [7:0] target,
    output [11:0] pc_out,
    output done
);
    
    always_ff @ (posedge clock) begin
        if (start) begin
            pc_out <= startingAddress;
            done <= 0;
        end else if (pc == doneAddress) begin
            pc_out <= pc_in;
            done <= 1;
        end else if (nextIns && jumpFlag) begin
            pc_out <= pc_in + 1 + target;
            done <= 0;
        end else if (nextIns) begin
            pc_out <= pc_in + 1;
            done <= 0;
        end else begin
            pc_out <= pc_in;
            done <= 0;
        end
    end

endmodule