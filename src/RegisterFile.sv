module RegisterFile (
    input  logic        clk,
    input  logic [4:0]  A1,   
    input  logic [4:0]  A2,   
    input  logic [4:0]  A3,   
    input  logic [31:0] WD3,  
    input  logic        WE3,  

    output logic [31:0] RD1,  
    output logic [31:0] RD2   
);

    logic [31:0] registers [0:31];

    always_ff @(posedge clk) begin
        if (WE3 && A3 != 5'd0) begin
            registers[A3] <= WD3;
        end
    end


    //Read is asynchronous
    assign RD1 = (A1 == 5'd0) ? 32'd0 : registers[A1];
    assign RD2 = (A2 == 5'd0) ? 32'd0 : registers[A2];

endmodule
