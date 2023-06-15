module programcounter #(parameter PC_BITS = 12)(
    input nextIns, jumpFlag, start, clock,
    input [PC_BITS - 1:0] pc_in, startingAddress, doneAddress,
    input [7:0] target,
    output logic [PC_BITS - 1:0] pc_out,
    output logic done
);

    always_ff @ (posedge clock) begin
        // $displayb("In program counter: %d", pc_in);
        if (start) begin
            pc_out <= startingAddress;
            done <= 0;
        end else if (pc_in == doneAddress) begin
            pc_out <= pc_in;
            done <= 1;
        end else if (nextIns && jumpFlag) begin
            pc_out <= pc_in - target;
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
