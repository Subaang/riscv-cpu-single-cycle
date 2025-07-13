module Top (
    input logic CLK,
    input logic RST
);

    logic [31:0] PC;
    logic [31:0] PCPlus4;
    logic [31:0] PCTarget;
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
    logic MemWrite;
    logic [31:0] ImmExt;
    logic [1:0] ImmSrc;
    logic PCSrc;
    logic ResultSrc;
    logic ALUSrc;

    // === Program Counter ===
    ProgramCounter pc_inst (
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

    // === Data Memory ===
     DataMemory #(
    .MEM_DEPTH(256)
     ) dmem(
        .clk(CLK),
        .A(ALUResult),
        .WD(WriteData),
        .WE(MemWrite),
        .RD(ReadData)
    );

    // === Sign Extender ===
    SignExtender extender(
        .Instr(Instr),
        .ImmSrc(ImmSrc),
        .Out(ImmExt)
    );

    assign PCPlus4 = PC + 4;
    assign PCNext = PCSrc ? PCPlus4 : PCTarget;
    assign Result = ResultSrc ? ReadData : ALUResult;
    assign PCTarget = ImmExt + PC;
    assign SrcB = ALUSrc ? ImmExt : RD2;



endmodule
