module mux2x1 (
    input logic A,
    input logic B,
    input logic select,
    output logic Y
);
    always_comb begin
        if (select == 1'b0)
            Y = A;
        else
            Y = B;
    end
endmodule
