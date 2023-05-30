package definitions;

    typedef enum logic [2:0] { 
        ADD     = 3'b000,
        XOR     = 3'b001,
        AND     = 3'b010,
        RSL     = 3'b011,
        MOV     = 3'b100,
        LD      = 3'b101,
        ST      = 3'b110,
        BLQZ    = 3'b111
     } aluOp;

     typedef enum logic [1:0] { 
        PC              = 2'b00,
        REGISTERREAD    = 2'b01,
        DATAMEM         = 2'b10,
        REGISTERWRITE   = 2'b11;
      } state;

endpackage