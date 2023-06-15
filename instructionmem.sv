module instructionmem #(parameter PC_BITS = 12)(
    input [PC_BITS - 1:0] pc,
    output [2:0] instructions, reg1, reg2
);

    logic[8:0] core[2**PC_BITS];
    logic[8:0] ins;
    initial begin
        $readmemb("test_files/program1_out.txt",core);
    end

    always_comb begin
        ins = core[pc];
        instructions = ins[8:6];
        reg1 = ins[5:3];
        reg2 = ins[2:0];
    end
    
endmodule