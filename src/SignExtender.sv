module SignExtender (
    input  logic [31:0] Instr,
    input  logic [1:0]  ImmSrc,
    output logic [31:0] Out
);

    always_comb begin
        case (ImmSrc)
            // I-type
            2'b00: Out = {{20{Instr[31]}}, Instr[31:20]};

            // S-type
            2'b01: Out = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};

            // B-type
            2'b10: Out = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};

        endcase
    end

endmodule
