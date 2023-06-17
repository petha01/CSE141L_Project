module programcounter #(parameter PC_BITS = 12)(
    input jumpFlag, start, clock,
    input [7:0] target,
    output logic [PC_BITS - 1:0] pc
);

logic[1:0] counter = 2'b11;

    always_ff @ (posedge clock) begin
            counter <= 2'b00;
            if (start) begin
                pc <= 0;
            end  else if (jumpFlag) begin
                // pc <= pc - target;
                if (target == 8'b11111111) begin
                    pc <= 9'b111010110; // 470
                end
                else if (target == 8'b11111111) begin
                    pc <= 9'b110110011; // 435
                end
                else begin
                    pc <= target;
                end
            end else begin
                pc <= pc + 'b1;
            end
        $display("Program Counter pc: %d",pc);

    end

endmodule
