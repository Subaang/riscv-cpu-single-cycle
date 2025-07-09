module ALU (
    input  logic [2:0]  ALUControl,
    input  logic [31:0] A,
    input  logic [31:0] B,
    output logic        Zero,
    output logic [31:0] Result
);

    always_comb begin
        case (ALUControl)
            3'd0: Result = A + B;         // ADD
            3'd1: Result = A - B;         // SUB
            3'd2: Result = A & B;         // AND
            3'd3: Result = A | B;         // OR
            3'd4: Result = (A < B) ? 32'd1 : 32'd0;  // SLT
            default: Result = 32'd0;
        endcase
    end

    assign Zero = (Result == 32'd0);  

endmodule
