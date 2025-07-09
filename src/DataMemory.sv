module DataMemory #(
    parameter MEM_DEPTH = 256
) (
    input  logic        clk,
    input  logic [31:0] A,       // Byte address
    input  logic [31:0] WD,      // Write data
    input  logic        WE,      // Write enable
    output logic [31:0] RD       // Read data
);

    localparam ADDR_BITS = $clog2(MEM_DEPTH);
    logic [31:0] mem [0:MEM_DEPTH-1];

    always_ff @(posedge clk) begin
        if (WE)
            mem[A[ADDR_BITS+1 : 2]] <= WD;
    end

    assign RD = mem[A[ADDR_BITS+1 : 2]];

endmodule
