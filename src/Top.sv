module Top (
    input logic clk,
    input logic reset
);

    // === Program Counter wires ===
    logic [31:0] pc;
    logic [31:0] pc_next;

    // === Instruction fetched from memory ===
    logic [31:0] instruction;

    // === RegFile ===
    logic [31:0] srcA;
    logic [31:0] srcB;
    logic [31:0] write_data;
    logic reg_write_enable;
    logic [31:0] result;

    
    

    // === PC Module ===
    PC pc_inst (
        .clk    (clk),
        .rst    (reset),
        .PCNext (pc_next),
        .PC     (pc)
    );

    // === Instruction Memory ===
    InstructionMemory #(
        .MEM_DEPTH(256),
        .INIT_FILE("inst_mem.hex")
    ) imem (
        .addr (pc),
        .inst (instruction)
    );

    // === Register File ===
    RegisterFile reg_file(
        .clk(clk),
        .A1(instruction[19:15]),
        .A2(instruction[24:20]),
        .A3(instruction[11:7]),
        .RD1(srcA),
        .RD2(write_data),
        .WD3(result)
    );

endmodule
