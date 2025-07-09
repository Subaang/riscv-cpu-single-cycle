module InstructionMemory #(
    parameter MEM_DEPTH  = 256,                // Number of 32-bit instructions
    parameter INIT_FILE  = "inst_mem.hex"      // Memory init file (hex format)
) (
    input  logic [31:0] addr,                  // Byte address input
    output logic [31:0] inst                   // Output instruction
);

    // Calculate how many address bits are needed for MEM_DEPTH
    localparam ADDR_BITS = $clog2(MEM_DEPTH);

    // Declare memory: MEM_DEPTH words of 32 bits each
    logic [31:0] mem [0:MEM_DEPTH-1];

    // Initialize memory from hex file
    initial begin
        $readmemh(INIT_FILE, mem);
    end

    // Combinational read from instruction memory (word-aligned)
    assign inst = mem[addr[ADDR_BITS+1 : 2]];

endmodule
