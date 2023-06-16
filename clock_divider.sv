module clock_divider (
    input logic clkin,
    output logic clkout
);

    logic [1:0] div_count;

    always_ff @ (clkin) begin
        case (div_count)
            2'b00: begin
                div_count <= 2'b01;
                clkout <= 1'b0;
            end
            2'b01: begin
                div_count <= 2'b10;
                clkout <= 1'b0;
            end
            2'b10: begin
                div_count <= 2'b11;
                clkout <= 1'b1;
            end
            2'b11: begin
                div_count <= 2'b00;
                clkout <= 1'b1;
            end
            default: begin
                div_count <= 2'b00;
                clkout <= 1'b1;
            end
        endcase
    end
endmodule