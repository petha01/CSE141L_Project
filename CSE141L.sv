module CSE141L;


  LookupTable lookup_table_inst (
    .instruction(instruction),     
    .out(out)                
  );


  wire [2:0] instruction;
  wire [7:0] out;

endmodule
