module Top (
    input logic clk,
    input logic reset
);

    // === Program Counter wires ===
    logic [31:0] pc;
    logic [31:0] pc_next;

    // === Instruction fetched from memory ===
    logic [31:0] instruction;

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

endmodule
