module mux2x1_Nbits #(parameter N = 8) (
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    input logic select,
    output logic [N-1:0] Y
);
    always_comb begin
        $display("mux A: %d",A);
        $display("mux B: %d",B);
        if (select == 1'b0)
            Y = A;
        else
            Y = B;
         $display("mux: %d",Y);
    end
endmodule
 