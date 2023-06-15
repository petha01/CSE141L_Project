module programcounter #(parameter PC_BITS = 12)(
    input jumpFlag, start, clock,
    input [7:0] target,
    output logic [PC_BITS - 1:0] pc
);

    always_ff @ (posedge clock) begin
        if (start) begin
            pc <= 0;
        end  else if (jumpFlag) begin
            pc <= pc - target;
        end else begin
            pc <= pc + 'b1;
        end
    end

endmodule
