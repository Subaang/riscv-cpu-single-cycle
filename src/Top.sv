module Top (
    input logic CLK,
    input logic RST
);

    logic [31:0] PC;
    logic [31:0] PCNext;
    logic [31:0] Instr;
    logic [31:0] SrcA ;
    logic [31:0] SrcB;
    logic [31:0] WriteData;
    logic RegWrite;
    logic [31:0] Result;
    logic [31:0] ALUResult;
    logic [31:0] ReadData;
    logic [2:0] ALUControl;
    logic Zero;

    // === PC Module ===
    PC pc_inst (
        .clk    (CLK),
        .PCNext (PCNext),
        .PC     (PC)
    );

    // === Instruction Memory ===
    InstructionMemory #(
        .MEM_DEPTH(256),
        .INIT_FILE("inst_mem.hex")
    ) imem (
        .addr (PC),
        .inst (Instr)
    );

    // === Register File ===
    RegisterFile reg_file(
        .clk(CLK),
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .RD1(SrcA),
        .RD2(WriteData),
        .WD3(RegWrite)
    );

    // === ALU ===
    ALU alu(
        .ALUControl(ALUControl),
        .A(SrcA),
        .B(SrcB),
        .Zero(Zero),
        .Result(ALUResult)
    ); 

endmodule
