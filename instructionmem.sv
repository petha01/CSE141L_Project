module instructionmem #(parameter PC_BITS = 12)(
    input [PC_BITS - 1:0] pc,
    output logic [2:0] instructions, reg1, reg2
);

    logic[8:0] core[2**PC_BITS];
    logic[8:0] ins;
    initial begin
        $readmemb("test_files/program1_out.txt",core);
    end

    always_comb begin
        $display("instructionmem pc: %d",pc);
        $display("instructionmem core[pc]: %d",core[pc]);
        ins = core[pc];
        $display("instructionmem ins: %d",ins);
        instructions = ins[8:6];
        $display("instructionmem instructions: %d",instructions);
        reg1 = ins[5:3];
        $display("instructionmem reg1: %d",reg1);
        reg2 = ins[2:0];
        $display("instructionmem reg2: %d",reg2);

    end

endmodule
