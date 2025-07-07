module InstructionMemory #(
    parameter MEM_DEPTH = 256,                // Number of 32-bit instructions
    parameter INIT_FILE = "inst_mem.hex"      // Memory init file (hex format)
) (
    input  logic [31:0] addr,                 // Byte address input
    output logic [31:0] inst                  // Output instruction
);

    // Declare memory: 256 words of 32 bits each (1 KB total)
    logic [31:0] mem [0:MEM_DEPTH-1];

    // Initialize memory from hex file
    initial begin
        $readmemh(INIT_FILE, mem);
    end

    // Combinational read from instruction memory (word-aligned)
    assign inst = mem[addr[9:2]];

endmodule
