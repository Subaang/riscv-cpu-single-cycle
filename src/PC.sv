module PC(
    input logic clk
    input  logic [31:0] PCNext,                 
    output logic [31:0] PC   
);

always_ff @(posedge clk) begin
    PC <= PCNext;
end

endmodule